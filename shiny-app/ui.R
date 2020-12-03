########## PREP ##########

library(shiny)
library(shinythemes)
library(tidyverse)
library(readxl)
library(janitor)
library(gt)
library(gtsummary)
library(broom.mixed)

# Read in RDS.

avg_nfl_home_score <- readRDS(file = "nfl_avg_home_scores")
avg_nba_home_score <- readRDS(file = "nba_avg_home_scores")
avg_mlb_home_score <- readRDS(file = "mlb_avg_home_scores")
nfl_model <- readRDS(file = "nfl_model")
nba_model <- readRDS(file = "nba_model")
mlb_complex_model <- readRDS(file = "mlb_model_complex")

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
             
             # Background Section. Text extends beyond the line when it is a
             # long link.
             
             h1("What is Home Field Advantage? 
                And Why Does It Matter, Anyway?"),
             p(strong("Home field advantage"), "is the supposed benefit that a 
             team enjoys when they play in their home stadium as opposed to when 
             they go and play in other venues as visitors. This benefit is 
             attributed to a variety of factors, including fans and referee 
             bias. The concept of home field advantage has been taken as a 
             maxim for years by players, coaches, management, and fans alike. 
             In fact, home field advantage is so ingrained in sports culture 
             that virtually all American sports leagues – from high school 
             tournaments all the way up to Big Four – award home field 
             privileges throughout the playoffs to the top seeded team from the 
             regular season. Recently, though, there are growing murmurs in the 
             sports world that", 
             a("home field advantage is not what it used to be.", href = "https://www.nytimes.com/2020/01/10/sports/football/road-team-advantage.html"),
             "So,", strong("does home field advantage actually matter?")),
             
             
             # Motivations Section. Text extends beyond the line when it is a
             # long link.
             
             h1("The Purpose of this Project"),
             p("The purpose of this project is to explore whether home field 
             advantage actually matters – and more. If home field advantage does
             matter, how many more points can teams in the NFL, NBA, and MLB 
             expect to get when playing at home as opposed to when they play as 
             visitors? How has home field advantage in these three leagues 
             changed over time? This project will endeavor to provide answers 
             to these questions by analyzing data on home vs. away scores of 
             teams in all three leagues throughout the years."),
             
             p("All of the questions posed above have become more relevant in 
             the wake of the COVID-19 pandemic, as American sports leagues have 
             been forced to put on games with little to no fan presence in the 
             stadiums. Not only have these COVID regulations erased the 
             opportunity for sports fans to go see the teams they love, but they 
             have also", a("diminished the sports watching experience on TV as
             well.", href = "https://www.nytimes.com/2020/05/20/sports/coronavirus-sports-fans.html"),
             "Moreover, athletes have claimed that they", a("depend on the 
             energy of fans during their games,", href = "https://apnews.com/article/523715605c0353939e563cd57f604284"), 
             "meaning the lack of fans in stadiums could impact athletic 
             performance on the field as well. Recognizing the impact of 
             COVID-19,", strong("this project will use data up to the last games 
             in each of the three leagues that were not impacted by COVID
             regulations.")), 
             
             p(em("PSA: COVID-19 is an extremely deadly disease which has 
             killed almost 1.5 million people worldwide (as of December 2, 2020) 
             and has impacted the lives of countless others. Fighting the 
             virus is infinitely more important than any fan experience at a 
             sports game. Follow COVID regulations wherever they are present to 
             do your part in ensuring that fans around the world can return to
             stadiums to support their teams soon.")),

             
             # Graphs of Average Home Scores for All Leagues
             
             h1("Average Home Scores of Teams in the NFL, NBA, and MLB Over the 
                Years"),
             p("Here are some visualizations of the average home scores of all
               of the teams in the NFL, NBA, and MLB over the years. The other
               tabs of this project will contain a variety of visualizations in 
               an effort to analyze home field advantage across these three 
               leagues."),
             
             h2("NFL – National Football League"),
             plotOutput("NFLHomeAvg"),
             
             h2("NBA – National Basketball Association"),
             plotOutput("NBAHomeAvg"),
             
             h2("MLB – Major League Baseball"),
             plotOutput("MLBHomeAvg")
             
),

########## NFL ##########

# NFL Tab setup.

tabPanel("NFL",
         
         # NFL Model Table
         
         h1("Linear Regressions for the NFL with Score as Output and Home as 
            Predictor"),
         
         # h2("The Equation"),
         # uiOutput("reg_eq"),
         
         h2("NFL Model"),
         tableOutput("NFLModelTable")
         
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
