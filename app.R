#
# This is a Shiny web application. 
#
# Purpose:  The objective of this application is to create a 3D scatter plot
#           from dataset: mtcars on the basis of user selection of X, Y, Z and Color
# Author: AK
# Creation Date: May 06, 2018 
#

library(shiny)
library(plotly)
nm <- names(mtcars)
To_date <- Sys.Date()
data(mtcars)

#
# Define UI for application that enables users to select the X, Y, Z and Color
# variables from dataset: mtcars for an Interactive 3D Scatter Plot.
#
ui <- fluidPage(
   
   # Application title
   titlePanel("Creation of a 3D Plot from mtcars"),
   
     headerPanel('mtcars 3D plot'),
     sidebarPanel(
       selectInput('xcol', 'X Variable', choices=nm,
                  selected="cyl"),
       selectInput('ycol', 'Y Variable', choices=nm,
                   selected="mpg"),
       selectInput('zcol', 'X Variable', choices=nm,
                   selected="hp"),
       selectInput('col', 'Color Variable', choices=nm,
                   selected="am")
     ),
     mainPanel(
       plotlyOutput('plot1')
     )
   )
   
#
# Define the Server to plot the 3D Scatter plot on the basis of user's selection
#
   server <- function(input, output, session) {
     
     output$plot1 <- renderPlotly({
       
         plot_ly(mtcars,x=mtcars[,input$xcol],y=mtcars[,input$ycol], 
               z=mtcars[,input$zcol], 
               type="scatter3d",mode="markers",color=mtcars[,input$col]) %>%
         layout(
           title = paste("Today Date: ",To_date,"\n",input$xcol,"vs",input$ycol,"vs",input$zcol
                         ,sep=" ")
           ,
           scene = list(
             xaxis = list(title = paste("x: ",input$xcol)),
             yaxis = list(title = paste("y: ",input$ycol)),
             zaxis = list(title = paste("z: ",input$zcol))
           ))
       
       
     })
     
     
     
   }
   
   shinyApp(ui = ui, server = server)
   

