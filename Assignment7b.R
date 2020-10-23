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
      
