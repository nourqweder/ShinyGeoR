library(shiny)
library(leaflet)
library(dplyr)
library(tidyr)
library(tidyverse)


df = read.csv("./Data/NYPD_7_Major_Felony_Incidents.csv", stringsAsFactors = F)


df <- tidyr::separate(data=df, 
                      col=Location.1, 
                      into=c("Latitude", "Longitude"), 
                      sep=",",
                      remove=FALSE)

df$Latitude <- stringr::str_replace_all(df$Latitude, "[(]", "")
df$Longitude <- stringr::str_replace_all(df$Longitude, "[)]", "")


df$Latitude <- as.numeric(df$Latitude)
df$Longitude <- as.numeric(df$Longitude)
saveRDS(df, "./data.rds")


sample_data <- df[c(1:1000),]
saveRDS(sample_data, "./sample_data.rds")