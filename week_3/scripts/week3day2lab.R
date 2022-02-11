### Today we are going to plot penguin data ##########
### Created by: Alex Dang ##########
### Updated on: 2022-02-10 ################
#############################################################

## Plot 2 #################
plot2<-ggplot(data=penguins, 
              mapping = aes(x = species,
                            y = body_mass_g)) + 
  geom_boxplot(aes(fill = species)) +
  geom_dotplot(binaxis = "y",
               dotsize = 0.3,
               stackdir = "center") +
  facet_wrap(~sex) +
  labs(title = "Penguins Body Mass",
       x= "Species",
       y = "Body mass (g)",
       caption = "Source: Palmer Station LTER / palmerpenguins package") +
  scale_fill_manual(values = beyonce_palette(129)) +
  theme(plot.title = element_text(size = 16, 
                                  hjust = 0.5),
        axis.title = element_text(size = 12),
        panel.border = element_rect(fill = NA, color = "black"),
        legend.key = element_rect(fill = "lightgrey"),
        strip.background = element_rect(fill = "white", 
                                        color = "black")) 


### Plot output ################
ggsave(here("week_3", "output", "penguin-lab.png"),      ## saves the plot to output folder
       width = 7, height = 5)   ## in inches