#' A Shiny app for RAPI package
#' @title ShinyMAp
#' @import shiny
#' @export
library(shiny)
library(leaflet)
library(dplyr)
library(shiny)
library(devtools)
library(ggmap)
library(ggplot2)
devtools::install_github("nourqweder/RAPI", subdir="RAPI", quiet = TRUE)
library(RAPI)
df <- readRDS("./sample_data.rds")