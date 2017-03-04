## Anant Gowadiya
## Medium: Write a R function to check dates of all the records downloaded from GBIF for a set of species.
## (Number of records > 10,000) and add a flag field indicating quality of the date field data.

library(rgbif)

#funnction to check quality of date and to add a flag field
checkDate <- function(species_dat)
{
  species_data<- species_dat

  #adding column datequality as a flag field
  species_data <- cbind(species_data, datequality = "good")
  species_data$datequality <- as.character(species_data$datequality)

  #checking every row for availability of day, month, year
  #if field year is missing quality is very bad
  #if field month is missing quality is bad
  #if field day is missing quality is medium
  #if all field are present quality is good
  for(i in 1:length(species_data$datequality))
  {
    #checking year
    if (is.na(species_data$year[i])){ species_data$datequality[i] <- "very bad"}
    #checking month
    else if (is.na(species_data$month[i])){ species_data$datequality[i] <- "bad"}
    #checking day
    else if (is.na(species_data$day[i])){ species_data$datequality[i] <- "medium"}

  }
  #call by reference i.e. changing value of original object passed to function
  eval.parent(substitute(species_dat<-species_data))
  #printing only the head part
  head(species_data[,c("year","month","day","datequality")])
}

#loading sample data
India<-occ_search(country = "IN",limit = 11000)
#calling function to check date and adding flag field
checkDate(India$data)
