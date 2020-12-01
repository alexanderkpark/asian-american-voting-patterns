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
library(janitor)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
    
# Here, I am setting the theme for my Shiny App.
theme = shinytheme("flatly"),
    
#Here, I am setting the title of my Shiny App.
"Home Field Advantage in the NFL, MLB, and NBA",
    
########## INTRODUCTION ##########

    # Introduction Tab setup

    tabPanel("Introduction",
             
             # Background Section. Text extends beyond the line when it is a
             # long link.
             
             h1("What is Home Field Advantage? 
                And Why Does It Matter, Anyway?"),
             p(strong("Home field advantage"), "is the supposed benefit that a 
             team enjoys when they play in their home stadium as opposed to when 
             they go and play in other venues as visitors. The concept of 
             \"home field advantage\" has been taken as a maxim for years by 
             players, coaches, management, and fans alike. In fact, home field 
             advantage is so ingrained in sports culture that virtually all 
             American sports leagues – from high school tournaments all the way 
             up to Big Four – reward home field privileges throughout the 
             playoffs to the top seeded team from the regular season. Recently,
             though, there are growing murmurs in the sports world that", 
             a("home field advantage is not what it used to be.", href = "https://www.nytimes.com/2020/01/10/sports/football/road-team-advantage.html"),
             "So,", strong("does home field advantage actually matter?")),
             
             
             # Motivations Section
             
             h1("The Purpose of this Project"),
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
               win and who will lose a given game."),
             
             # Graphs of Average Home Scores for All Leagues
             
             h1("Average Home Scores of Teams in the NFL, NBA, and MLB Over the 
                Years"),
             h2("NFL – National Football League"),
             plotOutput("NFLHomeAvg"),
             h2("NBA – National Basketball Association"),
             plotOutput("NBAHomeAvg"),
             h2("MLB – Major League Baseball"),
             plotOutput("MLBHomeAvg")),

########## ABOUT ##########

# About Tab setup. 

tabPanel("About",
         
         # About Me Section. Text extends beyond the line when it is a long
         # link.
         
         h1("About Me"),
         p("My name is Alexander Park and I am pursuing an A.B. in Government 
         with a specialization in Public Policy and a secondary in Economics at 
         Harvard University. I will graduate in the spring of 2023. I am a 
         lifelong Boston sports fan, especially of the Patriots, Red Sox, and 
         Celtics. Besides sports, I have passions for American and Korean 
         politics, U.S. foreign policy, and the processes of and motivations 
         behind democratization. You can reach me at", 
         a("apark@college.harvard.edu", href = "mailto:apark@college.harvard.edu"),
         "."),
         
         # Project Motivations Section
         
         h1("Project Motivations"),
         p("This is my final project for GOV 50: Data at Harvard University. As 
         a Boston sports fan, I am used to having home field advantage in the 
         playoffs. Therefore, I wanted to use data analysis to determine 
         quantitatively how much home field advantage actually matters in my 
         three favorite leagues: the NFL, NBA, and MLB. In finding all of this 
         out, I hope to contribute to the sports-watching experience for fans 
         around the country and the world – especially for my fellow 
         Bostonians."),
         
         # Data Section. Text extends beyond the line when it is a long link.
         
         h1("The Data"),
         h3("NFL Data"),
         p("")
         
         h3("NBA Data"),
         
         
         h3("MLB Data"),
         
         
         h3("GitHub"),
         p("Here is the link to this project's", a("GitHub repository.", 
                                       href = "https://github.com/alexanderkpark/home-field-advantage")),
         
         # Acknowledgements Section.
         
         h1("Acknowledgements"),
         p("I am grateful for the guidance that", strong("Wyatt Hurt"), "and",
         strong("Tyler Simko"), "have given me throughout this semester. 
         Without their instruction and advice, I would not have been able to 
         develop this project and start my journey in the field of data 
         science.")
       
         )

))
