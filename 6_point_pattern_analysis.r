setwd("/Users/emmahemmerle/Documents/EDU/UniBo/Ecosystem Monitoring/R Lab")

# Now we are going to load the dataset that we saved last time (the workspace) 
load("point_pattern_analysis.RData")
ls()  ##this lists all of the files that we produced in the worksapce
library(spatstat)
attach(leo)

# map of amount of chlorophyl in the water (interpolation)(chlh)
marks(leo_ppp)<-chlh
chlh_map <- Smooth(leo_ppp)
cl <- colorRampPalette(c('blue','orange','red'))(100)
plot(chlh_map, col=cl)
points(leo_ppp)

# exercise: do the same for chlorophyl in the sediment (chls)
marks(leo_ppp)<-chls
chls_map<-Smooth(leo_ppp)
plot(chls_map, col=cl)
points(leo_ppp)

#displaying sevral graph on the same panel using par() function
#in this case the density map, and the 2 chlorophyl map 
#mfrow=c(1,3)) multiframe with 1 row and 3 columns 
#1st we will put the density map, we can recall what it is called using ls()
par(mfrow=c(1,3))
#1st plot
plot(density_map,col=cl)
points(leo_ppp)
#2nd plot
plot(chlh_map, col=cl)
points(leo_ppp)
#3rd plot
plot(chls_map, col=cl)
points(leo_ppp)

# now doing the opposite, 3 rows, 1 column
par(mfrow=c(3,1))
#1st plot
plot(density_map,col=cl)
points(leo_ppp)
#2nd plot
plot(chlh_map, col=cl)
points(leo_ppp)
#3rd plot
plot(chls_map, col=cl)
points(leo_ppp)

## use .RData extension to save workspace file. 
