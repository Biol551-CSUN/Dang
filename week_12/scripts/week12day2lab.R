#######################################################
## Practicing with factors ############################
## created by: Alex Dang ##############################
#######################################################


## Load libraries #####################################
library(tidyverse)
library(here)
library(forcats)
library(sysfonts)
library(showtextdb)
library(showtext)


## Add fonts ##########################################
font_add_google("Yanone Kaffeesatz", "yanone")


## Load data ##########################################
intertidal <- read_csv(here("week_12", "data", "intertidaldata.csv"))
view(intertidal)
intertidal_lat <-read_csv(here("week_12", "data", "intertidaldata_latitude.csv"))
view(intertidal_lat)


## Data analysis ######################################
intertidal_clean <- intertidal %>% 
  filter(!is.na(Site)) %>% 
  group_by(Quadrat) %>% 
  summarise(Site, Algae, Quadrat) %>% 
  mutate(Quadrat = str_replace(Quadrat, pattern = "\\.", replacement = ""), 
         Quadrat = str_replace(Quadrat, pattern = "[0-9]", replacement = ""), 
         Quadrat = factor(Quadrat, levels = c('Low', 'Mid', 'High'))) %>% 
  filter(Algae>5, !is.na(Quadrat))
view(intertidal_clean)
intertidal_clean %>% 
  ggplot(aes(x = Quadrat, y = Algae, 
             fill = Site)) +
  geom_col() +
  labs(title = "Intertidal Algae Population", 
       x = "Tide Height", y = "Algae Count") +
  theme(plot.background = element_rect(fill = "beige"))
