# -------- #
# global.R #
# -------- #

# DESC: global.R script used to create static objects that app needs to run.
#       Includes loading and manipulating daya, and defining functions to be used in server.R

# Packages ------------------------------------------------------------

# shiny app development and appearance
library(shiny)
library(shinydashboard)
library(DT)

# load external functions
source("scripts/functions.R")

# Global Variables --------------------------------------------------------
message_warning <- "This app is currently under development and further features will be added."