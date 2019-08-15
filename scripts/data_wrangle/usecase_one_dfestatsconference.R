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
data_core <- read_csv(file = "./data/usecase_one_dfestatsconference.csv")

# 1. reformat data for analysis
colnames_old <- colnames(data_core)
colnames_new <- str_replace(string = colnames_old, pattern = "ParallelSessions_", replacement = "")
data <- data_core %>% 
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
  # generalise Preference column
  mutate(# part of string after "Choice"
    Preference = str_replace(string = Preference, pattern = "Choice.*", ""),
    Preference = case_when(
      Preference == "First"    ~ 5,
      Preference == "Second"   ~ 4,
      Preference == "Third"    ~ 3,
      Preference == "Fourth"   ~ 2,
      Preference == "Fifth"    ~ 1,
      TRUE                     ~ NA_real_
      ),
    # extract decimal part
    Session = as.double(str_extract(string = Session, pattern = "\\d+\\.*\\d*"))
  )

# 3. EXAMPLE: deal with Session 5s
data_example <- data %>% 
  filter(floor(Session) == 5) %>% 
  # have issues with repeated preferences and NAs which need to be resolved e.g ID = 27
  head(4) %>% 
  # widen on sessions so in ideal format for algo
  spread(key = Session, value = Preference)
room_sizes = data.frame(Room = c("S", "M", "G", "B"),
                        Size = c(95, 90, 56, 40))
func_iterative_preferences(x = data_example, limits = room_sizes, with_replacement = FALSE)
  