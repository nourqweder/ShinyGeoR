#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(geojsonio)
library(mapview)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$distPlot <- renderLeaflet({
  # empty dataframe
  addressInfo <- data.frame(Latitude = numeric(0), Longitude = numeric(0), address = character(0))
  # initial view parameters  to centered the map
  # initial view parameters (whole map centered)
  center.lat <- 30
  center.long <- 11
  init.zoom <- 2
  mydb <- reactive({
    #if the user choose address

    #----------------------------------------------------------------------------------------
   if (input$googleMethodInput == "latlng") {
      #prepare address parameter x, y
      addressInfo$latitude <- input$latiText # geocodeBylatlng(paste0(input$latiText, ",",input$longText))
      addressInfo$longitude <- input$longText
      addressInfo$address == "OK"
      addressInfo$year== Sys.Date()
      if ((input$latiText != "") &&(input$latiText != "") && (addressInfo$address != "ERROR")) {
        center.long <- input$latiText
        center.lat <- input$latiText
        init.zoom <- 15
      }
    }
    #----------------------------------------------------------------------------------------
    
    
    #----------------------------------------------------------------------------------------
    #  addressInfo <- subset(addressInfo, addressInfo$address != "ERROR")
    # empty dataframe
    if (input$displayMode == "classic") {
      return(leaflet(data = addressInfo) %>%
               setView(lat = center.lat, lng = center.long, zoom = init.zoom) %>%
               addTiles() %>%
               addMarkers(lng = ~longitude, ~latitude, popup = ~as.character(address)))
    } else if (input$displayMode == "satellite") {
      
      return(leaflet(data =  addressInfo) %>%
               setView(lat = center.lat, lng = center.long, zoom = init.zoom) %>%
               addTiles(urlTemplate="http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}") %>%
               addMarkers(lng = ~longitude, ~latitude, popup = ~as.character(address)))
      
    } else if (input$displayMode == "night") {
      
      return(leaflet(data = addressInfo) %>%
               setView(lat = center.lat, lng = center.long, zoom = init.zoom) %>%
               # addProviderTiles("NASAGIBS.ViirsEarthAtNight2012") %>%
               addMarkers(lng = ~longitude, ~latitude, popup = ~as.character(address)))
      
    }  })
  
 
  
    m <- leaflet(data = df) %>%
      addTiles() %>%
     # setView(lat = center.lat, lng = center.long, zoom = init.zoom) %>%
      addMarkers(lng = ~Longitude, 
                 lat = ~Latitude,
                 popup = paste("Offense", df$Offense, "<br>",
                               "Year:", df$CompStat.Year, "<br>"))
    m
  }) 
})


