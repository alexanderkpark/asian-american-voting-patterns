#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

x <- mtcars

# Define server logic required to draw a line graph.
shinyServer(function(input, output) {

  # carPlot is madeup name
    output$carPlot <- renderPlot({
      
      # Just read in data!
        ggplot(x, aes(mpg, disp)) + geom_line()
    })

})
