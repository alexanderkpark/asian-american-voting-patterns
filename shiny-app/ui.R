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
             p("Here is the link to my", a("Github.", 
    href = "https://github.com/alexanderkpark")),
             h1("Welcome to my project!"),
             p("This project will analyze in which league out of the four big 
               American leagues - NFL, MLB, NBA, NHL - home field advantage 
               matters the most. Home field advantage is a common sports logic 
               that the team who is playing in their home stadium gets a 
               significant advantage over the team who is visiting. As a sports 
               fan, I wanted to see how true this sports logic is. I will do 
               so by analyzing score differences between home games and away 
               games, team's overall records at home vs. away, quantifying 
               these metrics, and then trying to see if these differences are 
               statistically significant. In finding this out, I hope to make a 
               contribution to how sports are watched by fans in the US, as well 
               as have a leg up on friends whenever I have to predict who will 
               win and who will lose a given game.")),
    
    # Another tab panel
    tabPanel("Data",
             plotOutput("NFLHomeAvg"),
             plotOutput("NBAHomeAvg")
             )

))
