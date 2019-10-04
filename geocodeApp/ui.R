#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram
#library(leaflet)
shinyUI(fluidPage(
    
    # Application title
    titlePanel("A package connecting to a Geocode API"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel (
            selectInput("googleMethodInput","Select Geocoding request and response method according to:",
                        c("Address lookup" = "address",
                          "latitude/longitude lookup" = "latlng",
                          "CSV file" = "CSV")),
            conditionalPanel(
                condition = "input.googleMethodInput == 'address'",
                textInput("addressText", "Type an address:", placeholder = "Smålandsvägen 42D, Mjölby")
            ),
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
            
            selectInput("displayMode", "Select the display mode:", 
                        c("Classic" = "classic",
                          "Satellite" = "satellite",
                          "Night" = "night")),
            
            selectInput("transportationMode", "Select the transportation mode:", 
                        c("Walking" = "walking",
                          "Bike" = "bike",
                          "Car" = "car") 
            ),
            textInput("apiKey", "Enter a a valid api Key:", placeholder = "A VALID API KEY HERE")
            
        ),
        
        # Show a plot of the generated map according to user input
        mainPanel(leafletOutput("distPlot", height = "800px")),
    )
))
