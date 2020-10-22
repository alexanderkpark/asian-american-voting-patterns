# Read in RDS.

avg_nfl_home_score <- readRDS(file = "nfl_scores")
avg_nba_home_score <- readRDS(file = "nba_scores")

# Define server logic required to draw graphs.
shinyServer(function(input, output) {

  # NFLPlot made
    output$NFLHomeAvg <- renderPlot({
      
      # Just read in data for NFL!
      
      ggplot(avg_nfl_home_score, aes(team_home, avg_home)) + 
        geom_col(color = "white", fill = "dodgerblue") +
        theme(axis.text.x = element_text(angle = 90, 
                                         vjust = 0.5, 
                                         hjust = 0.3)) +
        labs(title = "Average Home Scores for All NFL Teams",
             subtitle = "From 1966-67 to 2019-20",
             x = "Team",
             y = "Average Home Score")
    })
    
  #NBAPlot made
    
    output$NBAHomeAvg <- renderPlot({
      
      #Just read in data for NBA!
      
      ggplot(avg_nba_home_score, aes(home_team_id, avg_home)) + 
        geom_col(color = "white", fill = "dodgerblue") +
        theme(axis.text.x = element_text(angle = 90, 
                                         vjust = 0.5, 
                                         hjust = 0.3)) +
        labs(title = "Average Home Scores for All NBA Teams",
             subtitle = "From 2004 to Feb. 2020",
             x = "Team",
             y = "Average Home Score")
    })

})
