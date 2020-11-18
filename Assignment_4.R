#Assignment 4
#10/06/2020
#Federico Ferrero
#Data Visualization EPPS6356


# Clear environment 
rm(list=ls())
library(ggplot2)

# reading in the data
mydata <- read.delim("/Users/feder/Desktop/Alevelresults.txt")
head(mydata)

# Barplot A-level exam general results
area.color <- c("firebrick3", "firebrick3", "firebrick3", "springgreen4", "steelblue1", "steelblue1", "steelblue1")
barplot<-ggplot(data=mydata, aes(x=Difference, y=Percentage)) +
  geom_bar(stat="identity", width=0.9, fill=area.color)+
  geom_text(aes(label=Percentage), vjust=-0.3, size=3.5)+
  labs(title="A-level results in UK (2020) compared with teachers' predictions", 
       caption= "Source: BBC", 
       x="Difference with teachers' predictions", y = "Percentage")+
  theme_minimal() + 
  theme(text=element_text(size=13,  family="serif"))
barplot

# Barplot faceted barplot: Top 10 tweeters using #AlevelResults by location
#reading in the data
mydata2 <- read.delim("/Users/feder/Desktop/top_tweeters.txt")
head(mydata2)

barplot2<-ggplot(data=mydata2, aes(x=number_of_followers, y=from_user)) +
  geom_bar(stat="identity", width=0.9, fill="lightgreen")+
  geom_text(aes(label=number_of_followers), vjust=-0.3, size=3.5)+
  labs(title="Top 10 tweeters using #AlevelResults by location", 
       x="Number of followers", y = "Tweet users")+
  theme_minimal() + 
  theme(text=element_text(size=13,family="NimbusRom"))+
  facet_wrap(~location, ncol=2)
barplot2 

# Number of tweets per day
mydata3 <- read.delim("/Users/feder/Desktop/tweets_per_day.txt")
head(mydata3)

barplot3<-ggplot(data=mydata3, aes(x=Number.of.tweets, y=Day)) +
  geom_bar(stat="identity", width=0.9, fill="orange")+
  geom_text(aes(label=Number.of.tweets), vjust=-0.3, size=3.5)+
  labs(title="Number of tweets using #AlevelResults per day", 
       x="Number of tweets", y = "Day")+
  theme_minimal() + 
  theme(text=element_text(size=10,family="sans"))

# Horizontal bar plot
barplot3 + coord_flip()
