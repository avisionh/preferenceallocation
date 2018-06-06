# ------ #
# main.R #
# ------ #
# DESCRIPTION
# This script does the main piece of analysis.

# Load relevant packages
library(matchingR)
library(readr)
library(dyplr)
library(tibble)

# Set seed so we can replicate our results
set.seed(1)


# Load in student preferences dummy data
utility_students <- read_csv(file = "dummy_student_preferences.csv")
utility_students <- utility_students %>% 
  remove_rownames %>% 
  column_to_rownames(var = "X1")

# Set colleges to have no preferences
n_students <- ncol(utility_students)
n_colleges <- nrow(utility_students)

utility_colleges <- matrix(data = rep(x = 0, times = n_students*n_colleges), 
                          nrow = n_students, 
                          ncol = n_colleges)
utility_colleges <- utility_colleges %>% 
  as.tibble() %>% 
  rename(`College 1` = V1,
         `College 2` = V2,
         `College 3` = V3,
         `College 4` = V4)
  

# student-optimal matching
results <- galeShapley.collegeAdmissions(studentUtils = utility_students, 
                                         collegeUtils = utility_colleges, 
                                         slots = c(2, 1, 1, 2))

