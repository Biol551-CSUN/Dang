### Today we are going to plot penguin data ##########
### Created by: Alex Dang ##########
### Updated on: 2022-02-10 ################
#############################################################

#### Load libraries ############
library(palmerpenguins)
library(beyonce)
library(tidyverse)
library(here)

#### Load data ################
glimpse(penguins)

### Data analysis ################
## Plot 1 #############
plot1<-ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     color = species)) + 
  geom_point()+
  geom_smooth(method = "lm")+     ## method "lm" in geom_smooth makes it linear
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)") + 
  scale_color_manual(values = beyonce_palette(101)) +    ### setting specific colors manually
  theme_bw() +
  theme(axis.title = element_text(size = 20,
                                  color = "red"),
        panel.background = element_rect(fill = "linen"),
        panel.border = element_rect(fill = NA, color = "red"))


## scale_x_continuous adjusts scales (x axis), makes sure to put "c()"

## coord_flip flips the x and y axes
## coord_fixed fix axes
## coord_trans sets the measurements of coord ex. log10
## coord_polar makes spiral plot

### Plot output ################
ggsave(here("week_3", "output", "penguin-lecture.png"),      ## saves the plot to output folder
       width = 7, height = 5)   ## in inches

