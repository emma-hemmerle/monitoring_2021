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
