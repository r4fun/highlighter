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
    sidebarPanel = sidebar_panel(),
    mainPanel = mainPanel(
      tabsetPanel(
        id = "tabs",
        card_tab(),
        table_tab()
      )
    )
  )
)
