table_tab <- function() {
  tabPanel(
    title = "View as Table",
    fluidRow(
      id = "table_settings",
      column(
        width = 6,
        checkboxGroupInput(
          "colnames",
          label = "Select Columns",
          choices = c(),
          selected = NULL
        )
      ),
      column(
        width = 6,
        radioButtons(
          "search_type",
          label = "Search Type",
          choices = c("By Column" = "col", "In Whole Table" = "whole"),
          selected = "col"
        )
      )
    ),
    div(
      id = "guide_table",
      reactableOutput("table")
    )
  )
}

card_tab <- function() {
  tabPanel(
    title = "View as Cards",
    hr(div(
      id = "guide_colname",
      selectInput(
        inputId = "colname",
        choices = names(imdb),
        selected = "Positive Reviews",
        label = NULL
      )
    )),
    hr(
      column(width = 6, textInput(
        inputId = "text1",
        label = "Keywords to highlight in red"
      )),
      column(width = 6, textInput(
        inputId = "text2",
        label = "Keywords to highlight in blue"
      ))
    ),
    fluidRow(
      column(
        width = 6,
        actionButton(
          width = "100%",
          inputId = "previous_text",
          label = NULL,
          icon = icon("arrow-left")
        )
      ),
      column(
        width = 6,
        actionButton(
          width = "100%",
          inputId = "next_text",
          label = NULL,
          icon = icon("arrow-right")
        )
      )
    ),
    div(
      id = "guide_text",
      wellPanel(div(
        id = "text-to-mark",
        textOutput("text")
      ))
    )
  )
}
