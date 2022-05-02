##########################################################
## Practice with iterative coding ########################
## Created by: Alex Dang #################################
##########################################################


## Load libraries ########################################
library(tidyverse)
library(here)


## Load data #############################################
pool_testdata<-read_csv(here("Week_13", "data", "homework","TP1.csv"))
PoolPath<-here("Week_13", "data", "homework")   ## make file path


## Data analysis #########################################
  ## Loop ##
pool_files <- dir(path = PoolPath, pattern = ".csv")  ## select files with pattern .csv

pool_data <- data.frame(matrix(nrow = length(pool_files), ncol = 5))    ## make empty matrix

colnames(pool_data) <- c("filename", "mean_temp", "mean_light", "sd_temp", "sd_light")    ## make column names

pool_raw_data <- read_csv(paste0(PoolPath, "/", pool_files[1]))  ## test

for (i in 1:length(pool_files)) {  ## loop over files
  pool_raw_data <- read_csv(paste0(PoolPath, "/", pool_files[i]))                  ## read n files
  pool_data$filename[i] <- pool_files[i]                                           ## add file names 
  pool_data$mean_temp[i] <- mean(pool_raw_data$Temp.C, na.rm = TRUE)               ## calculate temp mean
  pool_data$mean_light[i] <- mean(pool_raw_data$Intensity.lux, na.rm = TRUE)       ## calculate mean light intensity
  pool_data$sd_temp[i] <- sd(pool_raw_data$Temp.C, na.rm = TRUE)                   ## calculate standard deviation for temp
  pool_data$sd_light[i] <- sd(pool_raw_data$Intensity.lux, na.rm = TRUE)           ## calculate standard deviation for light intensity
}
head(pool_data)    ## double check new dataframe


  ## map() from purrr
pool_files2 <- dir(path = PoolPath, pattern = ".csv", full.names = TRUE)

pool_data2 <- pool_files2 %>%                                     ## make dataframe
  set_names() %>%                                                 ## set id of each list to the file name
  map_df(read_csv, .id = "filename") %>%                          ## map everything to dataframe and add filename column
  group_by(filename) %>%                                          ## group by filename
  summarise(mean_temp = mean(Temp.C, na.rm = TRUE),               ## calculate temp mean
            mean_light = mean(Intensity.lux, na.rm = TRUE),       ## calculate mean light intensity
            sd_temp = sd(Temp.C, na.rm = TRUE),                   ## calculate standard deviation for temp
            sd_light = sd(Intensity.lux, na.rm = TRUE))           ## calculate standard deviation for light intensity
pool_data2
