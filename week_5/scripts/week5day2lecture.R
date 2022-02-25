########################################################
## Practicing data wrangling with lubridate package ####
## Created by: Alex Dang ###############################
## Updated on: 2022-02-24 ##############################
########################################################


## Load libraries ######################################
library(tidyverse)
library(lubridate)
library(here)
library(usethis)
library(devtools)

install_github("Gibbsdavidl/CatterPlots")   ## install package of the day

## Practice with functions #############################
datetimes<-c("02/24/2021 22:22:20",               ## make a character string
             "02/25/2021 11:21:10",
             "02/26/2021 8:01:52")
datetimes<-mdym_hms(datetimes)                    ## convert to datetimes
month(datetimes, label = TRUE, abbr = FALSE)      ## spell it out
day(datetimes)                                    ## extract day
wday(datetimes, label = TRUE)                     ## extract day of week
hour(datetimes)                                   ## extract hour
minute(datetimes)                                 ## extract minute
second(datetimes)                                 ## extract second
datetimes + hours(4)                              ## hours add hours; hour extract hour --> -s means adding/subtract/divide
datetimes + times(2)
round_date(datetimes, "minute")                   ## round to nearest minute
round_date(datetimes, "5 mins")                   ## round to the nearest 5 minutes


## Data analysis #############################################
CondData<-read_csv(here("week_5", "data", "CondData.csv")) %>%         ## read in dataframe
  mutate(datetime = mdy_hms(depth)) %>%
  filter(complete.cases(.))

view(CondData)

