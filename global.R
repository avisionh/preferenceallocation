# -------- #
# global.R #
# -------- #

# DESC: global.R script used to create static objects that app needs to run.
#       Includes loading and manipulating daya, and defining functions to be used in server.R

# ----------------------------------------------------------------------- #
# Packages ----------------------------------------------------------------
# ----------------------------------------------------------------------- #

# shiny app development and appearance
library(shiny)
library(shinydashboard)
library(DT)

# load external functions
source("scripts/functions.R")


# ----------------------------------------------------------------------- #
# Global Variables --------------------------------------------------------
# ----------------------------------------------------------------------- #
message_warning <- "This app is currently under development and further features will be added."

# set seed so we can replicate our results
set.seed(1)


# ----------------------------------------------------------------------- #
# Data: Create ------------------------------------------------------------
# ----------------------------------------------------------------------- #

# 1. generate adjustable large dummy dataset, with:
n_delegates <- 2000 
m_sessions <- 4

# 2. create empty dataframe with specified dimensions
utility_delegates  <- data.frame(matrix(NA, ncol = n_delegates, nrow = m_sessions))

# 3. generate random preferences for each person (of values 10,20,30,40)
# where function assigns random preferences for each column
# then `sapply` applies this function across columns
utility_delegates <- sapply(X = 1:n_delegates, 
                            FUN = function(x) {
                              utility_delegates[x] <- sample.int(n = 4, size = 4) * 10
                            })
utility_delegates <- data.frame(utility_delegates)

# 4. name columns for each person
colnames(utility_delegates) <- paste('Person', 1:n_delegates)

# 5. generate room size limits for given number of delegates
room_sizes <- c(0.2 * n_delegates, 0.3 * n_delegates ,0.1 * n_delegates, 0.4 * n_delegates)