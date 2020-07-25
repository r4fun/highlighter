server <- function(input, output, session) {
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
    update_idx = 1L
  )

  # ----------------------------------------------------------------------------
  #' Reactive data input, provided by user via file upload
  # ----------------------------------------------------------------------------
  data <- reactive({
    req(input$file)
    w$show()

    ext <- file_ext(input$file$name)
    out <- switch (ext,
      csv = read_csv(input$file$datapath, delim = ","),
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
    out
  })

  # ----------------------------------------------------------------------------
  #' Index based on next/previous clicks
  # ----------------------------------------------------------------------------
  observe({
    rv$idx <- as.numeric(1 + input$next_text - input$previous_text)
  })

  # ----------------------------------------------------------------------------
  #' If the data is a list (excel sheet), show a tab name dropdown and populate
  #' it. Otherwise, hide the tab name (in case users are switching back and
  #' forth). If it's a data.frame, just update the column names dropdown.
  # ----------------------------------------------------------------------------
  observeEvent(data(), {
    if (inherits(data(), "list")) {
      show("hidden_tabname")
      updateSelectizeInput(
        session = session,
        inputId = "tabname",
        choices = names(data())
      )
    } else {
      hide("hidden_tabname")
    }

    if (inherits(data(), "data.frame")) {
      updateSelectizeInput(
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
    updateSelectizeInput(
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
  observeEvent(input$go, {
    out <- extract_text(
      .data = data(),
      idx = rv$idx,
      colname = input$colname,
      tabname = input$tabname
    )

    rv$update_idx <- rv$update_idx + 1
    rv$max_idx <- out$max_idx
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
  }, ignoreInit = TRUE)

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

  observeEvent(input$text1, {
    marker$
      unmark(className = "red")$
      mark(input$text1, className = "red")
  })

  observeEvent(input$text2, {
    marker$
      unmark(className = "blue")$
      mark(input$text2, className = "blue")
  })
}
