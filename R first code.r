# use hashtag to write a comment, to explain the functions, R will not read this line 

# number of primates observed by Jonas at 5 different sites
# below is an array, so we put a c in front of it
primates <- c(3, 5, 9, 15, 40)
primates

# new dataset
# imagine that you have primates that are eating crabs 
#chloe went to the same 5 sites as Jonas, and measured the number of crabs
crabs <- c(100, 70, 30, 10, 5)

# first plot in R 
plot(primates, crabs)

# rectifying the plot 
# changing the color of the plot
plot(primates, crabs, col="cyan1")
# this changes the color of the data points on the graph 
# now we are changing the shape of the data point sympols, different point characters are attributed a number in R 
# 17= filled-in triangle
plot(primates, crabs, col="coral4", pch=17)
# now we want to increase the size of the points on the plot, and this is done through an argument called character exaggeration (cex)
# The number you put in equals the number by which you will multiply the size of the datapoints
plot(primates, crabs, col="coral4", pch=17, cex=2)
# now we add a title to the graph, the argument is called "main", for main title
plot(primates, crabs, col="coral4", pch=17, cex=2, main= "My first ecological graph in R")

# A good function to create tables is the "data.frame" function
ecoset<- data.frame(primates, crabs) 
ecoset

# some calculations on our dataset 
mean(primates)
mean(crabs)

# summary function
summary (ecoset)

# now working on a real dataset 
