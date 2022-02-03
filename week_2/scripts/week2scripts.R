### This is my first script. I am learning how to import data
### Created by: Alex Dang
### Created on: 2022-02-03
#############################################

### Load libraries ############
library(tidyverse)
library(here)

### Read in data #########
WeightData<-read_csv(here("week_2","data","weightdata.csv")) #weight data

### Data Analysis ########
head(WeightData) # Looks at the top 6 lines of the dataframe
tail(WeightData) # Looks at the bottom 6 lines of the dataframe
View(WeightData) # opens a new window to look at the entire dataframe
