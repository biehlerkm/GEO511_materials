#script to calculate petal length and plot petal length
#load the library you need
library(ggplot2)
#load the data set
data(iris)
#this shows you just the column of petal length
iris$Petal.Length
#calculate the mean
petal_length_mean <- mean(iris$Petal.Length)
#plot all petal lengths in a histogram
qplot(iris$Petal.Length, geom = "histogram")
# create a histogram with different settings
qplot(iris$Petal.Length, geom = 'histogram', main = "Petal Length Count", xlab = "Petal Length", 
      ylab = "Count", colour = I("black"),fill = I("green"))

#code from class
library(tidyverse)
ggplot(iris, aes(x = Petal.Length, fill = Species)) +
  geom_histogram(bins = 50) +
  facet_grid(Species ~.) +
  theme_bw()+
  ggtitle("Iris Dataset")+
  theme(plot.title = element_text(hjust = 0.5))
