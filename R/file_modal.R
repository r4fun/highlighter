file_modal <- function() {
  showModal(
    modalDialog(
      title = h3("Upload a file", align = "center"),
      column(
        width = 12,
        align = "center",
        fileInput(
          inputId = "file",
          label = NULL,
          accept = c(
            ".csv",
            ".xlsx",
            ".rds"
          )
        ),
        br()
      ),
      footer = tagList(
        column(
          width = 12,
          align = "center",
          actionButton(
            inputId = "cancel_upload",
            label = "Cancel",
            icon = icon("ban")
          )
        )
      )
    )
  )
}
