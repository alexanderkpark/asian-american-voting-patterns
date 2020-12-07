########## INTRODUCTION ##########

# Read in RDS.

combined_league_data <- readRDS(file = "combined_league_data.RDS")
nfl_model <- readRDS(file = "nfl_model.RDS")
nfl_model_data <- readRDS(file = "nfl_model_data.RDS")
nba_model <- readRDS(file = "nba_model.RDS")
mlb_complex_model <- readRDS(file = "mlb_model_complex.RDS")

# Define server logic required to draw graphs.
shinyServer(function(input, output) {
  
  # Bar graph of average NFL home scores made.
  
    output$AvgScoreInteractive <- renderPlot({
      
      combined_league_data_int <- combined_league_data %>%
        filter(league == input$user_league)
      
      ggplot(combined_league_data_int, aes(team, score, fill = condition)) +
        geom_col(position = "dodge", color = "white") +
        scale_fill_manual(name = "Home Status", 
                          labels = c("Away", "Home"),
                          values = c("salmon", "deepskyblue4")) +
        theme(axis.text.x = element_text(angle = 90, 
                                         vjust = 0.5, 
                                         hjust = 0.3)) +
        labs(x = "Team",
             y = "Average Score")
      
    })
    
    
#   # Bar graph of average NBA home away scores made.
#     
#     output$NBAAvgScoreInteractive <- renderPlot({
#       
#       ggplot(avg_nba_home_score, aes(home_team, avg_home)) + 
#         geom_col(color = "white", fill = "green4") +
#         theme(axis.text.x = element_text(angle = 90, 
#                                          vjust = 0.5, 
#                                          hjust = 0.3)) +
#         labs(title = "Average Home Scores for All NBA Teams",
#              subtitle = "From 2004 Season to March 2020 (pre-Covid)",
#              x = "Team",
#              y = "Average Home Score")
#     })
#     
#   # Bar graph of average MLB home scores made.
#     
#     output$MLBAvgScoreInteractive <- renderPlot({
#       
#       ggplot(avg_mlb_home_score, aes(home_team, avg_home)) +
#         geom_col(color = "white", fill = "red4") + 
#         theme(axis.text.x = element_text(angle = 90, 
#                                          vjust = 0.5,
#                                          hjust = 0.3)) +
#         labs(title = "Average Home Scores for All MLB Teams",
#              subtitle = "From 1947 Season (Racial Integration) to 2019 Season (pre-Covid)",
#              x = "Team",
#              y = "Average Home Score")
#       
# # I have elected to have the subtitle go over the line so as not to disturb how
# # it will show up on the website.
#       
#     })
    
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
      
      output$NFLModelInteractive <- renderPlot({
        
        # Make NFL Model Interactive Graph Text extends beyond the line when it
        # is a long link.
        
        nfl_model_data_int <- nfl_model_data %>%
          filter(season %in% input$user_nfl_season,
                 team == input$user_nfl_team)
        
        # Creating NFL interactive model data.
        
        nfl_model_int <- stan_glm(score ~ home,
                                  data = nfl_model_data_int,
                                  refresh = 0) %>%
          as_tibble() %>%
          rename("mu" = "(Intercept)") %>%
          mutate(predicted_home = mu + home) %>%
          mutate(mu_median = median(mu)) %>%
          mutate(predicted_home_median = median(predicted_home)) %>%
          pivot_longer(cols = c(mu, predicted_home),
                       names_to = "parameter",
                       values_to = "values")
        
        # Creating NFL interactive model graph.
        
        ggplot(nfl_model_int, aes(values)) +
          geom_histogram(aes(y = after_stat(count/sum(count)), 
                             fill = parameter),
                         color = "white",
                         position = "identity",
                         bins = 100,
                         alpha = 0.5) +
          geom_vline(xintercept = nfl_model_int$mu_median, 
                     color = "red") +
          geom_vline(xintercept = nfl_model_int$predicted_home_median, 
                     color = "blue") +
          scale_fill_manual(name = "Home Status", 
                            labels = c("Away", "Home"),
                            values = c("red4", "navyblue"))
          
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
