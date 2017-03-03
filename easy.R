##  Anant Gowadiya
##  Easy: Install package rgbif and download sample data for few species. Use package mapr to plot the occurrence data on maps.

library(rgbif)
library(mapr)
library(ggmap)
library(ggplot2)

#downloading occurence data for few species
alpaca <- occ_search(scientificName = 'Vicugna pacos', limit = 100, hasCoordinate = TRUE)
cow    <- occ_search(scientificName = 'Bos taurus'   , limit = 100, hasCoordinate = TRUE)
cougar <- occ_search(scientificName = "Puma concolor", limit = 100)

#plotting occurence data
map_ggmap(cougar,color = "orange",size = 1)
map_ggplot(cow,color ="blue",size = 1)
gbifmap(alpaca$data)
