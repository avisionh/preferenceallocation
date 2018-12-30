# -------- #
# server.R #
# -------- #

# DESC: server.R code can be much longer and complicated than in ui.R.
#       Is where all the dynamic data manipulation happens, and plot creations.
#       e.g. Filtering based on user inputs and generating plots based on dynamically filtered data.
#       server.R must create a function called server, like below:

server <- function(input, output, session) {
  
  
  # Tab: Report - Example | Datatable ---------------------------------------

  # output delegates' preferences
  output$present_data_preference <- renderDataTable(
    expr = datatable(
      data = data_utility_delegates,
      # enable buttons and turn off rownames
      extensions = c("Buttons", "FixedColumns"), rownames = FALSE, colnames = TRUE,
      # impose structure in form of 'merged' cells on table
      container = table_preferences_skeleton,
      # add strips to left and right of each cell
      class = "cell-border stripe",
      # customise datatable further
      options = list(
        # enable horizontal scrolling
        scrollX = TRUE,
        # enable vertical scrolling
        scrollY = "30vh",
        pageLength = 10,
        # set the table control elements to be at top of table rather than bottom
        dom = '<"top"rlip>t<"bottom">'
      ) #list
    )
  )
}