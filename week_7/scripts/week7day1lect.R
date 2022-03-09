###############################################################
## Practicing plotting maps ###################################
## Created by: Alex Dang ######################################
## Updated on: 2022-03-09 #####################################
###############################################################


## Load libraries #############################################
library(tidyverse)
library(here)
library(maps)
library(mapdata)
library(mapproj)


## Load dataframes ############################################
popdata<-read_csv(here("week_7", "data", "CApopdata.csv"))
stars<-read_csv(here("week_7", "data", "stars.csv"))

world<-map_data("world")        ## get data for the entire world
head(world)

usa<-map_data("usa")            ## get data for the USA
head(usa)

italy<-map_data("italy")        ## get data for italy
head(italy)

states<-map_data("state")       ## get data for states
head(states)

counties<-map_data("county")    ## get data for counties
head(counties)


## Data analysis #############################################
   ## map of the world
ggplot() +
  geom_polygon(data = world, aes(x = long, y = lat, 
                                 group = group, fill = region),  ## do NOT forget group=group
               color = "black") + 
  guides(fill = FALSE)  +     ## add color to lines and fill, need this to work
  theme(panel.background = element_rect(fill = "lightblue"))  +  ## make the ocean blue
  coord_map(projection = "sinusoidal",      
            xlim = c(-180,180))

## NOTES:
## use mercator projection to visualize map in 2D
## use sinusoidal projection to mimic the globe visual


    ## map of California
CA_data<-states %>% 
  filter(region == "california")

ggplot() +
  geom_polygon(data = CA_data, aes(x = long, y = lat,
                                      group = group),
               color = "black") +
  coord_map() +
  theme_void()

    ## adding layers to CA map: data wrangling
head(counties)[1:3,] ## only showing the first 3 rows for space
head(popdata)        ## look at the county data

CApop_county<-popdata %>% 
  select("subregion" = County, Population) %>%      ## rename the county column
  inner_join(counties) %>%                          ## joining by subregion 
  filter(region == "california")                    ## some counties have same names in other states

head(CApop_county)

ggplot() +
  geom_polygon(data = CApop_county, 
               aes(x = long, y = lat, group = group, fill = Population),
               color = "black") +
  geom_point(data = stars,                         ## add stars data set; add a point at all my sites
             aes(x = long, y = lat, 
                 size = star_no)) +                ## make points proportional to numbers of stars
  coord_map() +
  theme_void() +
  scale_fill_gradient(trans = "log10") +
  labs(size = "# of stars/m2")                     ## rename legend label
ggsave(here("week_7", "output", "CApop.pdf"))
