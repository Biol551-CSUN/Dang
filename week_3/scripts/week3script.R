############################################
#Practice with plotting #######
#Creator: Alex Dang ##########
############################################

### Load libraries #########
library(palmerpenguins)
library(tidyverse)

### Data analysis #########
glimpse(penguins)

### Plot practice #########
ggplot(data=penguins, ##creating plot
       mapping = aes(x = bill_depth_mm, ##adding x axis as bill depth
                     y = bill_length_mm, ##adding y axis as bill length
                     color = species, ##adding color
                     shape = species,##changing the shape of species
                     size = body_mass_g, ##changing the size of points
                     alpha = flipper_length_mm)) +  ###changing the transparency of the points
  geom_point() + ##making the plot into a scatter plot
  facet_grid(sex~species) + 
  guides(color = FALSE) +
  labs(title = "Bill depth and length", ##labeling and naming the labels
       subtitle = "Dimensions for Adelie, Chinstrap, Gentoo",
       x = "Bill depth (mm)", y= "Bill length (mm)",
    #  color = "Species",
      caption = "Source: Palmer Station LTER / palmerpenguins pacakge") + 
  scale_colour_viridis_d() ##changing color
##facet grid to add 2D grid