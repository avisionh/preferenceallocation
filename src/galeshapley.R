# ------ #
# main.R #
# ------ #
# DESCRIPTION
# This script does the main piece of analysis.

# Load relevant packages
library(matchingR)
library(readr)
library(dplyr)
library(tibble)

# Load custom functions
source('src/functions.R')

# Set seed so we can replicate our results
set.seed(1)

# Load in student preferences dummy data
utility_delegates <- read_csv(file = "data/dummy_student_preferences.csv")
utility_delegates <- utility_delegates %>% 
  remove_rownames %>% 
  column_to_rownames(var = "X1")

# Set colleges to have no preferences
n_delegates <- ncol(utility_delegates)
m_sessions <- nrow(utility_delegates)

utility_sessions <- matrix(data = rep(x = 0, times = n_delegates*m_sessions),
                           nrow = n_delegates, 
                           ncol = m_sessions)
utility_sessions <- utility_sessions %>% 
  as_tibble() %>% 
  rename(`College 1` = V1,
         `College 2` = V2,
         `College 3` = V3,
         `College 4` = V4)
  

# Student-optimal matching

# Approach 1 - Gale-Shapley
results_galeshapley <- galeShapley.collegeAdmissions(
  studentUtils = utility_delegates,
  collegeUtils = utility_sessions,
  slots = c(2, 1, 1, 2)
)



