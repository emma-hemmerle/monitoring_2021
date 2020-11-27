# title of the script: R code for plotting the relationship between or among several ecological variables
# today, we are not inventing data, we are going to be using data from a package
# e.g. rasterdiv package built by some of Duccio's students to calculate biodiversity directly from remote sensing
# today, we are going to make use of a package called 'sp' built to look at spatial data
# page with all the info about the package: https://cran.r-project.org/web/packages/sp/index.html
# you can use the R documentation webpage to look up any function: https://www.rdocumentation.org/

# How to install the package? 
# we are going to use the function "install.packages", and the argument will be the name of the package
# using brackets because packages, before you install them, are external to the main software
install.packages("sp")

library(sp)

# another function that does it same thing (attach/start using the package) is called 'require'
# for the library function, we no longer have to use brackets around sp, because the package is now already inside of R (it wasn't before we installed it)
# data function is used to recall datasets

data(meuse)

# look inside the dataset
meuse
# the data set can be seen 
# View function: warning, R is case sensitive, and the View function has a capital 'V'
# the View function doesn't automatically work on R, you need to download Quartz: https://www.xquartz.org
View(meuse)
# with the head function, you will only see the first couple of rows
head(meuse)

#finding the means of all of the variables
# by using the summary function 
summary(meuse)

# now we want to make a plot
# looking at the relationship between two variables
# zinc on Y axis, Cadmium on X axis
attach(meuse)
plot(cadmium,zinc)

# another way to go about it is the following:
# $ symbol is used in R to link different parts
plot(meuse$cadmium,meuse$zinc)

#plotting all the variables, against all the other variables (pair-wise plots for all the variable)
#you can use scatter plot matrices with the pairs function
pairs(meuse)

#question to answer before next lecture
# pairing only the elelents part of the dataset (how do you do that)? 
# so instead of pairing all the variables (you only pair cadmium, copper, zinc and lead). 

subsetmeuse<-c("cadmium","copper","zinc","lead")
subsettedmeuse<-meuse[subsetmeuse]
pairs(subsettedmeuse)


#start of the second lecture spent on these ecological variables
# the columns we are interested in are actually culumn number 3 through to column number 6
pairs(meuse[,3:6])
# we use the comma before the 3, to say that this is where we are starting from
# by default when we do this, R is looking at columns, if you want to subset using rows, you have to use specific functions, such as slice, filter, 
# R starts counting from 1 rather than 0 (as is the case in Python for instance)
pairs(~cadmium+zinc+copper+lead, data=meuse)
# ~ (tilde) means equal in R 
# [] = alt+shift+(/)
pairs(meuse[c("cadmium", "copper", "zinc", "lead")])

#rectifying the pairs graph 
#you have to use brackets when writing in the name of the color 
# pch is for point character
pairs(~cadmium+zinc+copper+lead, data=meuse, col="plum1", pch=20, cex= 0.5)
