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
    center.lat <- 58.3
    center.long <- 15
    init.zoom <- 20
    
    if (input$googleMethodInput == "DB") {
      m <- leaflet(data = df) %>%
        addTiles() %>%
        addMarkers(lng = ~Longitude, 
                   lat = ~Latitude,
                   popup = paste("Offense", df$Offense, "<br>",
                                 "Year:", df$CompStat.Year))
      
    }
    else if (input$googleMethodInput == "latlng") {
      
      m <- leaflet(data = addressInfo) %>%
        addTiles() %>%
        # setView(lat = center.lat, lng = center.long, zoom = init.zoom) %>%
        addMarkers(lng = as.numeric(input$longText), 
                   lat = as.numeric(input$latiText))
    }
    else if (input$googleMethodInput == "CV") {
      myfile <- input$inputFile
      dataCv <- readCSVFile(myfile)
  print(dataCv)
      m <- leaflet(data = dataCv) %>%
        addTiles() %>%
        addMarkers(lng = ~Longitude, 
                   lat = ~Latitude,
                   popup = paste("Offense", df$Offense, "<br>",
                                 "Year:", df$CompStat.Year))
      
    }
    
    #----------------------------------------------------------------------------------------
    #  addressInfo <- subset(addressInfo, addressInfo$address != "ERROR")
    # empty dataframe
    if (input$displayMode == "classic") {
      m %>% addProviderTiles(providers$Esri.NatGeoWorldMap)
    } else if (input$displayMode == "satellite") {
      
      m<- leaflet(data =  addressInfo) %>%
        setView(lat = center.lat, lng = center.long, zoom = init.zoom) %>%
        addTiles(urlTemplate="http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}")
      
      
    } else if (input$displayMode == "night") {
      
      m <- leaflet(data = addressInfo) %>%
        setView(lat = center.lat, lng = center.long, zoom = init.zoom) %>%
        addProviderTiles("NASAGIBS.ViirsEarthAtNight2012") 
      
    } else if (input$displayMode == "mesonet") {
      m <- leaflet(data = addressInfo) %>% addTiles() %>% setView(-93.65, 42.0285, zoom = 4) %>%
        addWMSTiles(
          "http://mesonet.agron.iastate.edu/cgi-bin/wms/nexrad/n0r.cgi",
          layers = "nexrad-n0r-900913",
          options = WMSTileOptions(format = "image/png", transparent = TRUE),
          attribution = "Weather data © 2012 IEM Nexrad"
        )
    }
    
    return(m)
  }) 
})


