# Exploring the death rate for every country in the world across six decades

# Loading packages
library(tidyverse)
library(lubridate)
library(janitor)
library(plotly)

infant_mortality <- read_csv("data/infant_mortality.csv")

subset_infant_mortality <- infant_mortality %>%
  pivot_longer(cols="1960":"2020", 
               names_to="year",               
               values_to="infant_mortality_rate") %>%
  mutate(year=lubridate::years(year)) %>% # set ymd format
  mutate(year=lubridate::year(year)) %>% # extract year
  janitor::clean_names() %>% # put names in snake case
  filter(country_name %in% 
           c("United States", 
             "Japan", 
             "Afghanistan", 
             "United Kingdom")) # extract four countries

# View(subset_infant_mortality)

# subset the date according to 
# (US,UK, Japan = lowest infant death rates, Afghanistan = highest infant death rates)





