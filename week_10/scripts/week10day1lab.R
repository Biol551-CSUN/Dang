#######################################################
## Creating bugs and Debugging ########################
## Created by: Alex Dang ##############################
## Updated on: 2022-04-05 #############################
#######################################################

## Load libraries #####################################
library(tidyverse)
library(palmerpenguins)


stars <- read_csv(here("week_10", "data", "stars.csv"))


## Data Analysis #####################################
## GRP5: Alex, Vivian, Sophia, Brandon ##
## Creating bugs
penguin %>%
  ggplot(aes(x = bill_depth_mm, y = bill_depth_mm),
         color = islands) +
  geom_point() +
  geom_smooth(method = lm) +
  labs(title = "Penguins Bills",
       x = "Depth (mm)", y = "Length (mm)",
       color = "Islands")

## Debugging
## GRP1 ##
stars %>%
  ggplot(aes(x = lat,
             y = long)) +
  geom_point() +
  theme(axis.title = element_text(size = 2),
        panel.background = element_rect(fill = 'blue'),
        plot.background = element_rect(fill = 'white')) +
  labs( x = "Latitude",
        y = "Longitude")