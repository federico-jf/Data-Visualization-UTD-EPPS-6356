#Assignment 4
#10/06/2020
#Federico Ferrero
#Data Visualization

# reading in the data
mydata <- read.delim("/Users/feder/Desktop/Alevelresults.txt")

library(ggplot2)

head(mydata)

# Basic barplot
barplot<-ggplot(data=mydata, aes(x=Difference, y=Percentage)) +
  geom_bar(stat="identity", width=0.9, fill="steelblue")+
  geom_text(aes(label=Percentage), vjust=-0.3, size=3.5)+
  theme_minimal()
barplot
