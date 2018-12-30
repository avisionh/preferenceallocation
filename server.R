# -------- #
# server.R #
# -------- #

# DESC: server.R code can be much longer and complicated than in ui.R.
#       Is where all the dynamic data manipulation happens, and plot creations.
#       e.g. Filtering based on user inputs and generating plots based on dynamically filtered data.
#       server.R must create a function called server, like below:

server <- function(input, output, session) {
  
  # ----------------------------------------------------------------------- #
  # Tab: Report - Example | Datatable ---------------------------------------
  # ----------------------------------------------------------------------- #
  
  # 1. Button: Filter Delegate Preference Table ------------------------------------
  
  # DESC: Creates an feature that observes when a button is clicked by the user
  #       and reacts by filtering the present_data_preference table by person selected
  #       when this button is clicked.
  
  # 1.1 create reactiveValue to store state of data_utility_delegates when button is clicked
  filtered_data_preference <- reactiveValues(data = data_utility_delegates)
  
  # 1.2 pass through values for user to select from
  updateSelectizeInput(session = session, inputId = "select_person",
                       choices = vec_delegates)
  
  # 1.3 establish logic to filter the filtered_data_preference reactiveValue
  observeEvent(
    eventExpr = input$select_person,
    handlerExpr = {
      if(is.null(input$select_person)) {
        return(filtered_data_preference$data <- data_utlity_delegates)
      } else {
        filtered_data_preference$data <- data_utility_delegates %>% 
          filter(Delegate %in% c(input$select_person))
      }
    } #handlerExpr
  ) #observeEvent

  # output delegates' preferences
  output$present_data_preference <- renderDataTable(
    expr = {
        datatable(
        data = filtered_data_preference$data,
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
      ) #datatable
    }
  ) #renderDataTable

}