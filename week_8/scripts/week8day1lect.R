###############################################################
## Practice with advanced plotting ############################
## Created by: Alex Dang ######################################
## Updated on: 2022-03-15 #####################################
###############################################################


## Load libraries ############################################
library(tidyverse)
library(here)
library(patchwork)
library(ggrepel)
library(gganimate)
library(magick)
library(palmerpenguins)


## Data analysis ##############################################
## Patchwork
# plot 1
p1<-penguins %>% 
  ggplot(aes(x = body_mass_g, y = bill_length_mm, color = species)) +
  geom_point()
p1


# plot 2
p2<-penguins %>% 
  ggplot(aes(x = sex, y = body_mass_g, color = species)) +
  geom_jitter(width = 0.2)
p2


p1+p2 +                                ## brings the two plots together in one panel (side by side)
  plot_layout(guides = 'collect') +    ## group the legends
  plot_annotation(tag_levels = 'A')    ## add labels (ex. A,B)

p1/p2 +                                ## puts plots on top of each other
  plot_layout(guides = 'collect') +    ## group the legends
  plot_annotation(tag_levels = 'A')    ## add labels (ex. A,B)


## ggrepel
view(mtcars)
ggplot(mtcars, aes(x = wt, y = mpg, label = rownames(mtcars))) +
  geom_label_repel() +                       
  geom_point(color = 'red')

## geom_text() creates a text label
## geom_text_repel() repel the labels
##geom_label_repel() makes boxed-labels and repels them


## gganimate
penguins %>% 
  ggplot(aes(x = body_mass_g, y = bill_depth_mm, color = species)) +
  geom_point() +
  transition_states(year,                      ## what are we animated by
                    transition_length = 2,     ## the relative length of the transition
                    state_length = 1) +        ## the length of the pause between transition
  ease_aes("sine-in-out") +
  ggtitle('Year: {closest_state}')  +          ## add a transition title
  anim_save(here("week_8", "output", "mypenguingif.gif"))    ## saves it as a gif


## Magick
penguin<-image_read("https://pngimg.com/uploads/penguin/pinguin_PNG9.png")
penguin

penplot<-penguins %>% 
  ggplot(aes(x = body_mass_g, y = bill_depth_mm, color = species)) +
  geom_point() 

penplot %>% 
  ggsave(here("week_8", "output", "penplot.png"))

penplot<-image_read(here("week_8", "output", "penplot.png"))
out<-image_composite(penplot, penguin, offset = "+70+30")    ## make a composite plot 
out

# read in penguin gif
pengif<-image_read("https://media3.giphy.com/media/H4uE6w9G1uK4M/giphy.gif")
outgif<-image_composite(penplot, pengif, gravity = "center")  ## make a a composite of plot and gif, and puts gif in center
animation<-image_animate(outgif, fps = 10, optimize = TRUE)
animation
