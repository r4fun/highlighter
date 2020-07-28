textarea_modal <- function() {
  showModal(
    modalDialog(
      title = h3("Copy and paste", align = "center"),
      column(
        width = 12,
        align = "center",
        textAreaInput(
          inputId = "textarea",
          label = NULL
        ),
        br()
      ),
      footer = tagList(
        column(
          width = 12,
          align = "center",
          actionButton(
            inputId = "confirm_textarea",
            label = "Confirm",
            icon = icon("check")
          ),
          actionButton(
            inputId = "cancel_textarea",
            label = "Cancel",
            icon = icon("ban")
          )
        )
      )
    )
  )
}
