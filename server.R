#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(UsingR)
data(father.son)
galton <- father.son
father.son <- round(father.son, digit = 2)
colnames(galton) <- c("father", "son")

shinyServer(function(input, output) {
    model <- lm(son ~ father, data = galton)
    
    
    modelpred <- reactive({
       fatherInput <- input$sliderFATHER
        predict(model, newdata = data.frame(father = fatherInput), digits=2)
        
        
    })
    
    output$plot <- renderPlot({
        fatherInput <- input$sliderFATHER
        
        plot(galton$father, galton$son, xlab = "Father's Height (Inches)", main = "Father and Son's Heights Regression",
             ylab = "Son's Height (Inches)", bty = "o", pch = 16, col="grey60",
             xlim = c(55, 85), ylim = c(55, 85),)
        abline(coef = c(0,1), type="l", lty=2)
        
        if(input$showModel){
            abline(model, col = "darkblue", lwd = 2)
        }
        
        legend(25, 250, c("Model Prediction"), pch = 16, 
               col = c("red", "blue"), bty = "1", cex = 1.2)
        points(fatherInput, modelpred(), col = "black", pch = 4, cex = 2, lwd=2)
        
    })
    
    output$pred <- renderText({
        pred <- modelpred()
        pred <- paste(round(pred, digits = 2),"Inches" )
        pred
    })
    
})