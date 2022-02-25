########################################################
## Practicing data wrangling with lubridate package ####
## Created by: Alex Dang ###############################
## Updated on: 2022-02-24 ##############################
########################################################


## Load libraries ######################################
library(tidyverse)
library(lubridate)
library(here)
library(sysfonts)
library(showtextdb)
library(showtext)

  ## Adding fonts
font_add_google("Yanone Kaffeesatz", "yanone")

## Data Analysis #######################################

  ## Data wrangling
DepthData<-read_csv(here("week_5", "data", "DepthData.csv")) %>%     ## read in depth data
  mutate(datetime = ymd_hms(date))                                   ## convert date and time format to ISO

CondData<-read_csv(here("week_5", "data", "CondData.csv")) %>%       ## read in conductivity data
  mutate(datetime = mdy_hms(depth),                                  ## convert date and time format to ISO
         datetime = round_date(datetime, "10 sec"))                  ## round time to 10 seconds

FullData<-inner_join(DepthData, CondData) %>%                        ## join depth and cond datasets, and remove NAs
  mutate(hour = hour(datetime),                                      ## extract hour
         minute = minute(datetime)) %>%                              ## extract minute
  select(datetime, AbsPressure, hour, minute, Depth, TempInSitu, SalinityInSitu_1pCal) %>%
  group_by(AbsPressure, datetime, minute, hour) %>%                 
  summarise(AvDepth = mean(Depth),                                   ## calculate average depth
            AvTemp = mean(TempInSitu),                               ## calculate average temp
            AvSalinity = mean(SalinityInSitu_1pCal)) %>%             ## calculate average salinity
  write_csv(here("week_5", "output", "AverageDepthOverTime.csv"))    ## save csv file

view(DepthData)
view(CondData)
view(FullData)

  ## Data plotting
showtext_auto()  ## automatically use showtext to render text

FullData %>%
  ggplot(mapping = aes(x = minute,                                          ## set up data plot
                       y = AvDepth)) +                                        
  geom_jitter(size = 0.5) +                                                           ## select type of plot
  labs(title = "Average Depth Over Time",                                   ## add plot title
       x = "Time (mins)",                                                   ## add x axis title
       y = "Average Depth",                                                 ## add y axis title
       caption = "Source: Conductivity and Depth Data by N. Silbiger") +    ## add caption
  theme(plot.title = element_text(size = 26,                                ## change title size
                                  hjust = 0.5,                              ## change title centering
                                  family = "yanone"),                       ## change title fonts
        axis.title = element_text(size = 14,                                ## change axis size
                                  family = "yanone"),                       ## change axis fonts
        panel.border = element_rect(fill = NA, color = "blue"),             ## make the plot border blue
        strip.background = element_rect(fill = "white",                     
                                        color = "blue"),
        panel.background = element_rect(fill = "lightblue"))                ## make plot babckground light blue


## Plot output ######################
ggsave(here("week_5", "output", "AverageDepthOverTime.png"),      ## saves the plot to output folder
       width = 3, height = 3)   ## in inches