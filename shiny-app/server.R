#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define server logic required to draw a line graph.
shinyServer(function(input, output) {

    output$carPlot <- renderPlot({
        ggplot(mtcars, aes(mpg, disp)) + geom_line()
    })

})
