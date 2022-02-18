#######################################################
## Practice with separating and pivoting data #########
##  Created by: Alex Dang ################
## Updated on: 2022-02-17 ################
#######################################################


### Load libraries ####################################
library(tidyverse)
library(here)
library(beyonce)
library(sysfonts)
library(showtextdb)
library(showtext)

   ## Adding fonts
font_add_google("Arizonia", "ari")
font_add_google("Yanone Kaffeesatz", "yanone")

## Read in data #######################################
ChemData<- read_csv(here("week_4", "data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)


## Data analysis ##############
   ## Wrangling data
ChemData_clean<- ChemData %>% 
  filter(complete.cases(.),                               ## removing all the N/As
         Site == "BP") %>%                                ## filtering out the subset in Site to just BP
  separate(col = Tide_time,                               ## separating the Tide_time column into appropriate columns
           into = c("Tide","Time"),                       ## separate it into two columns Tide and Time
           sep = "_") %>%                                 ## separate by _
  pivot_longer(cols = Salinity:TA,                        ## pivoting the columns from Salinity to TA
               names_to = "Variables",                    ## naming the new column with all the columns
               values_to = "Values") %>%                  ## naming the new column with all the values
  group_by(Variables, Site, Season, Time, Zone) %>%       
  summarise(Param_sd = sd(Values, na.rm = TRUE))  %>%     ## calculating standard deviation
  write_csv(here("week_4", "output", "Hawaii_Biochemistry.csv"))


view(ChemData_clean)

    ## Plotting data
showtext_auto()  ## automatically use showtext to render text

ChemData_clean %>% 
  ggplot(aes(x = Zone, y = Param_sd)) +                                ## setting up the plot data
  geom_violin(aes(fill = Zone)) +                                      ## selecting type of plot
  scale_fill_manual(values = beyonce_palette(129)) +                   ## adding colors to plot from beyonce palette
  labs(title = "Hawaii Biochemistry",                                  ## adding plot title
       x = "Zones", y = "Standard Deviation",                          ## adding x axis and y axis titles
       fill = "Zones",                                                 ## naming the legend key title 
       caption = "Source: Maunalua Chemical Data by N. Silbiger") +    ## adding caption for source
  theme(plot.title = element_text(family = "ari",                      ## changing the fonts of plot title
                                  size = 26,                           ## changing the size of plot title
                                  hjust = 0.5),                        ## adjusting the centering of the plot title
        axis.title = element_text(family = "yanone",                   ## changing the fonts of axis titles
                                  size = 12),                          ## changing the fonts of axis titles
        panel.border = element_rect(fill = NA, color = "black"),       ## making the overall border of plot black
        legend.text = element_text(family = "neucha"),                 ## changing the fonts for legend text
        legend.title = element_text(family = "amatic",                 ## changing the fonts for legend title
                                    size = 16),                        ## changing the size of legend title
        strip.background = element_rect(fill = "white",
                                        color = "black"))


## Plot output ######################
ggsave(here("week_4", "output", "Hawaii_Biochemistry.png"),      ## saves the plot to output folder
       width = 3, height = 3)   ## in inches
