app_guide <- function() {
  Cicerone$
    new()$
    step(
      el = "guide_file",
      title = "File Upload",
      description = "Click this button to upload a file. Currently accepts a
      .csv, .xlsx. and .rds file. If there's an excel file with multiple sheets,
      a dropdown will pop up so you can switch between them."
    )$
    step(
      el = "textarea_button",
      title = "Paste button",
      description = "If you just want to copy and paste some text, you can do that here."
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
    )$
    step(
      el = "guide_text",
      title = "Text Content",
      description = "The content of the text will appear here."
    )
}
