# Exploring the death rate for every country in the world across six decades

# Loading packages
library(tidyverse)
library(lubridate)
library(janitor)
library(plotly)

infant_mortality <- read_csv("data/infant_mortality.csv")

# puts the data in tidy format, cleans names, makes sure that year is treated 
# as date data and filters four countries of interest
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


# ggplot plotting the infant mortality rate by country
mortality_figure <- ggplot(data = subset_infant_mortality,
                           aes(x = year,
                               y = infant_mortality_rate,
                               color = country_name)) +
  geom_line() +
  scale_color_manual(values = c("black", "blue", "magenta", "orange")) +
  annotate(geom = "text",
           x = 2023,
           y = 50,
           label = "Afghanistan",
           size = 4,
           colour="black") +
  annotate(geom = "text",
           x = 2023,
           y = -2,
           label = "Japan",
           size = 4,
           colour="blue") +
  annotate(geom = "text",
           x = 2023,
           y = 15,
           label = "United Kingdom",
           size = 4,
           colour="orange") +
  annotate(geom = "text",
           x = 2023,
           y = 5,
           label = "United States",
           size = 4,
           colour="magenta") +
  geom_vline(xintercept = 2000,
             lty = 2) +
  theme_minimal()+
  theme(legend.position="none")+
  xlim(1970, 2025)+
  labs(x="Year",
       y="Deaths per 100,000")+
  ggtitle("Mortality rate, infant (per 1,000 live births) \nhas been steadily falling in Afghanistan from 1970 to present")


ggsave("figures/infant mortality graph.png", plot = mortality_figure, dpi=900, width = 7, height = 7)
