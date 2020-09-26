library(rbcb)
library(dplyr)
library(shiny)
library(purrr)
library(highcharter)
library(shinyWidgets)
library(shinycssloaders)

source("functions/get_sgs_bacen.R")
source("functions/return_chosen_theme_hc.R")

table_sgs <-
  readr::read_rds('data/table_sgs.rds')

source("modules/home/ui.R")