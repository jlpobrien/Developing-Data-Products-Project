#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(markdown) 

shinyUI(navbarPage("Tabs:",
    tabPanel("Predict Son's Height",
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderFATHER", "Father's Height", 55, 85, value = 70),
            checkboxInput("showModel", "Show/Hide Model", value = TRUE),
            
        ),
        mainPanel(
            plotOutput("plot", height = 600, width = 600),
            h3("Predicted Height of Son:"),
            strong(h3(textOutput("pred"), style="color:darkblue")),
        
        ) 
    )
), 

tabPanel("About",
         mainPanel( 
             includeMarkdown("about.Rmd") 
         ) 
) 
))

  