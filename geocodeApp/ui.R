#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram
library(leaflet)
library(shiny)
shinyUI(fluidPage(
    
    # Application title
    titlePanel("A package connecting to a Geocode API"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel (
            selectInput("googleMethodInput","Select Geocoding request and response method according to:",
                        c("Latitude/Longitude lookup" = "latlng",
                          "Display Newyork data from DB" = "DB",
                         " Location lookup" = "address"
                        ,"Upload your CSV file" = "CSV"
                       )),
           
            conditionalPanel(
                condition = "input.googleMethodInput == 'latlng'",
                textInput("latiText", "Enter a latitude value:", placeholder = "58.314960600000006"),
                textInput("longText", "Enter a longitude value:", placeholder = "15.0995973")
            ),
            conditionalPanel(
                condition = "input.googleMethodInput == 'CSV'",
                fileInput('inputFile', 'Choose a file to upload',
                          accept = c(
                              'text/csv',
                              'text/comma-separated-values',
                              'text/tab-separated-values',
                              'text/plain',
                              '.csv',
                              '.tsv'
                          ))
            ),
            conditionalPanel(
                condition = "input.googleMethodInput == 'address'",
                textInput("addressText", "Enter a location value:", placeholder = "smålandsvägen 42D"),
                textInput("apiKey", "Please enter a valid API KEY:", placeholder = "VALID API KEY")
            ),
            
            selectInput("displayMode", "Select the display mode:", 
                        c("Classic" = "classic",
                          "Satellite" = "satellite",
                          "Night" = "night",
                        "Mesonet" = "mesonet"))         
        ),
        
        # Show a plot of the generated map according to user input
        mainPanel(leafletOutput("distPlot", height = "800px")),
    )
))
