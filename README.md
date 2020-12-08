# Home Field Advantage in the NFL, MLB, and NBA

#### A Final Project for GOV 50: Data at Harvard University

### Project Summary

Home field advantage is the supposed benefit that a team enjoys when they play in their home stadium as opposed to when they go and play in other venues as visitors. This benefit is attributed to a variety of factors, including fans and referee bias. The concept of home field advantage has been taken as a maxim for years by players, coaches, management, and fans alike. The purpose of this project is to explore whether home field advantage actually matters – and more. If home field advantage does matter, how many more points can teams in the NFL, NBA, and MLB expect to get when playing at home as opposed to when they play as visitors? How has home field advantage in these three leagues changed over time? This project will endeavor to provide answers to these questions by analyzing data on home vs. away scores of teams in all three leagues throughout the years.

[View the live Shiny App here](https://alexanderkpark.shinyapps.io/home-field-advantage/).

### Repository Guide

* /shiny-app: Files to render this Shiny App.
    * /raw_data: Raw data regard NFL, NBA, and MLB scores and MLB attendance figures from Kaggle, FiveThirtyEight, and the Sean Lahman baseball database. 
    * /www: Images rendered into the Shiny App from the internet.
    * combined_league_data.RDS: Tibble of home and away average scores for all teams across the NFL, NBA, and MLB. Rendered using the 'gather_data.Rmd' script.
    * gather_data.Rmd: Rmd file used to gather, clean, and join data from Kaggle, FiveThirtyEight and the Sean Lahman baseball database. Also used to develop statistical models used in the Shiny App. 
    * mlb_model_complex.RDS: Model made using MLB home and away score and attendance data. Rendered using the 'gather_data.Rmd' script.
    * mlb_model_data.RDS: Tibble of MLB per-game data used to create interactive visualization. Rendered using the 'gather_data.Rmd' script.
    * nba_model.RDS: Model made using NBA home and away score data. Rendered using the 'gather_data.Rmd' script.
    * nba_model_data.RDS: Tibble of NBA per-game data used to create interactive visualization. Rendered using the 'gather_data.Rmd' script.
    * nfl_model.RDS: Model made using NFL home and away score data. Rendered using the 'gather_data.Rmd' script.
    * nfl_model_data.RDS: Tibble of NFL per-game data used to create interactive visualization. Rendered using the 'gather_data.Rmd' script.
    * server.R: Shiny App server script.
    * ui.R: Shiny App UI script.
* .gitignore
* README.md
