########## INTRODUCTION ##########

# Read in RDS.

avg_nfl_home_score <- readRDS(file = "nfl_avg_home_scores")
avg_nba_home_score <- readRDS(file = "nba_avg_home_scores")
avg_mlb_home_score <- readRDS(file = "mlb_avg_home_scores")

# Define server logic required to draw graphs.
shinyServer(function(input, output) {

  # NFLPlot made
  
    output$NFLHomeAvg <- renderPlot({
      
      # Made NFL Home Avg Score Plot
      
      ggplot(avg_nfl_home_score, aes(team_home, avg_home)) + 
        geom_col(color = "white", fill = "navyblue") +
        theme(axis.text.x = element_text(angle = 90, 
                                         vjust = 0.5, 
                                         hjust = 0.3)) +
        labs(title = "Average Home Scores for All NFL Teams",
             subtitle = "From 1966 Season to 2019 Season",
             x = "Team",
             y = "Average Home Score")
    })
    
  # NBAPlot made
    
    output$NBAHomeAvg <- renderPlot({
      
      # Made NBA Home Avg Score Plot
      
      ggplot(avg_nba_home_score, aes(home_team, avg_home)) + 
        geom_col(color = "white", fill = "green4") +
        theme(axis.text.x = element_text(angle = 90, 
                                         vjust = 0.5, 
                                         hjust = 0.3)) +
        labs(title = "Average Home Scores for All NBA Teams",
             subtitle = "From 2004 Season to March 2020 (pre-Covid)",
             x = "Team",
             y = "Average Home Score")
    })
    
  # MLBPlot Made
    
    output$MLBHomeAvg <- renderPlot({
      
      # Made MLB Home Avg Score Plot
      
      ggplot(avg_mlb_home_score, aes(home_team, avg_home)) +
        geom_col(color = "white", fill = "red4") + 
        theme(axis.text.x = element_text(angle = 90, 
                                         vjust = 0.5,
                                         hjust = 0.3)) +
        scale_x_discrete(labels = c("Los Angeles Angels", 
                                    "Arizona Diamondbacks", 
                                    "Atlanta Braves", "Baltimore Orioles",
                                    "Boston Red Sox", "Chicago Cubs",
                                    "Chicago White Sox", "Cincinnati Reds",
                                    "Cleveland Indians", "Colorado Rockies",
                                    "Detroit Tigers", 
                                    "Miami Marlins",
                                    "Houston Astros", "Kansas City Royals",
                                    "Los Angeles Dodgers", "Milwaukee Brewers",
                                    "Minnesota Twins", "New York Mets",
                                    "New York Yankees", "Oakland Athletics",
                                    "Philadelphia Phillies", 
                                    "Pittsburgh Pirates",
                                    "San Diego Padres", "Seattle Mariners",
                                    "San Francisco Giants", 
                                    "St Louis Cardinals",
                                    "Tampa Bay Rays", "Texas Rangers",
                                    "Toronto Blue Jays", 
                                    "Washington Nationals")) +
        labs(title = "Average Home Scores for All MLB Teams",
             subtitle = "From 1947 Season (Racial Integration) to 2019 Season (pre-Covid)",
             x = "Team",
             y = "Average Home Score")
      
# I have elected to have the subtitle go over the line so as not to disturb how
# it will show up on the website.
      
    })

########## NFL ##########

# Read in RDS.
    
    nfl_model <- readRDS(file = "nfl_model")
    
    # reg_eq or Regression Equation made in Latex. Equation goes over the line
    # so as not to disturb display in app.
    
    output$reg_eq <- renderUI({
      
      withMathJax(sprintf("$$ score = \\beta_0 + \\beta_1 home_i + \\epsilon_i $$"))
    
    })
    
    # NFLModelTable made.
    
    output$NFLModelTable <- render_gt({
      
      # Make NFL Model Table. Text extends beyond the line when it is a long
      # link.
      
      tbl_regression(nfl_model, intercept = TRUE) %>%
        as_gt() %>%
        fmt_number(columns = vars(estimate, std.error),
                   decimals = 4) %>%
        tab_header(title = "Regression of NFL Scores",
                   subtitle = "The Effect of Home Field on Score") %>%
        tab_source_note("Source: https://www.kaggle.com/tobycrabtree/nfl-scores-and-betting-data")
      
    })
    

########## NBA ##########
    
  # Read in RDS
    
    nba_model <- readRDS(file = "nba_model")
    
    # reg_eq or Regression Equation made in Latex. Equation goes over the line
    # so as not to disturb display in app.
    
    output$reg_eq <- renderUI({
      
      withMathJax(sprintf("$$ score = \\beta_0 + \\beta_1 home_i + \\epsilon_i $$"))
      
    })
      
      # NBAModelTable made.
      
      output$NBAModelTable <- render_gt({
        
        # Make NBA Model Table.
        
        tbl_regression(nba_model, intercept = TRUE) %>%
          as_gt() %>%
          fmt_number(columns = vars(estimate, std.error),
                     decimals = 4) %>%
          tab_header(title = "Regression of NBA Scores",
                     subtitle = "The Effect of Home Court on Score") %>%
          tab_source_note("Source: https://www.kaggle.com/nathanlauga/nba-games")
        
      })

########## MLB: A DEEPER DIVE ##########

    # Read in RDS
    
    mlb_complex_model <- readRDS(file = "mlb_model_complex")
    mlb_simple_model <- readRDS(file = "mlb_model_simple")
    
    # mlb_reg_eq or MLB Regression Equation made in Latex. Equation goes over
    # the line so as not to disturb display in app.
    
    output$reg_eq <- renderUI({
      
      withMathJax(sprintf("$$ score = \\beta_0 + \\beta_1 home_i + \\beta_3 home_i * attendance_i + \\epsilon_i $$"))
      
    })
      
    # MLBComplexModelTable made.
      
    output$MLBComplexModelTable <- render_gt({
        
        # Make MLB Complex Model Table. Links go over the line.
        
        tbl_regression(mlb_complex_model, intercept = TRUE) %>%
          as_gt() %>%
          fmt_number(columns = vars(estimate, std.error),
                     decimals = 4) %>%
          tab_header(title = "Regression of MLB Scores",
                     subtitle = "The Effect of Home, Attendance, and their 
                     Interaction on Score") %>%
          tab_source_note("Sources: https://data.fivethirtyeight.com/ &
                          http://www.seanlahman.com/baseball-archive/statistics/")
        
      })
    
    # reg_eq or Regression Equation made in Latex. Equation goes over the line
    # so as not to disturb display in app.
    
    output$reg_eq <- renderUI({
      
      withMathJax(sprintf("$$ score = \\beta_0 + \\beta_1 home_i + \\epsilon_i $$"))
      
    })
    
    # MLBSimpleModelTable made.
    
    output$MLBSimpleModelTable <- render_gt({
      
      # Make MLB Simple Model Table.
      
      tbl_regression(mlb_simple_model, intercept = TRUE) %>%
        as_gt() %>%
        fmt_number(columns = vars(estimate, std.error),
                   decimals = 4) %>%
        tab_header(title = "Regression of MLB Scores",
                   subtitle = "The Effect of Home Field on Score") %>%
        tab_source_note("Source: https://data.fivethirtyeight.com/")
      
    })
    
})
