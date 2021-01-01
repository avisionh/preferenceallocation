# ---------------------- #
# benchamrk_large_data.R #
# ---------------------- #
# DESCRIPTION
# This script tests func_iterative_preferences on a big dataset.
# The improved function should run under 1 sec for 2000 people;
# old function runs for ~55 sec for same dataset.

# Load relevant packages
library(matchingR)
library(readr)
library(dplyr)
library(tibble)

# Load custom functions
source('scripts/functions.R')

# Set seed so we can replicate our results
set.seed(1)

# Generate adjustable large dummy dataset, with:
n_delegates <- 2000 
m_sessions <- 4

# Create empty dataframe with specified dimensions
utility_delegates  <- data.frame(matrix(NA, ncol = n_delegates, nrow = m_sessions))

# Generate random preferences for each person (of values 10,20,30,40)
# where function assigns random preferences for each column
# then `sapply` applies this function across columns
utility_delegates <- sapply(X = 1:n_delegates, 
                            FUN = function(x) {
                              utility_delegates[x] <- sample.int(n = 4, size = 4) * 10
                            })
utility_delegates <- as.tibble(utility_delegates)

# Name columns for each person
colnames(utility_delegates) <- paste('Person', 1:n_delegates)

# Wrangle data in foramt suitable for function
utility_delegates <- utility_delegates %>% 
  # transpose the data so it is in a readable format
  t() %>% 
  # convert to dataframe so can name columns
  as_tibble(rownames = "Delegate") %>% 
  # rename the columns
  rename(Session_01 = V1,
         Session_02 = V2,
         Session_03 = V3,
         Session_04 = V4)

# Check structure and object type of `utility_delegates`
# str(utility_delegates)

# Generate room size limits for given number of delegates
room_sizes <- data.frame(Room = c("Room_01","Room_02","Room_03","Room_04"),
                         Size = c(0.2 * n_delegates, 0.3 * n_delegates ,0.1 * n_delegates, 0.4 * n_delegates))

# Run interative preferences timed
start_time <- Sys.time()
results_iterativepreference <- func_iterative_preferences(x = utility_delegates, 
                                                          limits = room_sizes, 
                                                          with_replacement = FALSE)
end_time <- Sys.time()
cat('Iterative Preferences function runtime:', round(as.numeric(end_time - start_time),2), 'secs')
