# -------- #
# server.R #
# -------- #

# DESC: server.R code can be much longer and complicated than in ui.R.
#       Is where all the dynamic data manipulation happens, and plot creations.
#       e.g. Filtering based on user inputs and generating plots based on dynamically filtered data.
#       server.R must create a function called server, like below:

server <- function(input, output, session) {
  
  # ----------------------------------------------------------------------- #
  # Tab: Report - Example  --------------------------------------------------
  # ----------------------------------------------------------------------- #
  

  # 1. Sub-tab: Chart... -------------------------------------------------------
  # -------------------------------------------------------------------------- #
  
  # i. Button | Filter delegate preference table ------------------------------------
  # DESC: Creates an feature that observes when the 'Filter' button is clicked and
  #       reacts by filtering the present_data_preference table by person selected
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
  

  # ii. Button | Clear filter delegate preference table -----------------------
  # DESC: Creates a feature that observes when the 'Clear Filter' button is clicked
  #       and reacts by clearing the filters/selectiosn on the present_data_prederence
  #       table.
  
  observeEvent(
    eventExpr = input$clear_filter,
    handlerExpr = {filtered_data_preference$data <- data_utility_delegates}
  )
  

  # iii. Output Table | Delegate preferences ----------------------------------
  # DESC: Outputs the filtered_data_preference reactiveValue data table for
  #       the user to view.
  
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
  
  

  # iv. Output Plot | Delegate preferences -----------------------------------
  # DESC: Outputs the filtered_utility_delegates reactiveValue data table as a
  #       plot for users to view.
  
  # 4.1 reshape data for plotting
  plot_data_preference <- reactive(
    x = {
      filtered_data_preference$data %>% 
        gather(key = "Talk", value = "Utility", 
               Session_01, Session_02, Session_03, Session_04) %>% 
        # sum the values for each session, divide by 10 to reduce utility values
        group_by(Talk) %>% 
        summarise(TotalUtility = sum(x = Utility/10, na.rm = TRUE)) %>% 
        # compute percentages
        mutate(Proportion = TotalUtility/sum(TotalUtility))
    }
  )
  
  # 4.2 plot the data
  output$plot_data_preference <- renderPlot(
    expr = {
      ggplot(data = plot_data_preference(), mapping = aes(x = Talk, y = Proportion)) +
        geom_col(fill = cb_palette["cb_green"]) +
        geom_label(mapping = aes(label = paste0("Count: ", TotalUtility)), colour = "black") +
        labs(title = "Bar Chart: Delegates' Preferences",
             caption = "The unit of measure, utility, is in ordinal units, where a utility 
                        score of '4' means the talk is more preferred than a talk with
                        a utility score of '3'.",
             x = "Talk/Session", y = "Proportion") +
        # hide grey plot background
        theme(plot.title = element_text(face = "bold", hjust = 0.5),
              plot.subtitle = element_text(face = "bold", hjust = 0.5),
              panel.background = element_blank(),
              axis.line = element_line(color = "black")) +
        # add text wrapping for x-labels
        scale_x_discrete(labels = function(x) str_wrap(x, width = 10))
    }
  )
  

  # 2. Sub-tab: Output... ------------------------------------------------------
  # -------------------------------------------------------------------------- #


  # i. Button | Run algorithm ------------------------------------------------
  # DESC: Creates a feature that observes when the 'Run algorithm' button is clicked
  #       and reacts by running the 'func_iterative_preference' function on our dataset.
  
  # i.i create reactiveValue to store state of algorithm's output when button is clicked
  filtered_data_allocations <- reactiveValues(data = NULL)
  
  # i.ii establish logic to filter the filtered_data_allocation reactiveValue
  observeEvent(
    eventExpr = input$run_algorithm,
    handlerExpr = {
      if(is.null(input$run_algorithm)) {
        return(filtered_data_allocations$data)
      } else {
        filtered_data_allocations$data <- func_iterative_preferences(x = data_utility_delegates,
                                                                     limits = room_sizes,
                                                                     with_replacement = FALSE)
      }
    } #handlerExpr
  ) #observeEvent
  
  

  # iii. Output Table | Allocations -----------------------------------------
  # DESC: Outputs the filtered_data_allocations reactiveValue data table for
  #       the user to view.
  
  # i.i create reative to manipulate and store dataframe for outputting
  present_allocations <- reactive(
    x = {
      
      # store row IDs to join on
      id_rows <- filtered_data_allocations$data[[1]]$PersonRowId
      # create lookup table for joining
      table_lookup <- data_utility_delegates[id_rows, ] %>% 
        cbind(IdRow = id_rows) %>% 
        mutate(IdRow = as.integer(as.character(IdRow)))
      
      data <- filtered_data_allocations$data[[1]] %>%
        mutate(PersonRowId = as.integer(PersonRowId)) %>%
        left_join(y = table_lookup, by = c("PersonRowId" = "IdRow")) %>%
        select(Delegate, SessionPreferred = SessionPreferredColumnId)
      
      return(data)
    }
  ) #reactive
  
  # output delegates' preferences
  output$present_data_allocations <- renderDataTable(
    expr = {
      datatable(
        data = present_allocations(),
        # enable buttons and turn off rownames
        extensions = c("Buttons", "FixedColumns"), rownames = FALSE, colnames = TRUE,
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


  # ----------------------------------------------------------------------- #
  # Tab: Report - Allocations  ----------------------------------------------
  # ----------------------------------------------------------------------- #
  
  
  # 1. Sub-tab: Output... ------------------------------------------------------
  # -------------------------------------------------------------------------- #
  
  # i. Output Table | Delegate preference --------------------------------------
  # DESC: Creates a feature that outputs the user-inputted .csv or .txt file
  
  output$present_user_data <- renderDataTable(
    expr = {
      
      # check if user has provided a value
      req(input$import_data)
      
      user_data <- read_delim(file = input$import_data$datapath,
                              delim = input$import_seperator)
      
      return(user_data)
    }
  )
  
    
  # End Shiny Session -------------------------------------------------------
  # DESC: Stops shiny app after closing the browser
  
  session$onSessionEnded(function() {
    stopApp()
  }) 

}