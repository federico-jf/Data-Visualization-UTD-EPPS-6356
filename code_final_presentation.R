
###### Data Visualization EPPS6356 #######
# Professor: Dr. Karl Ho
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


# Faceted barplot: Top 10 tweeters using #AlevelResults by location
# reading in the data
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



###### SOCIAL NETWORK ANALYSIS #######
# Clear environment
rm(list=ls())

#call libraries
library(igraph)
library(rtweet)
library(igraph)
library(ggraph)
require("hrbrthemes")
require("ggraph")
library(tidyverse)

# reading in the data

g <- read.delim("/Users/feder/Desktop/BASE.txt")
g <- read.delim("/Users/feder/Desktop/BASE2.txt")# this base contains from 14 to 17 Aug
g <- read.delim("/Users/feder/Desktop/BASE14.txt")

# create data graph
g <- graph.data.frame(g, directed= T)

# remove loops in the igraph
g <- simplify(g, remove.multiple = F, remove.loops = T) 

# check number of edges and nodes
E(g)# edges= 2312
V(g)# vertex= 49111

# defining labels and degrees
V(g)$node_label <- unname(ifelse(degree(g)[V(g)] > 20, names(V(g)), "")) 
V(g)$node_size <- unname(ifelse(degree(g)[V(g)] > 20, degree(g), 0)) 

# People who are more mentioned is highlighted / layout: kk 
ggraph(g, layout = "kk") + 
        geom_edge_arc(edge_width=0.1, aes(alpha=..index..)) +
        geom_node_label(aes(label=node_label, size=node_size),
                        label.size=0, fill="#ffffff66", segment.colour="springgreen",
                        color="blue", repel=TRUE, family="Apple Garamond") +
        coord_fixed() +
        scale_size_area(trans="sqrt") +
        labs(title="#AlevelResults: tweeters who are more mentioned") +
        theme_graph(base_family="Apple Garamond") +
        theme(legend.position="none")




###### SENTIMENT ANALYSIS ########
# Federico Ferrero
# Text mining exercises following Text Mining with R (Silge and Robinson, 2017)

# clear environment 
rm(list=ls())

## set working directory
setwd("C:/Users/feder/Desktop")

# reading in the data: @BorisJohnson, prime minister
boris <- read.delim("/Users/feder/Desktop/boris.txt")

# TOKENIZATION: split text = it separes one by one the words from our database and indicates 
# in which lines they are
library(tidytext)
# remove punctuation, convert to lowercase, add id for each tweet!
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
  labs(x = "Unique words",
       y = "Count",
       title = "Top 15 unique words found in tweets that mention @BorisJohnson") +
  geom_bar(stat="identity", width=0.9, fill='lightpink1')+
  theme_minimal()

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
  labs(x = "Unique Words",
       y = "Count",
       title = "Top 15 unique words found in tweets that mention @GavinWilliamson")+
  geom_bar(stat="identity", width=0.9, fill='bisque2')+
  theme_minimal()

# wordcloud: most common words in tweets that mention @GavinWilliamson
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
  labs(x = "Unique words",
       y = "Count",
       title = "Top 15 unique words found in tweets that mention @ofqual") + 
  geom_bar(stat="identity", width=0.9, fill='darkslategray3')+
  theme_minimal()

# wordcloud: most common words in tweets that mention @ofqual
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




####### SHINY APP ########
##Assignment 7b = my personal databases
##Federico Ferrero
## Adapted from Beeley, Chris and Shitalkumar R. Sukhdeve, 2018. Web application development 
## with R using Shiny (3rd ed.) Packt Publishing Ltd.
## Also, https://shiny.rstudio.com
# Packages:  readr, shiny

# This example demonstrates a core feature of Shiny: **reactivity**. 
# In the `server` function, a reactive called `datasetInput` is declared. 
# Notice that the reactive expression depends on the input expression `input$dataset`, 
# and that it's used by two output expressions: `output$summary` and `output$view`. 
# Try changing the dataset (using *Choose a dataset*) while looking at the reactive and then at the outputs; 
# you will see first the reactive and then its dependencies flash. 

# Notice also that the reactive expression doesn't just update whenever anything changes--only the inputs it depends on will trigger an update. 
# Change the "Caption" field and notice how only the `output$caption` expression is re-evaluated; the reactive and its dependents are left alone.

require("readr")
require("shiny")
library(readr)
library(shiny)
library(rsconnect)
# Loading datasets
a_level_data <- read_csv("https://raw.githubusercontent.com/federico-jf/Data-Visualization-UTD-EPPS-6356/master/a_level_data.csv")
mundial_bank_data <- read_csv("https://raw.githubusercontent.com/federico-jf/Data-Visualization-UTD-EPPS-6356/master/mundial_bank_data.csv")

# Define UI for dataset viewer app ----
ui <- fluidPage(
  # App title ----
  titlePanel("Federico Ferrero Datasets"),
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Text for providing a caption ----
      # Note: Changes made to the caption in the textInput control
      # are updated in the output area immediately as you type
      textInput(inputId = "caption",
                label = "Caption:",
                value = "Datasets"),
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = c("a_level_data","mundial_bank_data")),
      
      # Input: Numeric entry for number of obs to view ----
      numericInput(inputId = "obs",
                   label = "Number of observations to view:",
                   min=0,
                   value = 15)
      
    ),
      # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Formatted text for caption ----
      h3(textOutput("caption", container = span)),
      
      # Output: Verbatim text for data summary ----
      verbatimTextOutput("summary"),
      
      # Output: HTML table with requested number of observations ----
      tableOutput("view")
      
    )
  )
)
# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  # Return the requested dataset ----
  # By declaring datasetInput as a reactive expression we ensure
  # that:
  #
  # 1. It is only called when the inputs it depends on changes
  # 2. The computation and result are shared by all the callers,
  #    i.e. it only executes a single time
  datasetInput <- reactive({
    switch(input$dataset,
           "a_level_data"=a_level_data,
           "mundial_bank_data"=mundial_bank_data)
  })
  
  # Create caption ----
  # The output$caption is computed based on a reactive expression
  # that returns input$caption. When the user changes the
  # "caption" field:
  #
  # 1. This function is automatically called to recompute the output
  # 2. New caption is pushed back to the browser for re-display
  #
  # Note that because the data-oriented reactive expressions
  # below don't depend on input$caption, those expressions are
  # NOT called when input$caption changes
  output$caption <- renderText({
    input$caption
  })
  
  # Generate a summary of the dataset ----
  # The output$summary depends on the datasetInput reactive
  # expression, so will be re-executed whenever datasetInput is
  # invalidated, i.e. whenever the input$dataset changes
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  # Show the first "n" observations ----
  # The output$view depends on both the databaseInput reactive
  # expression and input$obs, so it will be re-executed whenever
  # input$dataset or input$obs is changed
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)
