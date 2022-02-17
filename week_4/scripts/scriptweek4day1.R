######################################################
## This script is for practicing with dplyr##########
## Created by: Alex Dang############
## Updated on: 2022-02-15############
######################################################

## Load libraries ####################################
library(tidyverse)
library(palmerpenguins)
glimpse(penguins)

## Data analysis ######################################
## Before filtering
head(penguins)
## After filtering
filter(.data = penguins,
       sex == "female")

filter(.data = penguins,
       year == 2008| year == 2009,
       island != "Dream",
       species %in% c("Adelie", "Gentoo"))

data2<- mutate(.data = penguins,
               body_mass_kg  = body_mass_g/1000,      ## Adding body mass kg column
               bill_length_depth = bill_length_mm/bill_depth_mm,     ## Adding bill length depth column
               after_2008 = ifelse(year>2008, "After 2008", "Before 2008"),   ## Adding before/after 2008
               flipper_length_body_mass = flipper_length_mm/body_mass_g,      ## Adding flipper length body mass column
               body_mass_big_or_small = ifelse(body_mass_g>4000, "Big", "Small"))      ## Adding big/small body mass column
view(data2)

data3<- penguins %>%   ## Use penguins in dataframe
  filter(sex == "female") %>%    ## Select females
  mutate(log_mass = log(body_mass_g)) %>%   ## Calculate log biomass
  select(species, island, sex, log_mass)
view(data3)

data4<- penguins %>%
  drop_na(sex) %>%
  group_by(island, sex) %>%
  summarise(mean_fipper = mean(flipper_length_mm, na.rm = TRUE),      ## summarise function to calculate
            min_flipper = min(flipper_length_mm, na.rm = TRUE)) %>%
  view(data4)

penguins %>%
  drop_na(sex) %>%
  ggplot(aes(x = sex, y = flipper_length_mm)) +    
  geom_boxplot()