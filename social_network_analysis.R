#Project Data Visualization
# http://pablobarbera.com/big-data-upf/html/02a-networks-intro-visualization.html
#Federico Ferrero
#10/25/2020

# Clear environment 
rm(list=ls())

#call library
library(igraph)
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
V(g)$node_size <- degree(g)
V(g)$node_label <- ifelse( degree(g)>=15, V(g)$name, NA )

#plot in 2 columns
par(mfrow=c(1,2))

##plot the complete network
plot(g,
     vertex.color= "lightblue",
     vertex.size= V(g)$degree*0.4,
     edge.arrow.size= 0.01,
     vertex.label.family="Helvetica",
     vertex.label.size= V(g)$label,
     layout=layout.graphopt,
     main= "#AlevelResults complete network")



###
library(rtweet)
library(igraph)
library(ggraph)
require("hrbrthemes")
require("ggraph")
library(tidyverse)

V(g)$node_label <- unname(ifelse(degree(g)[V(g)] > 20, names(V(g)), "")) 
V(g)$node_size <- unname(ifelse(degree(g)[V(g)] > 20, degree(g), 0)) 


# People who more responds to others is highlighted / layout: linear, kk, 'stress', 'fr', 'lgl', 'graphopt' 
ggraph(g, layout = "kk") + 
        geom_edge_arc(edge_width=0.1, aes(alpha=..index..)) +
        geom_node_label(aes(label=node_label, size=node_size),
                        label.size=0, fill="#ffffff66", segment.colour="springgreen",
                        color="blue", repel=TRUE, family="Apple Garamond") +
        coord_fixed() +
        scale_size_area(trans="sqrt") +
        labs(title="#AlevelResults Retweet Relationships") +
        theme_graph(base_family="Apple Garamond") +
        theme(legend.position="none")

# People who more responds to others is highlighted / layout: 'stress'
ggraph(g, layout = "stress") + 
        geom_edge_arc(edge_width=0.1, aes(alpha=..index..)) +
        geom_node_label(aes(label=node_label, size=node_size),
                        label.size=0, fill="#ffffff66", segment.colour="springgreen",
                        color="blue", repel=TRUE, family="Apple Garamond") +
        coord_fixed() +
        scale_size_area(trans="sqrt") +
        labs(title="#AlevelResults Retweet Relationships") +
        theme_graph(base_family="Apple Garamond") +
        theme(legend.position="none")

# People who more responds to others is highlighted / layout:'fr' 
ggraph(g, layout = "fr") + 
        geom_edge_arc(edge_width=0.1, aes(alpha=..index..)) +
        geom_node_label(aes(label=node_label, size=node_size),
                        label.size=0, fill="#ffffff66", segment.colour="springgreen",
                        color="blue", repel=TRUE, family="Apple Garamond") +
        coord_fixed() +
        scale_size_area(trans="sqrt") +
        labs(title="#AlevelResults Retweet Relationships") +
        theme_graph(base_family="Apple Garamond") +
        theme(legend.position="none")

# People who more responds to others is highlighted / layout:  'lgl'
ggraph(g, layout = "lgl") + 
        geom_edge_arc(edge_width=0.1, aes(alpha=..index..)) +
        geom_node_label(aes(label=node_label, size=node_size),
                        label.size=0, fill="#ffffff66", segment.colour="springgreen",
                        color="blue", repel=TRUE, family="Apple Garamond") +
        coord_fixed() +
        scale_size_area(trans="sqrt") +
        labs(title="#AlevelResults Retweet Relationships") +
        theme_graph(base_family="Apple Garamond") +
        theme(legend.position="none")

# People who more responds to others is highlighted / layout:'graphopt' 
ggraph(g, layout = "graphopt") + 
        geom_edge_arc(edge_width=0.1, aes(alpha=..index..)) +
        geom_node_label(aes(label=node_label, size=node_size),
                        label.size=0, fill="#ffffff66", segment.colour="springgreen",
                        color="blue", repel=TRUE, family="Apple Garamond") +
        coord_fixed() +
        scale_size_area(trans="sqrt") +
        labs(title="#AlevelResults Retweet Relationships") +
        theme_graph(base_family="Apple Garamond") +
        theme(legend.position="none")

# People who more responds to others is highlighted / circular layout
ggraph(g, layout = 'linear', circular = TRUE) +
        geom_edge_arc(edge_width=0.125, aes(alpha=..index..)) +
        geom_node_label(aes(label=node_label, size=node_size),
                        label.size=0, fill="#ffffff66", segment.colour="springgreen",
                        color="blue", repel=TRUE, family="Apple Garamond") +
        coord_fixed() +
        scale_size_area(trans="sqrt") +
        labs(title="#AlevelResults Retweet Relationships") +
        theme_graph(base_family="Apple Garamond") +
        theme(legend.position="none")
