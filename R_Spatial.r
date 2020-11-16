# R Spatial 
# recalling the package that we have already used 
library(sp)
data(meuse)
attach(meuse)
# ~ --> alt+n means equal in R 
#we are grouping the coordinates, but this is specific to this dataset
coordinates(meuse)=~x+y
#now if you plot the dataset, you will see the dataset in space, i.e. how all the different units are spaced
plot(meuse)

#looking at where zinc is higher than in the other places
# we are going to use sp plot function, which is specific to the sp package
# spplot is used to plot elements like zinc, lead, etc., in space 
spplot(meuse, "zinc")
# you get different colors for different levels of zinc concentrations
# adding a title by using the argument main 
spplot(meuse, "zinc", main="Concentration of Zinc")

# now we do the same with another element: copper
spplot(meuse, "copper", main="Concentration of Copper")

#New exercise
# see copper and zinc in two different panels 
spplot(meuse,c("zinc","copper"))
# concentrations are higher in the west of the plot, and this is essentially because there is a river passing there that is bringing in pollutants 


#now rather than using colors, let's make use of bubbles of size proportional to the value of the variable in that place 
bubble(meuse,"zinc")


#downloading ggplot2 package
install.packages("ggplot2")
# There is also the option to download packages from GitHub if it doesn't work from CRAN (is the package is also stored in GitHub). 
# using brackets in R: 
## when you are refrring to something that is outside of R : e.g. a package 
## when you want to give something a name/title 
## when you are mentionning colors, because that is just the way they are stored in R
library(ggplot2)

## ecological dataframe
# making up a biofuels variable (in joules per sample)
biofuels<-c(120,220, 350, 570, 750) # array of values
# oxidative enzymes
oxidative<-c(1200,1300,21000,34000,50000)
# now building the data frame, i.e. a table with our 2 variables
# 1st column= 1st variable;; 2nd column = 2nd variable
d<-data.frame(biofuels,oxidative)
d

## ggplot
# aes= aestetics 
#geom_point so that we actually see data points on the graph
ggplot(d,aes(x=biofuels,y=oxidative))+geom_point()

## let's make some changes to the plot
ggplot(d,aes(x=biofuels,y=oxidative))+geom_point(size=5,col="red")

##representing it as a trend instead of points 
ggplot(d,aes(x=biofuels,y=oxidative))+geom_line()
## using both points and line
ggplot(d,aes(x=biofuels,y=oxidative))+geom_point(size=5,col="red")+geom_line()
## using polygons
## even though here it's not really relevat from a ecological pov
ggplot(d,aes(x=biofuels,y=oxidative))+geom_plygon()

## SET A WORKING DIRECTORY 
setwd("/Users/emmahemmerle/Documents/EDU/UniBo/Ecosystem Monitoring/R Lab")
getwd()

## IMPORTING DATA FROM OUTSIDE 
## read.table function to import data from outside
## an alternative is the read.csv function 
## header=TRUE means that the table has names (a header) for the variables
covid<-read.csv("covid_agg.csv", header=TRUE)
