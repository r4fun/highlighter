suppressPackageStartupMessages({
  library(shiny)
  library(marker)
  library(shinyjs)
  library(emo)
  library(tools)
  library(readr)
  library(readxl)
  library(magrittr)
  library(waiter)
  library(cicerone)
})

# 30MB file upload max
options(shiny.maxRequestSize = 30 * 1024 ^ 2)

# source helper functions
invisible(lapply(list.files("R", full.names = TRUE), source))

# app guide
guide <- app_guide()
