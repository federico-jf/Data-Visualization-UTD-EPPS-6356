
#Data Visualization EPPS6356
#Final Presentation Code
#Federico Ferrero
#Fall 2020


# Clear environment 
rm(list=ls())
library(ggplot2)

# reading in the data
mydata <- read.delim("/Users/feder/Desktop/Alevelresults.txt")
head(mydata)

# Barplot A-level exam general results
area.color <- c("firebrick3", "firebrick3", "firebrick3", "springgreen4", "steelblue1", 
                "steelblue1", "steelblue1")
barplot<-ggplot(data=mydata, aes(x=Difference, y=Percentage)) +
  geom_bar(stat="identity", width=0.9, fill=area.color)+
  geom_text(aes(label=Percentage), vjust=-0.3, size=3.5)+
  labs(title="A-level results in UK (2020) compared with teachers' predictions", 
       caption= "Data Source: BBC", 
       x="Difference with teachers' predictions", y = "Percentage")+
  theme_minimal() + 
  geom_vline(xintercept = 3.5, linetype="dotted", 
             color = "firebrick3", size=1.1)+
  annotate("text", x = 1.9, y = 50, label = "Almost 4 out of 10", family="serif", size=5) +
  annotate("text", x = 1.9, y = 47, label = "students were downgraded",  family="serif", size=5) +
  theme(text=element_text(size=14,  family="serif"))
barplot

# Number of tweets per day: line chart
mydata3 <- read.delim("/Users/feder/Desktop/tweets_per_day.txt")
head(mydata3)
ggplot(data=mydata3, aes(x=Day, y=Number.of.tweets, group=1)) +
  geom_line(color="pink", size=2.5)+
  geom_text(aes(label=Number.of.tweets), vjust=-0.3, size=3.8, family = "serif")+
  geom_point()+
  labs(title="Number of tweets using #AlevelResults per day", 
       x="Day", y = "Number of tweets")+
  scale_color_brewer(palette="Paired")+
  geom_vline(xintercept = 1, linetype="dotted", 
             color = "red", size=1.2)+
  geom_vline(xintercept = 2.5, linetype="dotted", 
             color = "limegreen", size=1.2)+
  annotate("text", x = 4.7, y = 19000, label = "A-Level Results are published", family = "serif") +
  annotate("text", x = 2.3, y = 10000, label = "UK government", family = "serif") +
  annotate("text", x = 1.9, y = 8500, label = "anticipates", family = "serif") +
  annotate("text", x = 2.5, y = 7000, label = "''triple lock'' solution:", family = "serif") +
  annotate("text", x = 3.6, y = 5500, label = "acept, retake or receive mock grade", family = "serif") +
  theme_minimal()+
  theme(text=element_text(size=12, family = "serif", face = "bold"))


# Barplot faceted barplot: Top 10 tweeters using #AlevelResults by location
#reading in the data
mydata2 <- read.delim("/Users/feder/Desktop/top_tweeters.txt")
head(mydata2)

barplot2<-ggplot(data=mydata2, aes(x=number_of_followers, y=from_user, xaxt="n")) +
  geom_bar(stat="identity", width=0.9, fill="aquamarine3") +
  geom_text(aes(label=number_of_followers), vjust=-0.3, size=3) +
  labs(title="Top 10 tweeters using #AlevelResults by location", 
  x="Number of followers", y = "Tweet users") +
  theme(text=element_text(size=12,family="Serif")) +
  theme_light() +
  scale_x_continuous(limit=c(0,600000), breaks=seq(0,600000,600001)) +
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

## Clear environment 
rm(list=ls())
library(ggplot2)
library(readxl)
library(rlang)
library(readxl)
# reading in the data
complete_tweets <- read_excel("C:/Users/feder/Desktop/complete_tweets.xlsx")
View(complete_tweets)

# check if time is continuos variable
class(complete_tweets$time)

# scatterplot 
ggplot(aes(x=time, y=user_followers_count), data=complete_tweets) +
  geom_point(alpha=0.05, color= 'steelblue')+
    labs(title="How influential tweeters are?", 
       x="Time", y = "User's followers count")+
  scale_y_continuous(limit=c(1,25000), breaks = seq(0,25000,2500)) +
  theme(text=element_text(size=14,  family="Garamond")) +
  theme_minimal() 


## Sentiment Analysis
## Federico Ferrero

# clear environment 
rm(list=ls())

## set working directory
setwd("C:/Users/feder/Desktop")

# reading in the data: @BorisJohnson, prime minister
boris <- read.delim("/Users/feder/Desktop/boris.txt")

# TOKENIZATION: split text = it separes one by one the words from our database and indicates in which lines they are
library(tidytext)
## remove punctuation, convert to lowercase, add id for each tweet!
boris <- boris %>%
  dplyr::select(text) %>%
  unnest_tokens(word, text)
boris

# remove stop words
data(stop_words)

boris  <- boris %>%
  anti_join(stop_words)
boris

# count words
boris %>%
  count(word, sort = TRUE)

#library
library(ggplot2)

# plot the top 15 words 
boris %>%
  count(word, sort = TRUE) %>%
  top_n(15) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(x = word, y = n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip() +
  labs(x = "Count",
       y = "Unique words",
       title = "Top 15 unique words found in tweets that mention @BorisJohnson") +
  geom_bar(stat="identity", width=0.9, fill='lightpink1')+
  theme_minimal()

# wordcloud: most common words in tweets that mention @BorisJohnson
library(wordcloud)
boris %>%
  anti_join(stop_words) %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 100))

# generate a wordcloud showing sentiment analysis
library("reshape2")
boris %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("indianred3", "chartreuse4"), 
                   max.words = 100)

# @GavinWilliamson, Education Secretary
gavin <- read.delim("/Users/feder/Desktop/gavin.txt")

# remove punctuation, convert to lowercase, add id for each tweet!
gavin <- gavin %>%
  dplyr::select(text) %>%
  unnest_tokens(word, text)
gavin

# remove stop words
data(stop_words)

gavin  <- gavin %>%
  anti_join(stop_words)
gavin

# count words
gavin %>%
  count(word, sort = TRUE)

# plot the top 15 words 
gavin %>%
  count(word, sort = TRUE) %>%
  top_n(15) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(x = word, y = n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip() +
  labs(x = "Count",
       y = "Unique words",
       title = "Top 15 unique words found in tweets that mention @GavinWilliamson")+
  geom_bar(stat="identity", width=0.9, fill='bisque2')+
  theme_minimal()

# wordcloud: most common words in tweets that mention @BorisJohnson
library(wordcloud)
gavin %>%
  anti_join(stop_words) %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 100))

# generate a wordcloud showing sentiment analysis
library("reshape2")
gavin %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("indianred3", "chartreuse4"), 
                   max.words = 100)

# @ofqual, The regulator of qualifications, exams and assessments in England
ofqual <- read.delim("/Users/feder/Desktop/ofqual.txt")

# remove punctuation, convert to lowercase, add id for each tweet!
ofqual <- ofqual %>%
  dplyr::select(text) %>%
  unnest_tokens(word, text)
ofqual

# remove stop words
data(stop_words)

ofqual  <- ofqual %>%
  anti_join(stop_words)
ofqual

# count words
ofqual %>%
  count(word, sort = TRUE)

# plot the top 15 words 
ofqual %>%
  count(word, sort = TRUE) %>%
  top_n(15) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(x = word, y = n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip() +
  labs(x = "Count",
       y = "Unique words",
       title = "Top 15 unique words found in tweets that mention @ofqual") + 
  geom_bar(stat="identity", width=0.9, fill='darkslategray3')+
  theme_minimal()

# wordcloud: most common words in tweets that mention @BorisJohnson
library(wordcloud)
ofqual %>%
  anti_join(stop_words) %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 100))

# generate a wordcloud showing sentiment analysis
library("reshape2")
ofqual %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("indianred3", "chartreuse4"), 
                   max.words = 100)
