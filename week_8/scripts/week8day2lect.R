#################################################################
## Practice with writing functions ##############################
## Created by: Alex Dang ########################################
## Updated on: 2022-03-17 #######################################
#################################################################


## Load libraries ###############################################
library(tidyverse)
library(palmerpenguins)
library(PNWColors)    ## for the PNW color palette


## Write functions ##############################################
## example 2:
temp_C<-(temp_F - 32) * 5 / 9  ## the goal
## writing the function
F_to_C<-function(temp_F){
  temp_C<-(temp_F - 32) * 5 / 9
  return(temp_C)
}
## temp_F in function() is what the argument is
## test function
F_to_C(32)
F_to_C(212)


## example 3:
temp_K<-(temp_C + 273.15)     ## the goal
## writing the function
C_to_K<-function(temp_C){
  temp_K<-(temp_C + 273.15)
  return(temp_K)
}
## test function
C_to_K(20)


## eaxmple 4:
## tentative goal
pal<-pnw_palette("Lake",3, type = "discrete")    ## calling the color palette
ggplot(penguins, aes(x = body_mass_g, y = bill_length_mm, color = island)) +
  geom_point() +
  geom_smooth(method = "lm") +    ## add linear model
  scale_color_manual("Island", values=pal) +    ## use pretty colors and change the legend title
  theme_bw()
## writing the function
myplot<-function(data = penguins, x, y){
  pal<-pnw_palette("Lake",3, type = "discrete")    
  ggplot(data, aes(x = {{x}}, y = {{y}}, color = island)) +
    geom_point() +
    geom_smooth(method = "lm") +    
    scale_color_manual("Island", values=pal) +    
    theme_bw()
}
## add defaults by editing the function argument
## test function
myplot(x = body_mass_g, y = bill_length_mm) +
  labs(x = "Body Mass(g)", y = "Flipper Length (mm)")
## need to add curly-curlies {{}}


## example 5:
## writing the function
a<-4
b<-5
if(a > b){
  f <- 20
} else {
  f <- 10
}
## test function
f


## example 6:
myplot<-function(data = penguins, x, y, lines=TRUE){
  pal<-pnw_palette("Lake",3, type = "discrete")
  
  if(lines==TRUE){
    ggplot(data, aes(x = {{x}}, y = {{y}}, color = island)) +
      geom_point() +
      geom_smooth(method = "lm") +    
      scale_color_manual("Island", values=pal) +    
      theme_bw()
  }
  else{    
    ggplot(data, aes(x = {{x}}, y = {{y}}, color = island)) +
      geom_point() +
      geom_smooth(method = "lm") +    
      scale_color_manual("Island", values=pal) +    
      theme_bw()
  }
}
## test function
myplot(x = body_mass_g, y = bill_length_mm, lines = FALSE)
## add lines = FALSE to remove the lines

