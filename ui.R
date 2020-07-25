ui <- fluidPage(
  use_marker(),
  useShinyjs(),
  includeCSS("www/custom.css"),
  titlePanel(paste("Highlighter", ji("pencil"))),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      "Please upload a file, then select a column name and hit the go button to
      render text. If you are uploading a .xlsx file, you have the option to
      define the tab you're interested in.",
      br(),
      br(),
      fileInput(
        inputId = "file",
        label = NULL,
        accept = c(
          ".csv",
          ".xlsx",
          ".rds"
        )
      ),
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
      selectizeInput(
        inputId = "colname",
        choices = NULL,
        label = NULL,
        options = list(
          placeholder = "Select a column..."
        )
      ),
      actionButton(
        inputId = "go",
        label = "Render text",
        width = "100%"
      )
    ),
    mainPanel = mainPanel(
      actionButton(
        inputId = "previous_text",
        label = "Previous"
      ),
      actionButton(
        inputId = "next_text",
        label = "Next"
      ),
      br(),
      br(),
      wellPanel(
        div(
          id = "text-to-mark",
          textOutput("text")
        )
      ),
      textInput(
        inputId = "text1",
        label = "Keywords to highlight in red"
      ),
      textInput(
        inputId = "text2",
        label = "Keywords to highlight in blue"
      )
    )
  )
)
