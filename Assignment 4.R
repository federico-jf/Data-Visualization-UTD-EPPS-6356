#Assignment 4
#10/06/2020
#Federico Ferrero
#Data Visualization


# Clear environment 
rm(list=ls())

# reading in the data
mydata <- read.delim("/Users/feder/Desktop/Alevelresults.txt")

library(ggplot2)

head(mydata)

# Basic barplot
barplot<-ggplot(data=mydata, aes(x=Difference, y=Percentage)) +
  geom_bar(stat="identity", width=0.9, fill="lightblue")+
  geom_text(aes(label=Percentage), vjust=-0.3, size=3.5)+
  labs(title="More than a third of A-level results in England downgraded", 
       x="Difference with teachers' predictions", y = "Percentage")+
  theme_minimal() + 
  theme(text=element_text(size=13,  family="serif"))
barplot  
