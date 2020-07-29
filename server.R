server <- function(input, output, session) {
  observeEvent(input$file_button, {
    file_modal()
  })

  observeEvent(input$textarea_button, {
    textarea_modal()
  })

  observeEvent(input$cancel_textarea, {
    removeModal()
  })

  observeEvent(input$confirm_textarea, {
    output$text <- renderText(input$textarea)
    removeModal()
  })

  observeEvent(input$cancel_upload, {
    removeModal()
  })

  # ----------------------------------------------------------------------------
  #' Pretty disconnection screen
  # ----------------------------------------------------------------------------
  sever()

  # ----------------------------------------------------------------------------
  #' Waiter screens
  # ----------------------------------------------------------------------------
  w <- Waiter$new(html = span("Initialising", br(), br(), spin_dots()))

  # ----------------------------------------------------------------------------
  #' Disable the previous/next buttons by default (on load)
  # ----------------------------------------------------------------------------
  disable("next_text")
  disable("previous_text")

  # ----------------------------------------------------------------------------
  #' Store reactive values
  # ----------------------------------------------------------------------------
  rv <- reactiveValues(
    idx = 1L,
    max_idx = 1L,
    update_idx = 1L,
    next_text = 1L,
    previous_text = 1L
  )

  # ----------------------------------------------------------------------------
  #' Reactive data input, provided by user via file upload
  # ----------------------------------------------------------------------------
  data <- reactive({
    if (is.null(input$file)) {
      out <- imdb
    } else {
      req(input$file)
      w$show()
      removeModal()

      ext <- file_ext(input$file$name)
      out <- switch (ext,
        csv = read_csv(input$file$datapath),
        rds = read_rds(input$file$datapath),
        xlsx = {
          sheets <- excel_sheets(input$file$datapath)
          out <- lapply(sheets, function(x) {
            read_excel(input$file$datapath, sheet = x)
          })
          names(out) <- sheets
          out
        },
        validate("Invalid file; Please upload a .csv, .xlsx, or .rds file")
      )
      w$hide()
    }
    out
  })

  # ----------------------------------------------------------------------------
  #' Index based on next/previous clicks
  # ----------------------------------------------------------------------------
  observeEvent(input$next_text, {
    rv$next_text <- rv$next_text + 1L
  })

  observeEvent(input$previous_text, {
    rv$previous_text <- rv$previous_text + 1L
  })

  observe({
    rv$idx <- as.numeric(1 + rv$next_text - rv$previous_text)
  })

  # ----------------------------------------------------------------------------
  #' If the data is a list (excel sheet), show a tab name dropdown and populate
  #' it. Otherwise, hide the tab name (in case users are switching back and
  #' forth). If it's a data.frame, just update the column names dropdown.
  # ----------------------------------------------------------------------------
  observeEvent(data(), {
    if (inherits(data(), "list")) {
      show("hidden_tabname")
      updateSelectInput(
        session = session,
        inputId = "tabname",
        choices = names(data())
      )
    } else {
      hide("hidden_tabname")
    }

    if (inherits(data(), "data.frame")) {
      updateSelectInput(
        session = session,
        inputId = "colname",
        choices = names(data())
      )
    }
  })

  # ----------------------------------------------------------------------------
  #' If the tab name is populated, update the column name dropdown based on the
  #' columns in that tab.
  # ----------------------------------------------------------------------------
  observeEvent(input$tabname, {
    updateSelectInput(
      session = session,
      inputId = "colname",
      choices = names(data()[[input$tabname]])
    )
  })

  # ----------------------------------------------------------------------------
  #' When the go button is hit, do the following:
  #' * extract the first text item
  #' * update the reactive 'update_idx' value
  #' * store the max index
  #' * render the text.
  # ----------------------------------------------------------------------------
  observeEvent(input$colname, {
    out <- extract_text(
      .data = data(),
      idx = rv$idx,
      colname = input$colname,
      tabname = input$tabname
    )

    rv$update_idx <- rv$update_idx + 1
    rv$max_idx <- out$max_idx
    rv$next_text <- 1L
    rv$previous_text <- 1L
    output$text <- renderText(out$text)
  })

  # ----------------------------------------------------------------------------
  #' When the update_idx reactive value triggers:
  #' * reset the max_idx reactive value to 1
  #' * if the max_idx == the current/reset idx (i.e. only has 1 row), disable
  #' the previous/next buttons otherwise, enable the next test button
  # ----------------------------------------------------------------------------
  observeEvent(rv$update_idx, {
    rv$idx <- 1L
    if (rv$max_idx == rv$idx) {
      disable("previous_text")
      disable("next_text")
    } else {
      enable("next_text")
    }
  })

  # ----------------------------------------------------------------------------
  #' Observe the idx reactive value:
  #' * disable previous text if idx reaches 1
  #' * enable previous text if idx leaves 1
  #' * disable next text if idx reach max idx
  #' * enable next text if idx leaves max idx
  #' * render the text item
  # ----------------------------------------------------------------------------
  observeEvent(rv$idx, {
    if (rv$idx == 1) {
      disable("previous_text")
    } else {
      enable("previous_text")
    }

    if (rv$idx == rv$max_idx) {
      disable("next_text")
    } else {
      enable("next_text")
    }

    out <- extract_text(
      .data = data(),
      idx = rv$idx,
      colname = input$colname,
      tabname = input$tabname
    )

    output$text <- renderText(out$text)
  }, ignoreInit = TRUE)

  # ----------------------------------------------------------------------------
  #' Highlight text
  # ----------------------------------------------------------------------------
  marker <- marker$new("#text")
  red_marker_listener <- reactive({
    list(input$next_text, input$previous_text, input$text1)
  })

  blue_marker_listener <- reactive({
    list(input$next_text, input$previous_text, input$text2)
  })

  observeEvent(red_marker_listener(), {
    marker$
      unmark(className = "red")$
      mark(input$text1, className = "red", delay = 100)
  })

  observeEvent(blue_marker_listener(), {
    marker$
      unmark(className = "blue")$
      mark(input$text2, className = "blue", delay = 100)
  })

  # ----------------------------------------------------------------------------
  #' App tour
  # ----------------------------------------------------------------------------
  guide$init()
  observeEvent(input$help, {
    guide$start()
  })
}
