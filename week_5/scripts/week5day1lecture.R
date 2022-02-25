######################################################################
## Practicing with joining data ######################################
## Created by: Alex Dang #############################################
## Updated on: 2022-02-25 ############################################
######################################################################


## Load libraries ####################################################
library(tidyverse)
library(here)
library(cowsay)

## Load data #########################################################
EnviroData<-read_csv(here("week_5","data", "site.characteristics.data.csv"))   # Environmental data from each site

TPCData<-read_csv(here("week_5","data","Topt_data.csv"))  #Thermal performance data

glimpse(EnviroData)
glimpse(TPCData)

## Data analysis #####################################################
   ## Data wrangling
EnviroData_wide<-EnviroData %>% 
  pivot_wider(names_from = parameter.measured,          ## pivot the data longer
              values_from = values) %>%                     
  arrange(site.letter)                                  ## arrange the dataframe by site

view(EnviroData_wide)

    ## Joining Practice
FullData_left<-left_join(TPCData, EnviroData_wide) %>%  ## joining (left) by site letter
  relocate(where(is.numeric), .after = where(is.character)) ## relocate all the numeric data after the character data

head(FullData_left)

    ## Using tibble
T1<-tibble(Site.ID = c("A", "B", "C", "D"),             ## make 1 tibble
           Temperature = c(14.1, 16.7, 15.3, 12.8 ))

T1


T2<-tibble(Site.ID = c("A", "B", "D", "E"),
           pH = c(7.3, 7.8, 8.1, 7.9))

T2

left_join(T1, T2)
right_join(T1, T2)
inner_join(T1, T2)  ## keeps the data that is complete in both data sets; take out NAs
full_join(T1, T2)   ## keeps everything
semi_join(T1, T2)   ## keeps all rows from first data set that has matching values in the second data set; keep just columns from first data set
anti_join(T1, T2)   ## keeps all rows in first data set that do not match in second data set; helps find missing data


## Package of the day ###################################################
   ## Cowsay
say("hello", by = "shark")         ## I want a shark to say hello
say("I want pets", by = "cat")     ## I want a cat to say I want pets

