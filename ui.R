ui <- fluidPage(
  use_marker(),
  useShinyjs(),
  use_waiter(),
  use_cicerone(),
  includeCSS("www/custom.css"),
  titlePanel(div(class = "app-title", paste("Highlighter", ji("pencil")))),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      "Please upload a file, then select a column name and hit the go button to
      render text. If you are uploading a .xlsx file, you have the option to
      define the tab you're interested in.",
      br(),
      br(),
      div(
        id = "guide_file",
        fileInput(
          inputId = "file",
          label = NULL,
          accept = c(
            ".csv",
            ".xlsx",
            ".rds"
          )
        )
      ),
      hr(
        hidden(
          div(
            id = "hidden_tabname",
            selectizeInput(
              inputId = "tabname",
              choices = NULL,
              label = NULL,
              options = list(
                placeholder = "Select a tab (if .xlsx)..."
              )
            )
          )
        ),
        div(
          id = "guide_colname",
          selectizeInput(
            inputId = "colname",
            choices = NULL,
            label = NULL,
            options = list(
              placeholder = "Select a column..."
            )
          )
        )
      ),
      hr(
        textInput(
          inputId = "text1",
          label = "Keywords to highlight in red"
        ),
        textInput(
          inputId = "text2",
          label = "Keywords to highlight in blue"
        )
      ),
      hr(
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
        )
      ),
      hr(
        actionButton(
          width = "100%",
          inputId = "help",
          label = "Need help?"
        )
      )
    ),
    mainPanel = mainPanel(
      wellPanel(
        div(
          id = "text-to-mark",
          textOutput("text")
        )
      )
    )
  )
)
