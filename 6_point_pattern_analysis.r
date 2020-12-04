setwd("/Users/emmahemmerle/Documents/EDU/UniBo/Ecosystem Monitoring/R Lab")

# Now we are going to load the dataset that we saved last time (the workspace) 
load("point_pattern_analysis.RData")
ls()
library(spatstat)
attach(lea)
marks(leo_ppp)<-chlh
chlh_map <- Smooth(leo_ppp)
cl <- colorRampPalette(c('blue','orange','red'))(100)
plot(chlh_map, col=cl)
points(leo_ppp)
