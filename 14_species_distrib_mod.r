# Species distribution modelling 

library(sdm)
library(rgdal)
library(raster)


#importing species data

# using the system file function so that we can get a file from a specific package 
# .sph means shapefile 
file<-system.file("external/species.shp", package="sdm")
species <- shapefile(file) #we are explaining to R that we are going to use it as a shapefile
#another option would have been using the readOGR function

#looking at the set
species
#output= 200 features (i.e. points), extent (xmin xmax, ymin ymax), UTM used (zone 30 under WGS84)
# only one variable called var which takes values of 0 or 1 (presence or absence)


#plotting the set
plot(sepcies)
# you have one cross for each feature/point (i.e. both the PRESENCES and the ABSENCES)
#you can change point characters (pch)
plot(species, pch=17)

# separating out the presences and absences
species$Occurrence
# plotting the presences and the absences in different colors 
plot(species[species$Occurrence==1,],col='blue',pch=17) #making subsets using quadratic brackets
# use of points function to add points to a previous plot 
points(species[species$Occurrence==0,],col='red',pch=17) #'==' SQL (requests) code to say equal
# the comma at the end of the quadratic brackets is used to say that we are ending the selection
# now we have the presences in blue, and absences in red


path <- system.file("external", package="sdm") 
#selecting all of the files which have the .asc extension
lst <- list.files(path=path,pattern='asc$',full.names = T)
lst
#we end up with elevation, vegetation, precipittion and temperature files

#plotting predictors
preds<-stack(lst)
cl<-colorRampPalette(c('blue','orange','red','yellow'))(100)
plot(preds, col=cl)
# we get four plot, one for each environmental var as an output

# plot predictors and occurrences
plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=17)

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=17)

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=17)

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=17)

#exploratory viewing of our species distribution 
# we have noticed that our species in likes high temperatures, mid elevations, high levels of precipitation, etc 


# creating the model

#explaining what data we are going to use 
#sdmData function: Specifies which species and explanatory variables should be taken from the input data. 
datasdm <- sdmData(train=species, predictors=preds)
# train: Training data containing species observations as a data.frame or SpatialPoints or SpatialPointsDataFrames
datasdm
#output= nb of sp (1), nb of features (4), nb of records (200)
# has independent test data(here false)= used to check randomness of data, checking for multicollinearity between several variables
# in general, it is a good idea not to use to many variables, because we might get very good fit to our model, but it will have high level of collinearity between variables



# model
#using generalized linear model 
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")

# make the raster output layer
p1 <- predict(m1, newdata=preds) 
#putting model in along with the predictors 

# plot the output
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=17)
#map is probability of occurrence of the species, from 0 to 1 (0 species is not expected to be there)
# for of the original occurence points are falling within the high values 
# this is just one model, so there might be some discrepancies


#making a final stack where we add everything together
# add to the stack the predictions and the map which is the output of our model
s1 <- stack(preds,p1)
plot(s1, col=cl)
# we get 5 images: 1 for each var, and one for the probability of distribution of the species

