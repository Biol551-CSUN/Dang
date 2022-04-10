######################################################################
## Practice getting help in R ########################################
## Created by: Alex Dang #############################################
## Updated on: 2022-04-05 ############################################
######################################################################


## Load libraries ###################################################
library(tidyverse)
library(here)

read_csv(here("week_10", "data", "stars.csv"))

## Data Analysis/Troubleshooting ####################################
mpg %>%
  ggplot(aes(x = displ, y = hwy)) %>%
  geom_point(aes(color = class))

data <- tibble::tribble(
  lat,long,star_no,
  33.548,-117.805,10L,
  35.534,-121.083,1L,
  39.503,-123.743,25L,
  32.863,-117.24,22L,
  33.46,-117.671,8L,
  33.548,-117.805,3L
)

data


## code an Uber ride with ubeR packgage