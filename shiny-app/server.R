########## SETUP ##########

# Read in RDS.

combined_league_data <- readRDS(file = "combined_league_data.RDS")
nfl_model <- readRDS(file = "nfl_model.RDS")
nfl_model_data <- readRDS(file = "nfl_model_data.RDS")
nba_model <- readRDS(file = "nba_model.RDS")
nba_model_data <- readRDS(file = "nba_model_data.RDS")
mlb_complex_model <- readRDS(file = "mlb_model_complex.RDS")
mlb_model_data <- readRDS(file = "mlb_model_data.RDS")

# Define server logic required to draw graphs.
shinyServer(function(input, output) {
  
########## INTRODUCTION ##########
  
  # Images for rendering on Intro Page.
  
  output$NFLLogo <- renderImage({
    list(src = "www/nfl_logo.png",
         width = 256,
         height = 350,
         alt = "Error displaying image")
  }, deleteFile = FALSE)
  
  output$NBALogo <- renderImage({
    list(src = "www/nba_logo.png",
         width = 135,
         height = 296,
         alt = "Error displaying image")
  }, deleteFile = FALSE)
  
  output$MLBLogo <- renderImage({
    list(src = "www/mlb_logo.png",
         width = 350,
         height = 190,
         alt = "Error displaying image")
  }, deleteFile = FALSE)
  
  output$FenwayScoreboard <- renderImage({
    list(src = "www/fenway.jpeg",
         width = 400,
         height = 228,
         alt = "Error displaying image")
  }, deleteFile = FALSE)
  
  # Bar graph of average NFL home scores made.
  
    output$AvgScoreInteractive <- renderPlot({
      
      combined_league_data_int <- combined_league_data %>%
        filter(league == input$user_league)
      
      ggplot(combined_league_data_int, aes(team, score, fill = condition)) +
        geom_col(position = "dodge", color = "white") +
        scale_fill_manual(name = "Home Status", 
                          labels = c("Away", "Home"),
                          values = c("salmon", "deepskyblue4")) +
        theme_bw() +
        theme(axis.text.x = element_text(angle = 90, 
                                         vjust = 0.5, 
                                         hjust = 0.3)) +
        labs(x = "Team",
             y = "Average Score") 
      
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
      
    # NFLModelInteractive made.
    
      output$NFLModelInteractive <- renderPlot({
        
        # Make NFL Model Interactive.
        
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
                            values = c("red4", "navyblue")) +
          labs(title = "Posterior Probability Distribution of Home and Away Scores",
               x = "Score",
               y = "Probability") +
          theme_bw()
        
        # I have elected to have the title text go over the line so as to
        # preserve the formatting of the title on the Shiny app.  
        
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
      
    # NBAModelInteractive made.

      output$NBAModelInteractive <- renderPlot({

        # Make NBA Model Interactive Graph.

        nba_model_data_int <- nba_model_data %>%
          filter(season %in% input$user_nba_season,
                 team == input$user_nba_team)

        # Creating NBA interactive model data.

        nba_model_int <- stan_glm(score ~ home,
                                  data = nba_model_data_int,
                                  refresh = 0) %>%
          as_tibble() %>%
          rename("mu" = "(Intercept)") %>%
          mutate(predicted_home = mu + home) %>%
          mutate(mu_median = median(mu)) %>%
          mutate(predicted_home_median = median(predicted_home)) %>%
          pivot_longer(cols = c(mu, predicted_home),
                       names_to = "parameter",
                       values_to = "values")

        # Creating NBA interactive model graph.

        ggplot(nba_model_int, aes(values)) +
          geom_histogram(aes(y = after_stat(count/sum(count)),
                             fill = parameter),
                         color = "white",
                         position = "identity",
                         bins = 100,
                         alpha = 0.5) +
          geom_vline(xintercept = nba_model_int$mu_median,
                     color = "black") +
          geom_vline(xintercept = nba_model_int$predicted_home_median,
                     color = "springgreen1") +
          scale_fill_manual(name = "Home Status",
                            labels = c("Away", "Home"),
                            values = c("gray12", "green4")) +
          labs(title = "Posterior Probability Distribution of Home and Away Scores",
               x = "Score",
               y = "Probability") +
          theme_bw()

    # I have elected to have the title text go over the line so as to
    # preserve the formatting of the title on the Shiny app.

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
   
      # MLBModelInteractive made.
      
      output$MLBModelInteractive <- renderPlot({
        
        mlb_model_data_int <- mlb_model_data %>%
          filter(season %in% input$user_mlb_season,
                 team == input$user_mlb_team)
        
        mlb_model_int <- stan_glm(score ~ home + attendance + home * attendance,
                                  data = mlb_model_data_int,
                                  refresh = 0) %>%
          as_tibble() %>%
          rename("mu" = "(Intercept)",
                 "interaction" = "home:attendance") %>%
          mutate(predicted_home = mu + home) %>%
          mutate(predicted_attendance = mu + attendance) %>%
          mutate(predicted_interaction = mu + interaction) %>%
          mutate(mu_median = median(mu)) %>%
          mutate(predicted_home_median = 
                   median(predicted_home)) %>%
          mutate(predicted_attendance_median = 
                   median(predicted_attendance)) %>%
          mutate(predicted_interaction_median = 
                   median(predicted_interaction)) %>%
          pivot_longer(cols = c(mu, 
                                predicted_home, 
                                predicted_attendance, 
                                predicted_interaction),
                       names_to = "parameter",
                       values_to = "values")
        
        # Creating MLB interactive model graph.
        
        ggplot(mlb_model_int, aes(values)) +
          geom_histogram(aes(y = after_stat(count/sum(count)),
                             fill = parameter),
                         color = "white",
                         position = "identity",
                         bins = 100,
                         alpha = 0.25) +
          geom_vline(xintercept = mlb_model_int$mu_median,
                     color = "blue") +
          geom_vline(xintercept = mlb_model_int$predicted_home_median,
                     color = "purple") +
          geom_vline(xintercept = mlb_model_int$predicted_attendance_median,
                     color = "orange") +
          geom_vline(xintercept = mlb_model_int$predicted_interaction_median,
                     color = "red") +
          scale_fill_manual(name = "Parameter",
                            labels = c("Away",
                                       "+1000 in Attendance",
                                       "Home",
                                       "Interaction b/w Home and Attendance"),
                            values = c("navyblue",
                                       "darkorange1",
                                       "purple2",
                                       "red4")) +
          labs(title = "Posterior Probability Distribution of Home and Away Scores",
               x = "Score",
               y = "Probability") +
          theme_bw()
        
        # I have elected to have the title text go over the line so as to
        # preserve the formatting of the title on the Shiny app.
        
      })  
       
})
