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
  
  
  if (input$googleMethodInput == "latlng") {
    
    m <- leaflet(data = addressInfo) %>%
      addTiles() %>%
      # setView(lat = center.lat, lng = center.long, zoom = init.zoom) %>%
      addMarkers(lng = as.numeric(input$longText), 
                 lat = as.numeric(input$latiText),
                 popup = ~as.character(address))
  }
  else if (input$googleMethodInput != "latlng") {
    m <- leaflet(data = df) %>%
      addTiles() %>%
      # setView(lat = center.lat, lng = center.long, zoom = init.zoom) %>%
      addMarkers(lng = ~Longitude, 
                 lat = ~Latitude,
                 popup = paste("Offense", df$Offense, "<br>",
                               "Year:", df$CompStat.Year, "<br>"))
  }
  #----------------------------------------------------------------------------------------
  #  addressInfo <- subset(addressInfo, addressInfo$address != "ERROR")
  # empty dataframe
  if (input$displayMode == "classic") {
    m <- leaflet(data = addressInfo) %>%
              setView(lat = center.lat, lng = center.long, zoom = init.zoom) %>%
              addTiles() %>%
              addMarkers(lng = ~longitude, ~latitude, popup = ~as.character(address))
  } else if (input$displayMode == "satellite") {
    
    return( leaflet(data =  addressInfo) %>%
              setView(lat = center.lat, lng = center.long, zoom = init.zoom) %>%
              addTiles(urlTemplate="http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}") %>%
              addMarkers(lng = ~longitude, ~latitude, popup = ~as.character(address)))
    
  } else if (input$displayMode == "night") {
    
    m <- leaflet(data = addressInfo) %>%
      setView(lat = center.lat, lng = center.long, zoom = init.zoom) %>%
      addProviderTiles("NASAGIBS.ViirsEarthAtNight2012") %>%
      addMarkers(lng = ~longitude, ~latitude, popup = ~as.character(address))
    
  }
  return(m)
  }) 
})


