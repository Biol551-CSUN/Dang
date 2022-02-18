############################################################################
## This script is for practicing filtering data in lab###########################
## Created by: Alex Dang###############
## Updated on: 2022-02-15################
#################################################################################


## Load libraries################
library(tidyverse)
library(palmerpenguins)
library(beyonce)
library(sysfonts)
library(showtextdb)
library(showtext)
library(here)

glimpse(penguins)

  ## adding fonts
font_add_google("Neucha", "neucha")
font_add_google("Amatic SC", "amatic")

## Data analysis##################
head(penguins)

   ## part 1
data1<- penguins %>%   ## pulling penguins data and pipe
  drop_na(species, sex, island) %>%     ## taking out N/As from species, island, and sex, and pipe
  group_by(species, sex, island) %>%    ## grouping by species, island, and sex, and pipe
  summarise(.data = penguins,
            mean_body_mass = mean(body_mass_g, na.rm = TRUE),    ## calculating the mean for body mass
            variance_body_mass = var(body_mass_g, na.rm = TRUE)) %>%     ## calculating the variance for body mass
  filter(sex != "male") %>%   ## exlcudig out male penguins
  mutate(log_mass = log(body_mass_g)) %>%  ## calculating the log body mass
  select(species, island, sex, log_mass)  ## selecting columns for species, island, and sex

view(data1)

   ## part 2
showtext_auto()  ## automatically use showtext to render text

ggplot(data = data1, 
       mapping = aes(x = species, 
                     y = log_mass)) +    ## setting up the plot data
  geom_boxplot(aes(fill = species)) +       ## selecting type of plot
  scale_fill_manual(values = beyonce_palette(72)) +    ## adding colors to plot from beyonce palette
  labs(title = "Comparing Body Mass Across Female Penguins Species",   ## adding plot title
       x = "Species",                 ## adding x axis title
       y = "Log Body Mass (g)",       ## adding y axis title
       fill = "Species",              ## naming the legend key title 
       caption = "Source: Palmer Station LTER / palmerpenguins package") +    ## adding caption for source
  theme(plot.title = element_text(size = 26,       ## changing the size of plot title
                                  hjust = 0.5,     ## adjusting the centering of the plot title
                                  family = "amatic"),      ## changing the fonts of plot title
        axis.title = element_text(size = 14,               ## changing the size of axis titles
                                  family = "neucha"),      ## changing the fonts of axis titles
        panel.border = element_rect(fill = NA, color = "black"),    ## making the overall border of plot black
        legend.key = element_rect(fill = "lightgrey"),     ## adding lightgrey background box for the legend 
        legend.text = element_text(family = "neucha"),     ## changing the fonts for legend text
        legend.title = element_text(family = "amatic",     ## changing the fonts for legend title
                                    size = 18),            ## changing the size of legend title
        strip.background = element_rect(fill = "white",
                                        color = "black"))

## Plot output ######################
ggsave(here("week_4", "output", "penguins-female_log_body_mass-lab.png"),      ## saves the plot to output folder
       width = 3, height = 3)   ## in inches
