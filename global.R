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
  library(waiter)
  library(cicerone)
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

# guide <- Cicerone$
#   new()$
#   step(
#     el = "text1",
#     title = "Text Input",
#     description = "This is where you enter the text you want to print."
#   )

# app tour
guide <- Cicerone$
  new()$
  step(
    el = "guide_file",
    title = "File Upload",
    description = "First, you need to upload a file here. We currently accept a
    .csv, .xlsx. and .rds file. Once a file has been uploaded, you're almost done!"
  )$
  step(
    el = "guide_colname",
    title = "Column Name",
    description = "Once you've upload a file, a dropdown of column names will
    be populated. Pick one and the text on the right will render the first
    item of text from that column! If you upload an excel file, you'll also
    have the option to switch between excel sheets."
  )$
  step(
    el = "text1",
    title = "Highlight Text in Red",
    description = "Type some text in this box to highlight things in red."
  )$
  step(
    el = "text2",
    title = "Highlight Text in Blue",
    description = "Type some text in this box to highlight things in blue."
  )$
  step(
    el = "next_text",
    title = "Stepping Forward",
    description = "Click this button to step forward or advance through the list
    of text."
  )$
  step(
    el = "previous_text",
    title = "Stepping Backward",
    description = "Click this button to step backward through the list of text."
  )
