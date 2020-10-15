#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

########## PREP ##########

library(shiny)
library(shinythemes)
library(tidyverse)
library(readxl)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
    
# Here, I am setting the theme for my Shiny App.
theme = shinytheme("flatly"),
    
#Here, I am setting the title of my Shiny App.
"Home Field Advantage",

    # Application title
    tabPanel("About",
             p("Hello World!", a("Link", 
    href = "https://www.youtube.com/watch?v=Yw6u6YkTgQ4&ab_channel=LouieZong")),
             h1("Sentience!")
             ),
    
    # Another tab panel
    tabPanel("Data",
             plotOutput("NFLHomeAvg")
             )

))
