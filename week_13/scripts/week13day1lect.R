##########################################################
## Practice with iterative coding ########################
## Created by: Alex Dang #################################
##########################################################


## Load libraries ########################################
library(tidyverse)
library(here)


## Load data #############################################
testdata<-read_csv(here("Week_13", "data", "cond_data","011521_CT316_1pcal.csv"))
CondPath<-here("Week_13", "data", "cond_data")     ## point to the location on computer of the folder



## Data analysis #########################################
print(paste("The year is", 2000))

years <- c(2015:2021)     ## put it in a loop

## pre-allocate space for the loop
year_data <- data.frame(matrix(ncol = 2, nrow = length(years)))   ## empty matrix
colnames(year_data) <- c("year", "year_name")    ## add column names
for (i in 1:length(years)) {        ## set up the for loop where i is the index
  year_data$year_name[i] <- paste("The year is", years[i])     ## loop over i
  year_data$year[i] <- years[i]
}
year_data


files <- dir(path = CondPath, pattern = ".csv", full.names = TRUE)  ## list all the files in path with a specific pattern; use regex to be more specific for certain patterns
files
cond_data <- data.frame(matrix(nrow = length(files), ncol = 3))   ## pre-allocate space; make empty dataframe that has one row for each file and 3 columns
colnames(cond_data) <- c("filename", "mean_temp", "mean_sal")     ## give dataframe column names
cond_data
raw_data <- read_csv(paste0(CondPath, "/", files[1]))    ## test by reading in first file
head(raw_data)
for (i in 1:length(files)) {     ## loop over 1:3 the numbers of files
  raw_data <- read_csv(paste0(CondPath, "/", files[1]))
  # glimpse(raw_data)
  cond_data$filename[i] <- files[i]
  cond_data$mean_temp[i] <- mean(raw_data$Temperature, na.rm = TRUE)
  cond_data$mean_sal[i] <- mean(raw_data$Salinity, na.rm = TRUE)
}


  ## purrr
1:10 %>%    ## a vector form 1 to 10 (we are going to do this 10 times) %>%  ## the vector to iterate over
  map(rnorm, n = 15) %>%     ## calculate 15 random numbers based on a normal distribution in a list
  map_dbl(mean)    ## calculate the mean. It is now a vector with type "double"
1:10 %>%    ## list 1:10
  map(function(x) rnorm(15, x)) %>%     ## make function
  map_dbl(mean)
1:10 %>%
  map(~ rnorm(15, .x)) %>%  ## changes arguments inside the function
  map_dbl(mean)

data <- files %>% 
  set_names() %>%    ## set's the id of each list to the file name
  map_df(read_csv, .id = "filename") %>%    ## map everything to a dataframe and put the id in a column called filename
  group_by(filename) %>% 
  summarise(mean_temp = mean(Temperature, na.rm = TRUE), 
            mean_sal = mean(Salinity, na.rm = TRUE))
data


## Package of the day: gganatogram
Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS="true")
remotes::install_github("jespermaag/gganatogram")
library(gganatogram)
gganatogram(data = hgFemale_key, 
            organism = "human", sex = "female", 
            fill = "colour", fillOutline = "#a6bddb") +
  theme_void() +
  coord_fixed()

hgMale_key %>% 
  filter(type %in% "nervous_system") %>% 
  gganatogram(organism = "human", sex = "male", 
              fill = "colour", outline = FALSE) +
  theme_void() +
  coord_fixed()

gganatogram(data = mmFemale_key,
            organism = "mouse", sex = "female", 
            fillOutline = "#a6bddb", fill = "colour") +
  theme_void() +
  coord_fixed()

gganatogram(data = cell_key$cell, 
            organism = "cell", 
            fillOutline = "#a6bddb", fill = "colour") +
  theme_void() +
  coord_fixed()
