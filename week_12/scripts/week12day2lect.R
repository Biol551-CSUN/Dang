##########################################################
## Working with factors ##################################
## Created by: Alex Dang #################################
##########################################################


## Load libraries ########################################
library(tidyverse)
library(here)
library(forcats)


## Load data #############################################
lifetime_earn <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/lifetime_earn.csv')
student_debt <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/student_debt.csv')
retirement <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/retirement.csv')
home_owner <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/home_owner.csv')
race_wealth <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/race_wealth.csv')
income_time <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_time.csv')
income_limits <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_limits.csv')
income_aggregate <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_aggregate.csv')
income_distribution <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_distribution.csv')
income_mean <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-02-09/income_mean.csv')


## Data analysis #########################################
fruits <- factor(c("Apple", "Grape", "Banana"))
fruits

test <- c("A", "1", "2")
as.numeric(test)

test1 <- factor(test)
as.numeric(test1)

  ## read.csv: data strings read in as factors; read_csv: data strings read in as characters

glimpse(starwars)
star_counts <- starwars %>% 
  filter(!is.na(species)) %>% 
  mutate(species = fct_lump(species, n = 3)) %>%     ## converts data into a factor and lump it together
  count(species)
star_counts %>% 
  ggplot(aes(x = fct_reorder(species, n, .desc = TRUE), y = n)) +     ## reorder the factor of species by n
  geom_col() +
  labs(x = "Species")

glimpse(income_mean)
total_income <- income_mean %>% 
  group_by(year, income_quintile) %>% 
  summarise(income_dollars_sum = sum(income_dollars)) %>% 
  mutate(income_quintile = factor(income_quintile))     ## make it a factor
total_income %>% 
  ggplot(aes(x = year, y = income_dollars_sum, 
             color = fct_reorder2(income_quintile, year, income_dollars_sum))) +
  geom_line() +
  labs(color = "Income Quantile")

x1 <- factor(c("Jan", "Mar", "Apr", "Dec"), levels = c("Jan", "Mar", "Apr", "Dec"))     ## set specific order
x1

starwars_clean <- starwars %>% 
  filter(!is.na(species)) %>% 
  count(species, sort = TRUE) %>% 
  mutate(species = factor(species)) %>%     ## make species a factor
  filter(n>3) %>%                           ## only keep species that have more than 3
  droplevels()  %>%                         ## drop extra levels
  mutate(species = fct_recode(species, "Humanoid" = "Human"))
starwars_clean
levels(starwars_clean$species)
