########## PREP ##########

# Load all necessary libraries.

library(shiny)
library(shinythemes)
library(tidyverse)
library(readxl)
library(janitor)
library(gt)
library(gtsummary)
library(broom.mixed)
library(rstanarm)
library(mathjaxr)

# Define UI for my application here.

shinyUI(
    
    navbarPage(
    
# Here, I am setting the theme for my Shiny App.
        
        theme = shinytheme("flatly"),
    
#Here, I am setting the title of my Shiny App.

        "Home Field Advantage in the NFL, MLB, and NBA",
    
########## INTRODUCTION ##########

        # Introduction Tab setup

        tabPanel("Introduction",
            
            # Generate a 2x2 layout.
                 
            fluidPage(

                 fluidRow(
                     
                     column(8, 
                        
                        # Background Section.
                                 
                        h2("What is Home Field Advantage? 
                           And Why Does It Matter, Anyway?"),
                        
                        # Throughout my app, I stick to the "one line, one
                        # sentence" policy for any text I write. I make sure to
                        # keep code from spilling over the line.
                        
                        p(
                        strong("Home field advantage"), "is the supposed benefit that a team enjoys when they play in their home stadium as opposed to when they go and play in other venues as visitors. 
                        This benefit is attributed to a variety of factors, including fans and referee bias. 
                        The concept of home field advantage has been taken as a maxim for years by players, coaches, management, and fans alike. 
                        In fact, home field advantage is so ingrained in sports culture that virtually all American sports leagues – from high school tournaments all the way up to Big Four – award home field privileges throughout the playoffs to the top seeded team from the regular season. 
                        Recently, though, there are growing murmurs in the sports world that", a("home field advantage is not what it used to be.", href = "https://www.nytimes.com/2020/01/10/sports/football/road-team-advantage.html"),
                        "So,", strong("does home field advantage actually matter?")
                         ),
                                 
                        # Motivations Section.
                                 
                        h2("The Purpose of this Project"),
                        
                        p(
                        "The purpose of this project is to explore whether home field advantage actually matters – and more. 
                        If home field advantage does matter, how many more points can teams in the NFL, NBA, and MLB expect to get when playing  at home as opposed to when they play as visitors? 
                        How has home field advantage in these three leagues changed over time? 
                        This project will endeavor to provide answers to these questions by analyzing data on home vs. away scores of teams in all three leagues throughout the years."
                        ),
                                 
                        p(
                        "All of the questions posed above have become more relevant in the wake of the COVID-19 pandemic, as American sports leagues have been forced to put on games with little to no fan presence in the stadiums. 
                        Not only have these COVID regulations erased the opportunity for sports fans to go see the teams they love, but they have also", a("diminished the sports watching experience on TV as well.", href = "https://www.nytimes.com/2020/05/20/sports/coronavirus-sports-fans.html"),
                        "Moreover, athletes have claimed that they", a("depend on the energy of fans during their games,", href = "https://apnews.com/article/523715605c0353939e563cd57f604284"), 
                        "meaning the lack of fans in stadiums could impact athletic performance on the field as well. 
                        Recognizing the impact of COVID-19,", strong("this project will use data up to the last games in each of the three leagues that were not impacted by COVID regulations.")
                        ), 
                                 
                        p(
                        em("PSA: COVID-19 is an extremely deadly disease which has killed almost 1.5 million people worldwide (as of December 2, 2020) and has impacted the lives of countless others. 
                        Fighting the virus is infinitely more important than any fan experience at a sports game. Follow COVID regulations wherever they are present to do your part in ensuring that fans around the world can return to stadiums to support their teams soon.")
                        )
                        
                        ),
                          
                    column(4, align = "center",
                                   
                        # Render images.
                        
                        imageOutput("NFLLogo"),
                        
                        imageOutput("NBALogo"),
                        
                        # Citing image sources. In the case of long links, code
                        # goes over the line.
                        
                        p("Image Sources:",
                          a("NFL Logo,", href = "https://static.nfl.com/static/content/public/static/wildcat/assets/img/application-shell/shield/default.svg"),
                          a("NBA Logo."), href = "https://mediacentral.nba.com/wp-content/uploads/logos/NBA.jpg")
                        )
                    
                    ),
                 
                 fluidRow(
                     
                     column(4, align = "center",
                                
                        # Render images.
                        
                        imageOutput("MLBLogo"),
                        
                        imageOutput("FenwayScoreboard"),
                        
                        # Citing image sources. In the case of long links, code
                        # goes over the line.
                        
                        p("Image Sources:",
                          a("MLB Logo,", href = "https://en.wikipedia.org/wiki/File:Major_League_Baseball_logo.svg"),
                          a("Fenway Scoreboard."), href = "https://apnews.com/article/a8058fe68efb46bf91aa649f32c5464c")
                        ),
                     
                     column(8,
                            
                        # How to navigate this app section.
                            
                        h2("How to Navigate this Project"),
                            
                        p(
                        "This project is divided into seperate tabs for each league – NFL, NBA, and MLB. 
                        Each tab contains an interactive visualization where you will be able to choose a team and a range of seasons to view predictions for home and away scores for that team in those seasons. 
                        At the bottom, each tab also contains a table of values representing the results of models that were developed using data from the leagues. 
                        Each model produces predictions for the entire league across all of the seasons I have data for."
                        ),
                            
                        p(
                        "Confused? 
                        Never fear! 
                        I have provided detailed analysis and reasoning for all of my models, and I will thoroughly discuss the meaning and significance of my outputs."
                        ),
                            
                        # Disclaimers section.
                            
                        h2("Disclaimers"),
                            
                        h4("Score as Model Output"),
                            
                        p(
                        "For the purposes of this project, I use", strong("the amount of points/runs a team would score – referred to in my models as \"score\" – as the output of my models."), 
                        "This means that I will", em("mostly"), "be predicting the potential benefits of home field advantage towards", strong("offensive output.")
                        ),
                            
                        p(
                        "This disclaimer is important to understand, as", em("the amount of points a team scores does NOT strongly take into account the defensive performance of a team."), 
                        "This statement is least true for the NFL, where there are direct defensive opportunities to score, i.e., off of an intercepted pass or a fumble. 
                        For the NBA, where the delineation between a defensive and offensive possession of the ball is very fluid, the score may also provide a small amount of insight for the defensive performance for a team, in that the more defensive rebounds and steals a team gets, the more chances they will have to score on a fast break. 
                        In both the NFL and NBA, time is limited in games, so good defense may also lead to greater time possessing the ball, which in turn can oftentimes lead to higher scores."
                        ),
                            
                        p(
                        "For the MLB, however,", em("the number of runs a team scores only provides insight as to how the team performed offensively."), 
                        "How many runs scored provides no information as to how the pitchers pitched or how the defense played. 
                        When viewing the MLB models, it is therefore", em("very important you keep this disclaimer regarding score as the output in mind!")
                        ),
                            
                        h4("Team Names and Continuity"),
                            
                        p(
                        "For the purposes of this project, I only use modern team names. 
                        This also means that", em("ALL data from defunct teams have been assigned to successor teams."), 
                        "For example, data for the Boston Braves has been assigned to the Atlanta Braves, as the Braves moved from Boston to Milwaukee in 1953 and then to Atlanta in 1966."
                        ),
                            
                        h4("Range of Data"),
                            
                        p("This project draws on data from the NFL, NBA, and MLB. 
                        However, the amount of data I was able to find for  each league differed. 
                        For the NFL, I have data starting from the 1966 season. 
                        For the NBA, I have data starting from the 2003 season. 
                        And for the MLB, I have data for the entire history of the league. 
                        However, I have chosen to limit my analysis of the MLB to games from the 1947 season-onwards, as this was the season when racial integration was achieved in the league, so therefore can be considered the beginning of the modern MLB. 
                        Finally, as mentioned earlier, this project will not deal with data from games impacted by COVID regulations."
                        )
                            
                        )
                     
                     )
                 
                 ),
             
            # Introducing the interactive average score graph. 
            
             h2("Average Scores Home and Away for Teams in the NFL, NBA, and MLB Over the Years"),
             
             p(
             "As you can see, average home scores are higher than average  away scores for the vast majority of teams across these three leagues. 
             In the following tabs, we will take a closer look into just how important home field advantage is for each league AND for each team!"),
             
             # Creating sidebar for interactive model input.
             
             sidebarLayout( 
                 
                 sidebarPanel(
                     
                     h3("Choose League"),
                     
                     p(
                     "Choose a league from the dropdown menu to view the average home and away scores for every team in that league over the years."
                     ),
                     
                     # Specifying inputs for interactive model. You can choose
                     # home or away to see average scores across the season
                     # based on those conditions.
                     
                     selectInput(inputId = "user_league",
                                 label = "League",
                                 choices = c("MLB",
                                             "NBA",
                                             "NFL"),
                                 selected = "NFL"),
                     
                     p(strong("MLB"), 
                     "data from 1947 season (racial integration) to 2019 season (pre-COVID)."),
                     
                     p(strong("NBA"),
                       "data from 2003 season to March 2020 (pre-COVID)."),
                     
                     p(strong("NFL"),
                       "NFL data from 1966 season to 2019 season (pre-COVID).")
                     
                    ),
                 
                 mainPanel(
                     
                     # Displaying Average Score Graph.
                     
                     plotOutput("AvgScoreInteractive")
                     
                    )
                 
                 )

    ),
             

########## NFL ##########

# NFL Tab setup.

    tabPanel("NFL",
             
         h2("Model of Linear Regression for the NFL with Score as Output and Home as Predictor"),
         
         # Creating sidebar for interactive model inputs.
         
         sidebarLayout( 
            
             sidebarPanel(
                 
                 h3("NFL Dashboard"),
                 
                 p(
                 "Choose a team and a range of seasons to view a posterior distribution of predicted home scores and predicted away scores."
                 ),
                 
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
                             sep = ""),
                 
                 # Disclaimer for the model.
                 
                 h4("Season Limits"),
                 
                 p(
                 "Many teams were founded after the 1966 season. 
                 For these teams, inputting seasons before their founding will result in an innacurate visualization.", 
                 em("Please do NOT input seasons that occurred before teams' foundings!"), 
                 "Here is a list of teams that were founded after the 1966 season and their founding years:"),
                 
                 p(
                 strong("Baltimore Ravens (1996), 
                 Carolina Panthers (1995),
                 Cincinnati Bengals (1968), 
                 Houston Texans (2002), 
                 Jacksonville 
                 Jaguars (1995), 
                 New Orleans Saints (1967), 
                 Seattle Seahawks (1976), 
                 Tampa Bay Buccaneers (1976)")
                 )
                 
                ),
         
        mainPanel(
            
            # Displaying NFL Interactive Graph.
         
            h3("NFL Predicted Home and Away Scores"),
        
            plotOutput("NFLModelInteractive")
         
                )
        
            ),
        
        # Explaining the interactive graph.
        
        h4("What is a Posterior Probability Distribution?"),
        
        p("Above, you see a", strong("posterior probability distribution"), "of predicted home and away scores for your selected team and season range. 
        A posterior probability distribution is a", em("probability distribution– a distribution that covers a set of outcomes, with each outcome having a chance of occuring between 0 and 1 – of an output based on beliefs and expectations."), 
        "In this case, the ouput is Score, and the expectations are based on the home or away status of a game."
        ),
        
        h4("Posterior Probability Distribution Explanation"),
        
        p(
        "This posterior probability distribution was made using a linear regression model where", strong("Score"), "is the output and", strong("Home"), "is the sole predictor."
        ),
        
        p(
        "Score is the predicted score of a team, while Home is whether the game is home or away. 
        Score is on the x-axis while Probability – i.e., the chance that the given score would occur – is on the y-axis. 
        The blue distribution is the distribution of predicted home scores of a team during the selected range of seasons, while the red distribution is the distribution of predicted away scores for a team during the selected range of seasons. 
        The blue line shows the median of the predicted home scores over the range of seasons, while the red line shows the median of predicted away scores over the range of seasons."
        ),
        
        # Displaying NFL Model Table.
             
        h3("NFL Model as a League from the 1966 Season to the 2019 Season"),
        
        withMathJax(),
        
        helpText("$$score = \\beta_0 + \\beta_1 home_i + \\epsilon_i$$"),
        
        tableOutput("NFLModelTable"),
        
        # Explanation and discussion of the model.
        
        h4("Output and Predictor"),
        
        p(
        "This model of the NFL takes", strong("home"), "as the predictor of the output", strong("score."), 
        "home is an indicator of whether a game was played at home or away, with home = 1 indicating that the game was played at home. 
        The output score is the predicted amount of points a team would score."
        ),
        
        h4("Explanation of the Table"),
        
        p(
        "This table shows the Beta value and confidence intervals for the Intercept and home. 
        The Beta value for the Intercept is equal to the median of the posterior distribution for the average predicted score when a team plays away from home – i.e., when home = 0.", 
        em("What this means is that the Beta for Intercept is roughly equal to the prediction for the amount of points an average NFL team will score if they play an away game."),
        "The Beta value for home is equal to the median of the posterior distribution for the average change in score when a team plays at home – i.e., when home = 1.",
        em("What this means is that the prediction for the amount of points an average NFL team will score if they play at home is roughly equal to the Beta for the Intercept PLUS the Beta for home."),
        strong("According to my model, the average NFL team can expect to score around 3 more points at home than if they played away from home."),
        "The confidence intervals tell us that we can be 95% sure that the true values for a team's score away from home and for the change in score if the team played at home falls in the range of the respective interval bounds for Intercept and home."),
        
        h4("Discussion of the Model"),
        
        p(
        "The Beta for home that is displayed is just under 3, which is consistent with", a("this article", href = "https://www.lineups.com/articles/how-important-is-home-field-advantage-in-the-nfl/#Debunking-the-Myths-of-HomeField-Advantage"), "and", a("this article.", href = "https://www.espn.com/chalk/story/_/id/29831703/will-2020-nfl-season-see-death-home-field-advantage"), 
        "In fact, Las Vegas has traditionally seen NFL home field advantage as worth 3 points to the spread when determining odds for games. 
        This model shows that there has been a small but significant home field advantage in the NFL from the 1966 season to the 2019 season.")
        
    ),

########## NBA ##########

# NBA Tab setup.

    tabPanel("NBA",
         
         h2("Linear Regression for the NBA with Score as Output and Home as Predictor"),
         
         # Creating sidebar for interactive model inputs.

         sidebarLayout(

             sidebarPanel(

                 h3("NBA Dashboard"),

                 p("Choose a team and a range of seasons to view a posterior distribution of predicted home scores and predicted away scores."),

                 # Specifying inputs for interactive model. You can choose a
                 # team and a range of seasons to display a posterior
                 # distribution of home vs. away predicted scores.

                 selectInput(inputId = "user_nba_team",
                             label = "Team",
                             choices = c("Atlanta Hawks",
                                         "Boston Celtics",
                                         "Brooklyn Nets",
                                         "Charlotte Hornets",
                                         "Chicago Bulls",
                                         "Cleveland Cavaliers",
                                         "Dallas Mavericks",
                                         "Denver Nuggets",
                                         "Detroit Pistons",
                                         "Golden State Warriors",
                                         "Houston Rockets",
                                         "Indiana Pacers",
                                         "Los Angeles Clippers",
                                         "Los Angeles Lakers",
                                         "Memphis Grizzlies",
                                         "Miami Heat",
                                         "Milwaukee Bucks",
                                         "Minnesota Timberwolves",
                                         "New Orleans Pelicans",
                                         "New York Knicks",
                                         "Oklahoma City Thunder",
                                         "Orlando Magic",
                                         "Philadelphia 76ers",
                                         "Phoenix Suns",
                                         "Portland Trail Blazers",
                                         "Sacramento Kings",
                                         "San Antonio Spurs",
                                         "Toronto Raptors",
                                         "Utah Jazz",
                                         "Washington Wizards"),
                             selected = "Boston Celtics"),

                 sliderInput(inputId = "user_nba_season",
                             label = "Season(s)",
                             min = 2003,
                             max = 2020,
                             value = c(2003, 2020),
                             sep = "")

             ),

             mainPanel(

                 # Displaying NBA Interactive Graph.

                 h3("NBA Predicted Home and Away Scores"),
                 
                 plotOutput("NBAModelInteractive")

             )

         ),
         
         # Explaining the interactive graph.
         
         h4("Posterior Probability Distribution Explanation"),
         
         p(
         "This posterior probability distribution* was made using a linear regression model where", strong("Score"), "is the output and", strong("Home"), "is the sole predictor."
         ),
         
         p(
         "Score is the predicted score of a team, while Home is whether the game is home or away. 
         Score is on the x-axis while Probability – i.e., the chance that the given score would occur – is on the y-axis. 
         The green distribution is the distribution of predicted home scores of a team during the selected range of seasons, while the gray distribution is the distribution of predicted away scores for a team during the selected range of seasons. 
         The green line shows the median of the predicted home scores over the range of seasons, while the gray line shows the median of predicted away scores over the range of seasons."
         ),
         
         p(
         "*If you need a refresher on what a posterior probability distribution is, please refer to the NFL tab."
         ),
         
         # NBA Model Table rendered.
         
         h3("NBA Model as a League from the 2003 Season to March 2020"),
         
         withMathJax(),
         
         helpText("$$score = \\beta_0 + \\beta_1 home_i + \\epsilon_i$$"),
         
         tableOutput("NBAModelTable"),
         
         # Explanation and discussion of the model.
         
         h4("Output and Predictor"),
         
         p(
         "This model of the NBA takes", strong("home"), "as the predictor of the output", strong("score."), 
         "home is an indicator of whether a game was played at home or away, with home = 1 indicating that the game was played at home. 
         The output score is the predicted amount of points a team would score."
         ),
         
         h4("Explanation of the Table"),
         
         p(
         "This table shows the Beta value and confidence intervals for the Intercept and home. 
         The Beta value for the Intercept is equal to the median of the posterior distribution for the average predicted score when a team plays away from home – i.e., when home = 0.", 
         em("What this means is that the Beta for Intercept is roughly equal to the prediction for the amount of points an average NBA team will score if they play an away game."), 
         "The Beta value for home is equal to the median of the posterior distribution for the average change in score when a team plays at home – i.e., when home = 1.", 
         em("What this means is that the prediction for the amount of points an average NBA team will score if they play at home is roughly equal to the Beta for the Intercept PLUS the Beta for home."), 
         strong("According to my model, the average NBA team can expect to score around 3 more points at home than if they played away from home."), 
         "The confidence intervals tell us that we can be 95% sure that the true values for a team's score away from home and for the change in score if the team played at home falls in the range of the respective interval bounds for Intercept and home."
         ),
         
         h4("Discussion of the Model"),
         
         p(
         "Of the big American sports leagues, the NBA is thought to have the greatest home field – or home court – advantage. 
         According to", a("this article,", href = "https://bleacherreport.com/articles/2905080-the-truth-about-nba-home-court-advantage"), "home teams in the NBA win 56 to 58% of all games in a given season, and a whopping 65% of all playoff games since 1984. 
         My model does not contradict these statements for the period between the 2003 season and March 2020, but it is certainly interesting that the predicted difference in points scored for a team at home versus a team away from home is only about 3 points."
         )
    
    ),

########## MLB: A DEEPER DIVE ##########

# MLB Tab setup.

    tabPanel("MLB: A Deeper Dive",
         
         h2("Linear Regression for the MLB with Score as Output and Home, 
             Attendance, and their Interaction as Predictors"),
         
         # Creating sidebar for interactive model inputs.
         
         sidebarLayout(
             
             sidebarPanel(
                 
                 h3("MLB Dashboard"),
                 
                 p("Choose a team and a range of seasons to view a posterior distribution of predicted home scores and predicted away scores."),
                 
                 # Specifying inputs for interactive model. You can choose a
                 # team and a range of seasons to display a posterior
                 # distribution of home vs. away predicted scores.
                 
                 selectInput(inputId = "user_mlb_team",
                             label = "Team",
                             choices = c("Arizona Diamondbacks",
                                         "Atlanta Braves",
                                         "Baltimore Orioles",
                                         "Boston Red Sox",
                                         "Chicago Cubs",
                                         "Chicago White Sox",
                                         "Cincinnati Reds",
                                         "Cleveland Indians",
                                         "Colorado Rockies",
                                         "Detroit Tigers",
                                         "Houston Astros",
                                         "Kansas City Royals",
                                         "Los Angeles Angels",
                                         "Los Angeles Dodgers",
                                         "Miami Marlins",
                                         "Milwaukee Brewers",
                                         "Minnesota Twins",
                                         "New York Yankees",
                                         "New York Mets",
                                         "Oakland Athletics",
                                         "Philadelphia Phillies",
                                         "Pittsburgh Pirates",
                                         "San Diego Padres",
                                         "San Francisco Giants",
                                         "Seattle Mariners",
                                         "St. Louis Cardinals",
                                         "Tampa Bay Rays",
                                         "Texas Rangers",
                                         "Toronto Blue Jays",
                                         "Washington Nationals"),
                             selected = "Boston Red Sox"),
                 
                 sliderInput(inputId = "user_mlb_season",
                             label = "Season(s)",
                             min = 1947,
                             max = 2019,
                             value = c(1947, 2020),
                             sep = ""),
                 
                # Disclaimer for clubs founded later than 1947.
                
                h4("Season Limits"),
                
                p(
                "Many teams were founded after the 1947 season. 
                For these teams, inputting seasons before their founding will result in  an innacurate visualization.", 
                em("Please do NOT input seasons that occurred before teams' foundings!"), 
                "Here is a list of teams that were founded after the 1947 season and their founding years:"
                ),
                
                p(
                strong("Arizona Diamondbacks (1998), 
                Colorado Rockies (1993), 
                Houston Astros (1962), 
                Kansas City Royals (1969), 
                Los Angeles Angels (1961), 
                Miami Marlins (1993), 
                Milwaukee Brewers (1969), 
                New York Mets (1962), 
                San Diego Padres (1969), 
                Seattle Mariners (1977), 
                Tampa Bay Rays  (1998), 
                Texas Rangers (1961), 
                Toronto Blue Jays (1977), 
                Washington Nationals (1969)")
                
                )
                 
             ),
             
             mainPanel(
                 
                 # Displaying MLB Interactive Graph.
                 
                 h3("MLB Predicted Home and Away Scores"),
                 
                 plotOutput("MLBModelInteractive")
                 
             )
             
         ),
         
         # Explaining the interactive graph.
         
         h4("Posterior Probability Distribution Explanation"),
         
         p(
         "This posterior probability distribution* was made using a linear regression model where", strong("Score"), "is the output and", strong("Home,"), strong("Attendance**,"), "and the", strong("Interaction between Home and Attendance"), "are predictors.", 
         em("This is a more intricate model than the models for the NFL and NBA."),
         "Therefore, this posterior probability distribution has been divided by parameter for easier interpretation."
         ),
         
         p(
         "Score is the predicted score of a team. 
         Home is whether the game is home or away – in this case, controlling for attendance. 
         Attendance is the average home attendance the home team enjoyed over the selected range of seasons divided by 1000. 
         The Interaction between Home and Attendance is the predictor that takes into account the interaction between Home and Attendance, i.e., the effect of home attendance. 
         Score is on the x-axis while Probability – i.e., the chance that the given score would occur – is on the y-axis. 
         The blue distribution is the distribution of predicted away scores of a team during the selected range of seasons, not taking into account attendance. 
         The purple distribution is the distribution of predicted home scores, not taking into account home attendance. 
         The orange distribution is the distribution of predicted away scores for a team during the selected range of seasons, taking into account 1000 more people in attendance. 
         The red distribution is the distribution of predicted home scores, taking into account 1000 more people in attendance. 
         The blue line shows the median of the predicted away scores over the range of seasons, not taking into account attendance. 
         The purple line shows the median of predicted home scores over the range of seasons, not taking into account attendance. 
         The orange line shows the median of predicted away scores over the range of seasons, taking into account attendance. Finally, the red line shows the median of predicted home scores, taking into account the interaction between home and attendance, i.e., the effect of home attendance."
         ),
         
         p(
         "*If you need a refresher on what a posterior probability distribution is, please refer to the NFL tab."
         ),
         
         p(
         "**The attendance predictor is the average home attendance divided for a team over the entire season rather than individual attendance figures per game because it is difficult to build a model using per-game attendance figures. 
         The attendance predictor is divided by 1000 so we can see the effect of 1000 more fans on score rather than 1 more fan, which would be miniscule."
         ),
         
         # MLB Complex Model Table
         
         h3("MLB Model as a League from the 1947 Season to the 2019 Season"),
         
         withMathJax(),
         
         helpText("$$score = \\beta_0 + \\beta_1 home_i + \\beta_2 attendance_i + \\beta_3 home_i * attendance_i + \\epsilon_i$$"),
         
         tableOutput("MLBComplexModelTable"),
         
         # Explanation and discussion of the model.
         
         h4("Output and Predictors"),
         
         p(
         "This model of the MLB is a step up from the NFL and NBA models, as it takes into account three predictors to produce the output", strong("score."),
         "These predictors are as follows:", 
         strong("home"), "is whether or not a game is played at home or away, with home = 1 indicating that the game is played at home.", 
         strong("attendance"), "is the additional number of fans in attendance of a game, with attendance = 1 meaning there were 1000 fans.",
         strong("home * attendance,"), "or the interaction between the home and attendance predictors is meant to account for the effect of a home crowd. 
         The interaction predictor is only taken into account when both home = 1 and attendance = 1, i.e., there are 1000 home fans.",
         em("The purpose of these additional predictors is to see how attendance, especially home attendance, can impact score, and whether or not playing at home by itself has any effect on the score output.")
         ),
         
         h4("Explanation of the Table"),
         
         p(
         "This table shows the Beta value and confidence intervals for the Intercept, home, attendance, and the interaction between home and attendance. 
         The Beta value of the Intercept is the median of the posterior distribution for average predicted score for an MLB team when home = 0 and attendance = 0 – the team is playing away from home, and there is no fan attendance.", 
         em("What this means is that the Beta for Intercept is roughly equal to the prediction for the amount of runs an average MLB team will score if they played an away game without any fans."), 
         "The Beta value of home is the median of the posterior distribution for the average change in score for an MLB team when home = 1.", 
         em("This means that whenever the average MLB team plays at home, they tend to experience the average change in score of the Beta value of home from the Intercept value."), 
         "The Beta value of attendance is the median of the posterior distribution for the average change in score for an MLB team when attendance = 1 – when there are 1000 more fans.", 
         em("This means that every time 1000 more fans are in the stadium, MLB teams tend to experience an average change in score of the Beta value for attendance from the Intercept value."),
         "Finally, the Beta value of home:attendance is the median of the posterior distribution for the average change in score based on the interaction between the home and attendance predictors – i.e., the effect of 1000 more home fans.", 
         em("This means that, for a given home game with 1000 fans, the average MLB team will tend to score a number of runs equal to the sum of the Beta values for the Intercept, home, attendance, and home:attendance. 
            Adding all of the Beta values together allows for you to take into account the effects of the home and attendance predictors as well as the interaction between them."),
         "Finally, the confidence intervals tell us that we can be 95% sure that the true values for the Betas for Intercept, home, attendance, and home:attendance will exist within their respective displayed bounds."
         ),
         
         h4("Discussion of the Model"),
         
         p(
         "The MLB has always been known as the league in which home field advantage", a("matters the least.", href = "https://www.mlb.com/news/home-field-advantage-has-disappeared-in-2020"),
         "My model seems to confirm that home field advantage matters very little. 
         Without taking into account attendance, my model shows that playing a home game is actually detrimental overall to the number of runs a team can expect to score. 
         This goes against conventional wisdom, as", a("teams are generally thought to have an advantage at home", href = "https://www.baseball-reference.com/bullpen/Home_field_advantage"), "due to knowing the ballpark better and being afforded the opportunity to hit in the bottom of the inning. 
         However, the negative effect that home seems to have is very small – less than 1/2 of a run. 
         This would suggest that", strong("playing at home in and of itself does not matter much in the MLB."), 
         "Rather, other covariates must also matter when determining the MLB's small home field advantage."
         ),
         
         p(
         "One of those covariates could be attendance. 
         A closer look at my model hows that teams benefit from games with higher attendance, and especially benefit from home games with higher attendance. 
         The Beta values for attendance and the interaction between home and attendance are the increase in the predicted number of runs per 1000 fans. 
         As the average attendance across all MLB regular season games has", a("hovered around 28 to 30 thousand in recent years,", href = "https://www.statista.com/statistics/235634/average-attendance-per-game-in-the-mlb--regular-season/#:~:text=MLB%20average%20per%20game%20attendance%202009%2D2019&text=In%20the%202019%20season%2C%20the,Major%20League%20Baseball%20was%2028%2C317."),
         "you can see how these Beta values can add up to make a small difference in predicted number of runs a team would score."
         ),
         
         p(
         "For example, the average home attendance for the LA Dodgers in 2019, the league leaders in that category for the year,", a("was 49,065.", href = "http://www.espn.com/mlb/attendance/_/year/2019"), 
         "According to my model, the Dodgers could have expected to score about 1 more run when they played at home on an average night as opposed to an away game where they had (for simplification's sake) no fans. 
         This is a small run difference, but I argue that this is not insignificant. 
         After all, one run in baseball is relatively hard to come by. 
         Therefore, while I did not have the data for the NFl and NBA to construct a model which took into account home attendance at games,",
         strong("judging from the MLB model, I believe it is safe to assume that greater home attendence would result in greater home scores in the NFL and NBA, especially as home field advantage is thought to matter much more in these two leagues.")
         )
         
    ),

########## ABOUT ##########

# About Tab setup. 

    tabPanel("About",
         
         fluidPage(
             
             fluidRow(column(8,
                
                # About Me Section. Text extends beyond the line when it is a long
                # link.
                             
                h2("About Me"),
                
                p(
                "My name is Alexander Park and I am pursuing an A.B. in Government with a specialization in Public Policy and a secondary in Economics at Harvard University. 
                I will graduate in the spring of 2023. 
                I am a lifelong Boston sports fan, especially of the Patriots, Red Sox, and Celtics. 
                Besides sports, I have passions for American and Korean politics, U.S. foreign policy, and the processes of and motivations behind democratization. 
                You can reach me at", a("apark@college.harvard.edu.", href = "mailto:apark@college.harvard.edu")
                ),
        
                # Project Motivations Section
        
                h2("Project Motivations"),
                
                p(
                "This is my final project for GOV 50: Data at Harvard University. 
                As a Boston sports fan, I am used to having home field advantage in the playoffs. 
                Therefore, I wanted to use data analysis to determine quantitatively how much home field advantage actually matters in my three favorite leagues: the NFL, NBA, and MLB. 
                In finding all of this out, I hope to contribute to the sports-watching experience for fans around the country and the world."
                ),
        
                # Acknowledgments Section.
        
                h2("Acknowledgments"),
                
                p(
                "I am grateful for the guidance that", strong("Wyatt Hurt"), "and",strong("Tyler Simko"), "have given me throughout this semester.
                Without their instruction and advice, I would not have been able to develop this project and start my journey in the field of data science."
                )
                             
             ),
             
             column(4,
            
                # Data Section. Specify where my data is from.
            
                h2("The Data"),
            
                h3("NFL Data"),
                
                p(
                "I obtained NFL scores from the 1966 season onwards from", a("Kaggle user spreadspoke.", href = "https://www.kaggle.com/tobycrabtree/nfl-scores-and-betting-data")
                ),
            
                h3("NBA Data"),
                
                p(
                "I obtained NBA scores from the 2004 season onwards from", a("Kaggle user Nathan Lauga.", href = "https://www.kaggle.com/nathanlauga/nba-games")
                ),
            
                h3("MLB Data"),
                
                p(
                "I obtained MLB scores from the 1947 season onwards from", a("FiveThirtyEight's mlb-elo data set.", href = "https://data.fivethirtyeight.com/")
                ),
            
                p(
                "I obtained MLB attendance data from the 1947 season onwards from", a("Sean Lahman's Baseball Database.", href = "http://www.seanlahman.com/baseball-archive/statistics/")
                ),
            
                h3("GitHub"),
                
                p(
                "Here is the link to this project's", a("GitHub repository.", href = "https://github.com/alexanderkpark/home-field-advantage")
                )
            
                )
             
            )
        
        )
        
    )

)

)
