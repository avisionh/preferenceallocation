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

# 1. rename columns
colnames_old <- colnames(data)
colnames_new <- str_replace(string = colnames_old, pattern = "ParallelSessions_", replacement = "")
data <- data %>% 
  # rename columns
  rename_at(.vars = vars(colnames_old), .funs = function(x) colnames_new) %>% 
  # select relevant columns
  select(ID, FirstChoice:FifthChoice5) %>% 
  # convert to long format
  gather(key = "ID", value = )