#######################################################
## Looking at new dataset ###########
## Created by: Alex Dang #############
## Updated on: 2022-02-17 ##############
########################################################


### Load libraries ############
library(tidyverse)
library(here)


## Read in data ##############
ChemData<- read_csv(here("week_4", "data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)


## Data analysis ##############
  ## Practice with separating and uniting 
ChemData_clean<- ChemData %>% 
  filter(complete.cases(.)) %>%   ## filters out everything that is not a complete row
  separate(col = Tide_time,       ## choose the tide time col
           into = c("Tide", "Time"),    ## separate it into two columns Tide and Time
           sep = "_",                   ## separate by _
           remove = FALSE) %>%          ## keep the original tide_time column (ex. good for reading well plate data
  unite(col = "Site_Zone",        ## the name of the new col
        c(Site,Zone),             ## the columns to unite
        sep = ".",                ## put a . in the middle
        remove = FALSE)           ## keep the original

head(ChemData_clean)

   ## Practice with pivoting to long/wide formats
ChemData_long<- ChemData_clean %>% 
  pivot_longer(cols = Temp_in:percent_sgd,    ## the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Variables",        ## the names of the new cols with all the column names
               values_to = "Values")          ## names of the new column with all the values

ChemData_long %>% 
  group_by(Variables, Site, Tide, Zone) %>%     ## group by everything we want
  summarise(Param_means = mean(Values, na.rm = TRUE),      ## calculate mean
            Param_var = var(Values, na.rm = TRUE),         ## calculate variance
            Param_sd = sd(Values, na.rm = TRUE))           ## calculate standard deviation

view(ChemData_long)

ChemData_wide<- ChemData_long %>% 
  pivot_wider(names_from = Variables,     ## column with the names for the new columns
              values_from = Values)       ## column with the values

   ## Plotting data
ChemData_long %>% 
  ggplot(aes(x = Site, y = Values)) +
  geom_boxplot() +
  facet_wrap(~Variables, scales = "free")      ## freeing up the axes 


   ## Practice by rewriting from the beginning
ChemData_clean<- ChemData %>% 
  filter(complete.cases(.)) %>% 
  separate(col = Tide_time,
           into = "Tide", "Time",
           sep = "_",
           remove = FALSE) %>% 
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Varibale",
               values_to = "Values") %>% 
  group_by(Variables, Site, Time) %>% 
  summarise(mean_vals = mean(Values, na.rm = TRUE)) %>% 
  pivot_wider(names_from = Variable,
              values_from = mean_vals) %>% 
  write_csv(here("week_4", "output", "summary.csv"))       ## saving and exporting an csv file

####### Notes ###############
## separate() is to separate columns
## unite() is to unite columns
## pivot_longer() makes the data into long format