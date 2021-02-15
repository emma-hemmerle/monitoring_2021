#setting my working directory 
setwd("/Users/emmahemmerle/Documents/EDU/UniBo/S1/Ecosystem Monitoring/R Lab/Final Exam")
getwd()


#recalling all of the libraries that I will be needing, and installing the ones I have not yet installed 
library(rgdal)
library(rgeos)
library(raster)
library(scales)
install.packages("dismo")
library(dismo)
install.packages("rgbif")
library(rgbif)
install.packages("maxnet")
install.packages("geosphere")
library(maxnet)
library(geosphere)


# downloading species occurence data from GBIF for Bombus affinis


