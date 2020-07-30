ui <- fluidPage(
  title = paste("Highlighter", ji("pencil")),
  use_marker(),
  useShinyjs(),
  use_waiter(),
  use_cicerone(),
  use_sever(),
  includeScript("www/inputs.js"),
  includeCSS("www/custom.css"),
  titlePanel(div(class = "app-title", paste("Highlighter", ji("pencil")))),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      "Upload a file or paste text from your clipboard!",
      br(),
      br(),
      fluidRow(
        column(
          width = 6,
          div(
            id = "guide_file",
            actionButton(
              width = "100%",
              inputId = "file_button",
              label = "Upload",
              icon = icon("upload")
            )
          )
        ),
        column(
          width = 6,
          actionButton(
            width = "100%",
            inputId = "textarea_button",
            label = "Paste",
            icon = icon("copy")
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
          selectInput(
            inputId = "colname",
            choices = names(imdb),
            selected = "Positive Reviews",
            label = NULL
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
        actionButton(
          width = "100%",
          inputId = "help",
          label = "Need help?"
        )
      )
    ),
    mainPanel = mainPanel(
      tabsetPanel(
        id = "tabs",
        tabPanel(title = "As Panel",
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
                 div(id = "guide_text",

                     wellPanel(div(
                       id = "text-to-mark",
                       textOutput("text")
                     )))),
        tabPanel(title = "As Table",
                 div(id = "guide_table",
                     reactableOutput("table")))

      )

    )
  )
)
