#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define server logic required to draw graphs.
shinyServer(function(input, output) {

  # NFLPlot made
    output$NFLHomeAvg <- renderPlot({
      
      # Just read in data for NFL!
      nfl_scores_1966 <- read_csv("data/spreadspoke_scores.csv")
      
      avg_nfl_home_score <- nfl_scores_1966 %>%
        group_by(team_home) %>%
        summarize(avg_home = mean(score_home), .groups = "drop")
      
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
      
      nba_scores_2004 <- read_csv("data/nba2004/games.csv") %>%
        clean_names()
      
      avg_nba_home_score <- nba_scores_2004 %>%
        select(home_team_id, pts_home) %>%
        group_by(home_team_id) %>%
        summarize(avg_home = mean(pts_home, na.rm = TRUE), .groups = "drop")
      
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
