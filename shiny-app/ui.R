#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(tidyverse)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
    
# Here, I am setting the theme for my Shiny App.
theme = shinytheme("flatly"),
    
#Here, I am setting the title of my Shiny App.
"Asian American Voting Patterns",

    # Application title
    tabPanel("About",
             p("Hello World!", a("Link", 
    href = "https://www.youtube.com/watch?v=Yw6u6YkTgQ4&ab_channel=LouieZong")),
             h1("Sentience!")
             ),
    
    # Another tab panel
    tabPanel("Plot",
             plotOutput("carPlot")
             )

))
