########## INTRODUCTION ##########

# Read in RDS.

avg_nfl_home_score <- readRDS(file = "nfl_avg_home_scores.RDS")
avg_nfl_away_score <- readRDS(file = "nfl_avg_away_scores.RDS")
avg_nba_home_score <- readRDS(file = "nba_avg_home_scores.RDS")
avg_nba_away_score <- readRDS(file = "nba_avg_away_scores.RDS")
avg_mlb_home_score <- readRDS(file = "mlb_avg_home_scores.RDS")
avg_mlb_away_score <- readRDS(file = "mlb_avg_away_scores.RDS")
nfl_model <- readRDS(file = "nfl_model.RDS")
nba_model <- readRDS(file = "nba_model.RDS")
mlb_complex_model <- readRDS(file = "mlb_model_complex.RDS")

# Define server logic required to draw graphs.
shinyServer(function(input, output) {
  
  # Bar graph of average NFL home scores made.
  
    output$NFLHomeAvg <- renderPlot({
      
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
    
  # Bar graph of average NFL away scores made.
      
    output$NFLAwayAvg <- renderPlot({
      
      ggplot(avg_nfl_away_score, aes(team_away, avg_away)) + 
        geom_col(color = "white", fill = "navyblue") +
        theme(axis.text.x = element_text(angle = 90, 
                                         vjust = 0.5, 
                                         hjust = 0.3)) +
        labs(title = "Average Away Scores for All NFL Teams",
             subtitle = "From 1966 Season to 2019 Season",
             x = "Team",
             y = "Average Away Score")
      
    })
    
  # Bar graph of average NBA home away scores made.
    
    output$NBAHomeAvg <- renderPlot({
      
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
    
  # Bar graph of average NBA away scores made.
    
    output$NBAAwayAvg <- renderPlot({
      
      ggplot(avg_nba_away_score, aes(away_team, avg_away)) + 
        geom_col(color = "white", fill = "green4") +
        theme(axis.text.x = element_text(angle = 90, 
                                         vjust = 0.5, 
                                         hjust = 0.3)) +
        labs(title = "Average Away Scores for All NBA Teams",
             subtitle = "From 2004 Season to March 2020 (pre-Covid)",
             x = "Team",
             y = "Average Away Score")
    })
    
  # Bar graph of average MLB home scores made.
    
    output$MLBHomeAvg <- renderPlot({
      
      ggplot(avg_mlb_home_score, aes(home_team, avg_home)) +
        geom_col(color = "white", fill = "red4") + 
        theme(axis.text.x = element_text(angle = 90, 
                                         vjust = 0.5,
                                         hjust = 0.3)) +
        labs(title = "Average Home Scores for All MLB Teams",
             subtitle = "From 1947 Season (Racial Integration) to 2019 Season (pre-Covid)",
             x = "Team",
             y = "Average Home Score")
      
# I have elected to have the subtitle go over the line so as not to disturb how
# it will show up on the website.
      
    })
    
  # Bar graph of average MLB away scores made.

    output$MLBAwayAvg <- renderPlot({
      
      ggplot(avg_mlb_away_score, aes(away_team, avg_away)) +
        geom_col(color = "white", fill = "red4") + 
        theme(axis.text.x = element_text(angle = 90, 
                                         vjust = 0.5,
                                         hjust = 0.3)) +
        labs(title = "Average Away Scores for All MLB Teams",
             subtitle = "From 1947 Season (Racial Integration) to 2019 Season (pre-Covid)",
             x = "Team",
             y = "Average Away Score")
      
      # I have elected to have the subtitle go over the line so as not to disturb how
      # it will show up on the website.
      
    })
    
########## NFL ##########
    
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
    
    # NBAModelTable made.
    
    output$NBAModelTable <- render_gt({

      # Make NBA Model Table.

      tbl_regression(nba_model, intercept = TRUE) %>% 
        as_gt() %>%
        fmt_number(columns = vars(estimate, std.error),
                   decimals = 4) %>%
        tab_header(title = "Regression of NBA Scores",
                   subtitle = "The Effect of Home on Score") %>%
        tab_source_note("Source: https://www.kaggle.com/nathanlauga/nba-games")
      
    })
    
########## MLB: A DEEPER DIVE ##########
    
    # MLBComplexModelTable made.
    
    output$MLBComplexModelTable <- render_gt({

      # Make MLB Complex Model Table. Links go over the line.

      tbl_regression(mlb_complex_model, intercept = TRUE) %>% 
        as_gt() %>%
        fmt_number(columns = vars(estimate, std.error),
                   decimals = 4) %>%
        tab_header(title = "Regression of MLB Scores",
                   subtitle = "The Effect of Home, Attendance, and their Interaction on Score") %>%
        tab_source_note("Sources: https://data.fivethirtyeight.com/ &
                          http://www.seanlahman.com/baseball-archive/statistics/")
     
    })
    
})
