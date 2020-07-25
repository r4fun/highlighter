message("Initializing app...")
suppressPackageStartupMessages({
  library(shiny)
  library(marker)
  library(shinyjs)
  library(emo)
  library(tools)
  library(readr)
  library(readxl)
  library(magrittr)
})

# 30MB file upload max
options(shiny.maxRequestSize = 30*1024^2)

extract_text <- function(.data, idx, colname, tabname) {
  if (inherits(.data, "list")) {
    max_idx <- max(length(.data[[tabname]][[colname]]))
    text <- .data %>%
      .[[tabname]] %>%
      .[colname] %>%
      .[idx, 1] %>%
      .[[1]]
  } else if (inherits(.data, "data.frame")) {
    max_idx <- max(length(.data[[colname]]))
    text <- .data %>%
      .[colname] %>%
      .[idx, 1] %>%
      .[[1]]
  }

  list(
    text = text,
    max_idx = max_idx
  )
}
