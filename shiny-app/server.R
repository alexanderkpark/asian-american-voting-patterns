#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

x <- avg_nfl_home_score

# Define server logic required to draw a line graph.
shinyServer(function(input, output) {

  # NFLPlot made
    output$NFLHomeAvg <- renderPlot({
      
      # Just read in data!
      ggplot(x, aes(team_home, avg_home)) + 
        geom_col(color = "white", fill = "dodgerblue") +
        theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 0.3))
    })

})
