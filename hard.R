## Anant Gowadiya
## Hard: Write a function to identify records very close to centroid of any country

#require centroid.csv file containing latitude and longitude of centroid of country
centroids<-read.csv(file = "centroid.csv",header = TRUE)

library(rgbif)
library(mapr)
library(ggmap)
library(ggplot2)
library(geosphere)

#Function to calculate points within 500 kilometres radius by default from the centroid of any country

#You can also pass radius as parameter to chose how close you want to be to the centroid of any country

#You can also chose precision. High precison method uses an ellipsoid to calculate distances
#and the results are very accurate. High precision method is computationally more intensive.

closest_to_centroid <- function(dat,country_code,radius=500000,high_precision=FALSE){

  dist<-NULL
  #calculating distance between centroid and the occurence data
  if(high_precision==FALSE){
    dist <- distm(dat$data[,c(4,3)], centroids[centroids$country == country_code,c(3,2)], fun = distHaversine)}
  else {
    dist <- distm(dat$data[,c(4,3)], centroids[centroids$country == country_code,c(3,2)], fun = distVincentyEllipsoid)}

  dist<-dist[,!colSums(is.na(dist))>0]

  #adding field containg distance from centroid
  dat$data <- cbind(dat$data,centroid_dist=dist)

  #removing data which is outside the circle with centre as centroid of given country and radius as given by use/default
  dat$data = dat$data[dat$data$centroid_dist < radius,]

  return(dat)
}

bengal_tiger <- occ_search(scientificName = "Panthera tigris tigris",country = "IN", limit=1000,hasCoordinate = TRUE)
tiger_near_centroid <- closest_to_centroid(bengal_tiger,"IN")
map_ggmap(tiger_near_centroid, zoom = 5, size=1)

