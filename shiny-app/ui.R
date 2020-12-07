########## PREP ##########

library(shiny)
library(shinythemes)
library(tidyverse)
library(readxl)
library(janitor)
library(gt)
library(gtsummary)
library(broom.mixed)
library(rstanarm)

# Read in RDS.

avg_nfl_home_score <- readRDS(file = "nfl_avg_home_scores.RDS")
avg_nba_home_score <- readRDS(file = "nba_avg_home_scores.RDS")
avg_mlb_home_score <- readRDS(file = "mlb_avg_home_scores.RDS")
nfl_model <- readRDS(file = "nfl_model.RDS")
nba_model <- readRDS(file = "nba_model.RDS")
mlb_complex_model <- readRDS(file = "mlb_model_complex.RDS")

# Define UI for application that draws a histogram
shinyUI(
    navbarPage(
    
# Here, I am setting the theme for my Shiny App.
        theme = shinytheme("flatly"),
    
#Here, I am setting the title of my Shiny App.
        "Home Field Advantage in the NFL, MLB, and NBA",
    
########## INTRODUCTION ##########

    # Introduction Tab setup

    tabPanel("Introduction",
             
             fluidPage(

                 fluidRow(column(6,
                 
                                 # Background Section. Text extends beyond the
                                 # line when it is a long link.
                                 
                                 h2("What is Home Field Advantage? And Why Does 
                                    It Matter, Anyway?"),
                                 p(strong("Home field advantage"), "is the 
                                 supposed benefit that a team enjoys when they 
                                 play in their home stadium as opposed to when 
                                 they go and play in other venues as visitors. 
                                 This benefit is attributed to a variety of 
                                 factors, including fans and referee bias. The 
                                 concept of home field advantage has been taken 
                                   as a maxim for years by players, coaches, 
                                   management, and fans alike. In fact, home 
                                   field advantage is so ingrained in sports 
                                   ulture that virtually all American sports 
                                   leagues – from high school tournaments all 
                                   the way up to Big Four – award home field 
                                   privileges throughout the playoffs to the 
                                   top seeded team from the regular season. 
                                   Recently, though, there are growing murmurs 
                                   in the sports world that", 
                                   a("home field advantage is not what it used 
                                     to be.", href = "https://www.nytimes.com/2020/01/10/sports/football/road-team-advantage.html"),
                                   "So,", strong("does home field advantage 
                                                 actually matter?")),
                                 
                                 
                                 # Motivations Section. Text extends beyond the
                                 # line when it is a long link.
                                 
                                 h2("The Purpose of this Project"),
                                 p("The purpose of this project is to explore 
                                 whether home field advantage actually matters 
                                   – and more. If home field advantage does 
                                   matter, how many more points can teams in the 
                                   NFL, NBA, and MLB expect to get when playing 
                                   at home as opposed to when they play as 
                                   visitors? How has home field advantage in 
                                   these three leagues changed over time? This 
                                   project will endeavor to provide answers to 
                                   these questions by analyzing data on home vs.
                                   away scores of teams in all three leagues 
                                   throughout the years."),
                                 
                                 p("All of the questions posed above have become 
                                   more relevant in the wake of the COVID-19 
                                   pandemic, as American sports leagues have 
                                   been forced to put on games with little to 
                                   no fan presence in the stadiums. Not only 
                                   have these COVID regulations erased the 
                                   opportunity for sports fans to go see the 
                                   teams they love, but they have also", 
                                   a("diminished the sports watching experience 
                                     on TV aswell.", href = "https://www.nytimes.com/2020/05/20/sports/coronavirus-sports-fans.html"),
                                   "Moreover, athletes have claimed that they", 
                                   a("depend on the energy of fans during their 
                                     games,", href = "https://apnews.com/article/523715605c0353939e563cd57f604284"), 
                                   "meaning the lack of fans in stadiums could 
                                   impact athletic performance on the field as 
                                   well. Recognizing the impact of COVID-19,", 
                                   strong("this project will use data up to the 
                                          last games in each of the three 
                                          leagues that were not impacted by 
                                          COVID regulations.")), 
                                 
                                 p(em("PSA: COVID-19 is an extremely deadly 
                                      disease which has killed almost 1.5 
                                      million people worldwide (as of December 
                                      2, 2020) and has impacted the lives of 
                                      countless others. Fighting the virus is 
                                      infinitely more important than any fan 
                                      experience at a sports game. Follow COVID 
                                      regulations wherever they are present to 
                                      do your part in ensuring that fans around 
                                      the world can return to stadiums to 
                                      support their teams soon.")),
                                 
                                 ),
                 
                 column(4,
                 
                        # How to navigate this app section.
                        
                        h3("How to Navigate this Project"),
                        
                        p("This project is divided into seperate tabs for each
                        league – NFL, NBA, and MLB. Each tab contains 
                        an interactive visualization where you will be able to 
                          choose a team and a range of seasons to view 
                          predictions for home and away scores for that team in 
                          those seasons. At the bottom, each tab also contains a 
                          table of values representing the results of models 
                          that were developed using data from the leagues. Each 
                          model produces predictions for the entire league 
                          across all of the seasons I have data for."),
                        
                        p("Confused? Never fear! I have provided detailed 
                          analysis and reasoning for all of my models, and I 
                          will thoroughly discuss the meaning and significance 
                          of my outputs."),
                        
                        # Disclaimers section.
                        
                        h3("Disclaimers"),
                        
                        h4("Score as Model Output"),
                        
                        p("For the purposes of this project, I use", 
                          strong("the amount of points/runs a team would score – 
                          referred to in my models as \"score\" as the output of
                          my models."), "This means that I will", em("mostly"), 
                          "be predicting the potential benefits of home field 
                          advantage towards", strong("offensive output.")),
                        
                        p("This disclaimer is important to understand, as",
                          em("the amount of points a team scores does NOT 
                          strongly take into account the defensive performance of 
                          a team."), "This statement is least true for the NFL, 
                          where there are direct defensive opportunities to 
                          score, i.e., off of an intercepted pass or a fumble. 
                          For the NBA, where the delineation between a defensive
                          and offensive possession of the ball is very fluid, 
                          the score may also provide a small amount of insight 
                          for the defensive performance for a team, in that the 
                          more defensive rebounds and steals a team gets, the 
                          more chances they will have to score on a fast break. 
                          In both the NFL and NBA, time is limited in games, so 
                          good defense may also lead to greater time possessing 
                          the ball, which in turn can oftentimes lead to higher 
                          scores."),
                        
                        p("For the MLB, however,", em("the number of runs a team
                         scores only provides as to how the team performed 
                         offensively."), "How many runs scored provides no 
                          information as to how the pitchers pitched or how the 
                          defense played. When viewing the MLB models, it is 
                          therefore", em("very important you keep this 
                        disclaimer regarding score as the output in mind!"))
                        
                        )
                 
                 )),
             
             
             # Graphs of Average Home Scores for All Leagues
             
             h2("Average Home Scores of Teams in the NFL, NBA, and MLB Over the 
                Years"),
             p("Here are some visualizations of the average home scores of all
               of the teams in the NFL, NBA, and MLB over the full range of 
               seasons I have data for."),
             
             # Creating interactive graph display, where the user can choose to
             # view home or away graphs for the three leagues.
             
             h2("NFL – National Football League"),
             plotOutput("NFLHomeAvg"),
             plotOutput("NFLAwayAvg"),
             
             h2("NBA – National Basketball Association"),
             plotOutput("NBAHomeAvg"),
             plotOutput("NBAAwayAvg"),
             
             h2("MLB – Major League Baseball"),
             plotOutput("MLBHomeAvg"),
             plotOutput("MLBAwayAvg")
             
),

########## NFL ##########

# NFL Tab setup.

tabPanel("NFL",
         
         h2("Linear Regressions for the NFL with Score as Output and Home as 
            Predictor"),
             
         # Creating sidebar for interactive model inputs.
         
         sidebarLayout( 
            
             sidebarPanel(
                 
                 p("Choose a team and a range of seasons to view a posterior 
                   distribution of predicted home scores and predicted away 
                   scores."),
                 
                 # Specifying inputs for interactive model. You can choose a
                 # team and a range of seasons to display a posterior
                 # distribution of home vs. away predicted scores.
                 
                 selectInput(inputId = "user_nfl_team", 
                             label = "Team", 
                             choices = c("Arizona Cardinals",
                                         "Atlanta Falcons",
                                         "Baltimore Ravens",
                                         "Buffalo Bills",
                                         "Carolina Panthers",
                                         "Chicago Bears",
                                         "Cincinnati Bengals",
                                         "Cleveland Browns",
                                         "Dallas Cowboys",
                                         "Denver Broncos",
                                         "Detroit Lions",
                                         "Green Bay Packers",
                                         "Houston Texans",
                                         "Indianapolis Colts",
                                         "Jacksonville Jaguars",
                                         "Kansas City Chiefs",
                                         "Las Vegas Raiders",
                                         "Los Angeles Chargers",
                                         "Los Angeles Rams",
                                         "Miami Dolphins",
                                         "Minnesota Vikings",
                                         "New England Patriots",
                                         "New Orleans Saints",
                                         "New York Giants",
                                         "New York Jets",
                                         "Philadelphia Eagles",
                                         "Pittsburgh Steelers",
                                         "San Francisco 49ers",
                                         "Seattle Seahawks",
                                         "Tampa Bay Buccaneers",
                                         "Tennessee Titans",
                                         "Washington Football Team"),
                             selected = "New England Patriots"),
                 
                 sliderInput(inputId = "user_nfl_season",
                             label = "Season(s)",
                             min = 1966,
                             max = 2019,
                             value = c(1966, 2019),
                             sep = "")
                 
             ),
         
        mainPanel(
            
         # Displaying NFL Interactive Graph.
         
         h3("NFL Teams Interactive Model"),
         plotOutput("NFLModelInteractive"),
         
         # Displaying NFL Model Table.
             
        h3("NFL Model"),
        tableOutput("NFLModelTable")
        )
        
)
),

########## NBA ##########

# NBA Tab setup.

tabPanel("NBA",
         
         # NBA Model Table
         
         h1("Linear Regression for the NBA with Score as Output and Home as 
            Predictor"),
         
         # h2("The Equation"),
         # uiOutput("reg_eq"),
         
         
         h2("NBA Model"),
         tableOutput("NBAModelTable")
         
),

########## MLB: A DEEPER DIVE ##########

# MLB Tab setup.

tabPanel("MLB: A Deeper Dive",
         
         # MLB Complex Model Table
         
         h1("Linear Regression for the MLB with Score as Output and Home, 
             Attendance, and their Interaction as Predictors"),
         
         # h2("The Equation"),
         # uiOutput("mlb_reg_eq"),
         
         
         h2("MLB Complex Model"),
         tableOutput("MLBComplexModelTable")
         
),

########## ABOUT ##########

# About Tab setup. 

tabPanel("About",
         
         # About Me Section. Text extends beyond the line when it is a long
         # link.
         
         h1("About Me"),
         p("My name is Alexander Park and I am pursuing an A.B. in Government 
         with a specialization in Public Policy and a secondary in Economics at 
         Harvard University. I will graduate in the spring of 2023. I am a 
         lifelong Boston sports fan, especially of the Patriots, Red Sox, and 
         Celtics. Besides sports, I have passions for American and Korean 
         politics, U.S. foreign policy, and the processes of and motivations 
         behind democratization. You can reach me at", 
           a("apark@college.harvard.edu", href = "mailto:apark@college.harvard.edu"),
           "."),
         
         # Project Motivations Section
         
         h1("Project Motivations"),
         p("This is my final project for GOV 50: Data at Harvard University. As 
         a Boston sports fan, I am used to having home field advantage in the 
         playoffs. Therefore, I wanted to use data analysis to determine 
         quantitatively how much home field advantage actually matters in my 
         three favorite leagues: the NFL, NBA, and MLB. In finding all of this 
         out, I hope to contribute to the sports-watching experience for fans 
         around the country and the world – especially for my fellow 
         Bostonians."),
         
         # Data Section. Text extends beyond the line when it is a long link.
         
         h1("The Data"),
         
         h3("NFL Data"),
         p("I obtained NFL scores from the 1966 season onwards from", a("Kaggle 
         user spreadspoke.", href = "https://www.kaggle.com/tobycrabtree/nfl-scores-and-betting-data")),
         
         h3("NBA Data"),
         p("I obtained NBA scores from the 2004 season onwards from", a("Kaggle
         user Nathan Lauga.", href = "https://www.kaggle.com/nathanlauga/nba-games")),
         
         h3("MLB Data"),
         p("I obtained MLB scores from the 1947 season onwards from", 
           a("FiveThirtyEight's mlb-elo data set.", href = "https://data.fivethirtyeight.com/")),
         
         p("I obtained MLB attendance data from the 1947 season onwards from",
           a("Sean Lahman's Baseball Database.", href = "http://www.seanlahman.com/baseball-archive/statistics/")),
         
         h3("GitHub"),
         p("Here is the link to this project's", a("GitHub repository.", 
                                                   href = "https://github.com/alexanderkpark/home-field-advantage")),
         
         # Acknowledgements Section.
         
         h1("Acknowledgements"),
         p("I am grateful for the guidance that", strong("Wyatt Hurt"), "and",
           strong("Tyler Simko"), "have given me throughout this semester. 
         Without their instruction and advice, I would not have been able to 
         develop this project and start my journey in the field of data 
         science.")
         
)

))
