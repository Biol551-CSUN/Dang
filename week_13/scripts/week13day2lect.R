##########################################################
## Practice with models ##################################
## Created by: Alex Dang #################################
##########################################################


## Load libraries ########################################
library(tidyverse)
library(here)
library(palmerpenguins)
library(broom)
library(performance)
library(modelsummary)
library(tidymodels)
library(wesanderson)


## Data analysis #########################################
Peng_mod <- lm(bill_length_mm ~ bill_depth_mm*species, data = penguins)

check_model(Peng_mod)   ## check assumptions of an lm model

anova(Peng_mod)    ## ANOVA Table

summary(Peng_mod)   ## coeffs with error

  ## {broom} ##
coeffs <- tidy(Peng_mod)    # Tidy coefficients; view with broom
coeffs

results <- glance(Peng_mod)   ## tidy r2
results

resid_fitted <- augment(Peng_mod)    ## tidy residuals
resid_fitted

  ## {modelsummary} ##
Peng_mod_noX <- lm(bill_length_mm ~ bill_depth_mm, data = penguins)

models <- list("Model with interaction" = Peng_mod,           ## make a list of models and name them
               "Model with no interaction" = Peng_mod_noX)
modelsummary(models, output = here("week_13", "output", "table.docx"))    ## save table as docx

modelplot(models) +      ## canned coefficient modelplots
  labs(x = "Coefficients", 
       y = "Term names") +
  scale_color_manual(values = wes_palette('Darjeeling1'))

models2 <- penguins %>% 
  ungroup() %>%                ## the penguin data are grouped so we need to ungroup
  nest(data = -species) %>%    ## nest all the data by species
  mutate(fit = map(data, ~lm(bill_length_mm~body_mass_g, data = .)))
models2
models2$fit

results2 <- models2 %>% 
  mutate(coeffs2 = map(fit, tidy),               ## look at coefficients
         modelresults = map(fit, glance)) %>%    ## R2 and other
  select(species, coeffs2, modelresults) %>%     ## only keep the results
  unnest()    ## put it back in a dataframe and specify which columns to unnest
results2

  ## {tidymodels} ##
lm_mod <- linear_reg() %>% 
  set_engine("lm") %>% 
  fit(bill_length_mm ~ bill_depth_mm*species, data = penguins) %>% 
  tidy() %>%
  ggplot() +
  geom_point(aes(x = term, y = estimate)) +
  geom_errorbar(aes(x = term, ymin = estimate-std.error,
                    ymax = estimate+std.error), width = 0.1 ) +
  coord_flip()
lm_mod

