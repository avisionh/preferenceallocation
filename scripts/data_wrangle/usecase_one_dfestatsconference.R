# -------------------------------- #
# usecase_one_dfestatsconference.R #
# -------------------------------- #
# DESCRIPTION
# This script wrangles an anonymised dataset of delegates' preferences for 
# the DfE Statistician's Conference for 2019.
# The survey/form used to collect the responses is from:
# https://www.cognitoforms.com/

library(readr)
library(dplyr)
library(stringr)
library(tidyr)

# global variables

# import data
data <- read_csv(file = "./data/usecase_one_dfestatsconference.csv")

# 1. reformat data for analysis
colnames_old <- colnames(data)
colnames_new <- str_replace(string = colnames_old, pattern = "ParallelSessions_", replacement = "")
data <- data %>% 
  # rename columns
  rename_at(.vars = vars(colnames_old), .funs = function(x) colnames_new) %>% 
  # select relevant columns
  select(ID, FirstChoice:FifthChoice5) %>% 
  # convert to long format
  gather(key = Preference, value = Session, -ID) %>% 
  # order by/arrange by ID so easy to view
  arrange(ID) %>% 
  # reorder columns so easy to view
  select(ID, Session, Preference)

rm(colnames_old, colnames_new)

# 2. convert preference string to utility integers
data <- data %>%
  # generalise Preference column by removing part of string after "Choice"
  mutate(Preference = str_replace(string = Preference, pattern = "Choice.*", ""),
         Preference = case_when(
           Preference == "First"    ~ 5,
           Preference == "Second"   ~ 4,
           Preference == "Third"    ~ 3,
           Preference == "Fourth"   ~ 2,
           Preference == "Fifth"    ~ 1,
           TRUE                     ~ NA_real_
         )
  )
         ))


  