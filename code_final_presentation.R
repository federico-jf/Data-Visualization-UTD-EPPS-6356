
##Sentiment Analysis
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
