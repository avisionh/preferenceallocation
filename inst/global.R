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
library(htmltools)
library(DT)

# data wrangling
library(readr)
library(dplyr)
library(tibble)
library(tidyr)

# data plotting
library(stringr)
library(ggplot2)

# load external functions
source("../src/functions.R")


# ----------------------------------------------------------------------- #
# Global Variables --------------------------------------------------------
# ----------------------------------------------------------------------- #
message_warning <- "This app is currently under development and further features will be added."

# set seed so we can replicate our results
set.seed(1)

# colour blind palette
cb_palette <- c("cb_black" = "#000000",
                "cb_grey" = "#999999",
                "cb_orange" = "#E69F00",
                "cb_light_blue" = "#56B4E9",
                "cb_green" = "#009E73",
                "cb_yellow" = "#F0E442",
                "cb_dark_blue" = "#0072B2",
                "cb_red" = "#D55E00",
                "cb_pink" = "#CC79A7")


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


# ----------------------------------------------------------------------- #
# Data: Wrangle -----------------------------------------------------------
# ----------------------------------------------------------------------- #

# wrangle utility_delegates into suitable format for presentation
data_utility_delegates <- utility_delegates %>% 
  # transpose the data so it is in a readable format
  t() %>% 
  # convert to dataframe so can name columns
  as_tibble(rownames = "Delegate") %>% 
  # rename the columns
  rename(Session_01 = V1,
         Session_02 = V2,
         Session_03 = V3,
         Session_04 = V4)


# ----------------------------------------------------------------------- #
# Table: Formats ----------------------------------------------------------
# ----------------------------------------------------------------------- #

# create for HTML preference table being generated in 'Report - Example'
# and 'Report - Allocations' tabs
table_preference_skeleton <- withTags(
  table(class = "display",
        thead(
          # have merged cell headers
          tr(th(colspan = 1, "Attendees", style = "text-align: center;"),
             th(colspan = 4, "Parallel Sessions", style = "text-align: center;")),
          # show column headers
          tr(lapply(names(data_utility_delegates), th))
        ) #thead
  ) #table
) #withTags



# store delegates in a vector for user-selection
vec_delegates <- data_utility_delegates$Delegate
