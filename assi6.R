
library(ggmap)
library(tidyverse)

#We get the geocode for the overall map that we center in Summerleaze Beach, Bude.
gc <- geocode("Summerleaze Beach, Bude, England")
map <- get_map(gc, zoom = 15)
map_w <- get_map(gc, maptype = "watercolor", zoom = 15)


#We get the code of the different place we want to show on the map

b1 <- geocode("Summerleaze Beach, Bude, England")
b2 <- geocode("Crooklets Beach, South West Coast Path, Bude, England")
crick <- geocode("S W Coast Path, Bude EX23 8HN, England")
pub <-  geocode("Life's A Beach, Summerleaze Crescent, Bude, UK")
castle <- geocode("The Wharf, Bude EX23 8LG, UK")
golf <- geocode("Burn View, Bude EX23 8DA, UK")
compass <- geocode("Bude EX23 8SE, UK")
#Let's create a dataframe containing the locations and names of the places we want to display


data1 <- rbind(b1,b2,crick,pub,castle,golf,compass)
names <- c("Summerleaze Beach","Crooklets Beach",
           "Cricket's grounds","Pub Life's a Beach","The Castle Bude","Golf Club",
           "Compass Point")
data1 <- cbind(data1,names)

#Let's create the route from the Cricket ground to the Pub.

from <- "S W Coast Path, Bude EX23 8HN, UK"
to <- "Life's A Beach, Summerleaze Crescent, Bude, UK"
route_df <- route(from, to,mode="walking", structure = "route")


ggmap(map) +
  geom_path(
    aes(x = lon, y = lat), colour = "tomato4", size = 1,
    data = route_df, lineend = "round"
  ) +
  geom_point(
    aes(x = lon, y = lat, col = names),
    data = data1,size = 5) +
  geom_text(x=-4.550, y=50.8337, label="5 min walk!", angle = 45, colour = "tomato4",size = 4)+
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank())




ggmap(map_w) +
  
  geom_label(aes(x = lon, y = lat, label = names, col=names),
             fontface = "bold" ,data = data1,
             hjust = 0, nudge_x = 0.0005) +
  geom_point(
    aes(x = lon, y = lat, col = names),
    data = data1) +
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),legend.position="none")+
  geom_text(x=-4.545, y=50.825, label="Bude",fontface =2,size=10, colour = "tomato4")


