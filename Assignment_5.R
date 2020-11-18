#Assignment 5
#10/10/2020
#Federico Ferrero
#Data Visualization


# Clear environment 
rm(list=ls())
library(ggplot2)

# Number of tweets per day: line chart
mydata3 <- read.delim("/Users/feder/Desktop/tweets_per_day.txt")
head(mydata3)
ggplot(data=mydata3, aes(x=Day, y=Number.of.tweets, group=1)) +
  geom_line(color="pink", size=1.5)+
  geom_text(aes(label=Number.of.tweets), vjust=-0.3, size=3.5)+
  geom_point()+
  labs(title="Number of tweets using #AlevelResults per day", 
       x="Day", y = "Number of tweets")+
  scale_color_brewer(palette="Paired")+
  theme_minimal()+
  theme(text=element_text(size=10,  family="Optima", , face = "bold")) + 
  geom_vline(xintercept = 5, linetype="dotted", 
                color = "blue", size=1.0)+
  annotate("text", x = 8.3, y = 18000, label = "UK government offered a solution")


