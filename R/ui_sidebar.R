sidebar_panel <- function() {
  sidebarPanel(
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
    hidden(hr(div(
      id = "hidden_tabname",
      selectizeInput(
        inputId = "tabname",
        choices = NULL,
        label = NULL,
        options = list(placeholder = "Select a tab (if .xlsx)...")
      )
    ))),
    hr(actionButton(
      width = "100%",
      inputId = "help",
      label = "Need help?"
    ))
  )
}
