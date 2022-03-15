###############################################################
## Practicing plotting good/bad maps ##########################
## Created by: Alex Dang ######################################
## Updated on: 2022-03-09 #####################################
###############################################################

## Load libraries #############################################
library(ggmap)
library(tidyverse)
library(here)
library(ggsn)

register_google(key = "YOUR KEY HERE", write = TRUE) ## use own API
## NOTE: do NOT put your key to github
## set write = TRUE will write API key to R environment so that you don't have to register it every time 


## Load dataframe ##############################################
ChemData<-read_csv(here("week_7", "data", "chemicaldata_maunalua.csv"))
glimpse(ChemData)


## Data analysis ###############################################
Oahu<get_map("Oahu")  ## get base layer
ggmap(Oahu)

WP<-data.frame(lon = -157.7621, lat = 21.27427) ## coordinate to Wailupe

Map1<-get_map(WP)  ## get base layer

ggmap(Map1)   ## plot it

Map1<-get_map(WP, zoom = 17)  ## zoom in on a location
ggmap(Map1)

Map1<-get_map(WP, zoom = 17, maptype = "satellite")
ggmap(Map1) +
  geom_point(data = ChemData,                             ## plot data
             aes(x = Long, y = Lat, color = Salinity),    ## set up data
             size = 4) +
  scale_color_viridis_c() +                               
  scalebar(x.min = -157.766, x.max = -157.766,            ## add scalebar
           y.min = 21.2715, y.max = 21.2785, 
           dist = 250, dist_unit = "m", model = "WGS84",
           transform = TRUE, st.color = "white",
           box.fill = c("yellow", "white"))

geocode("the white house")
geocode("California State University, Northridge")


## Package of the day ########################################
library(emojifont)

search_emoji('smile')

ggplot() +
  geom_emoji('smile_cat',
             x = 1:5, y = 1:5, size = 10)
