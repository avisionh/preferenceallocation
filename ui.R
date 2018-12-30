# ---- #
# ui.R #
# ---- #
# DESC: The ui.R script should be relatively short and straightforward. 
#       All that happens here is setting out where things go.
#       There are no calculations.
#       ui.R must create an object called ui, for example:

ui <- dashboardPage(
  
  # Title and Skin
  title = "Preference Allocation",
  skin = "yellow",
  
  # Header
  header = dashboardHeader(
    title = "Preference Allocation"
  ),
  
  # Sidebar
  sidebar = dashboardSidebar(
    
    sidebarMenu(
      id = "menu",
      
      # Guidance tab
      menuItem(
        text = "Guidance",
        icon = icon(name = "info-circle"),
        tabName = "info_guidance"
      ),
      
      # Distributions Report tab
      menuItem(
        text = "Report - Distributions",
        icon = icon(name = "poll-h"),
        tabName = "report_example"
      ),
      
      # Allocations Report tab
      menuItem(
        text = "Report - Allocations",
        icon = icon(name = "project-diagram"),
        tabName = "report_allocations"
      )
      
    ) #sideMenu
  
  ), #dashboardSidebar 
  
  # Body
  body = dashboardBody(
    
    # load CSS classes
    tags$head(
      # Include our custom CSS
      includeCSS(path = "www/custom.css")
    ),
    
    # MIT-license marking
    tags$script(HTML('
                    $(document).ready(function() {
                    $("header").find("nav").append(\'<div class="license-class"> Licensed under the MIT License </div>\');
                    })
                    ')
    ),
    
    tabItems(
      
      # ----------------------------------------------------------------------- #
      # Tab: Guidance -----------------------------------------------------------
      # ----------------------------------------------------------------------- #
      
      tabItem(
        tabName = "info_guidance",
        
        box(
          width = 7, status = "warning", solidHeader = TRUE,
          
          # Welcome
          h2(icon("info"), "Welcome"), hr(),
          
          div(
            "Welcome to the R Shiny dashboard app for Preference Allocations!
            This app enables you to use the ", em("iterative preference"), " algorithm on your own data.",
            p(strong("No responsibility will be taken by the authors if misuse of this information is made."))
          ), br(),
          
          # Purpose
          h2(icon("bullseye"), "Purpose"), hr(),
          
          div(
            "The problem being tackle here is of ", strong("preference allocation/one-sided matching."), br(), br(),
            
            "Consider that we have to assign ", em("m"), " people to ", em("n"), " sessions.", br(),
            tags$ul(
              tags$li("For each individual, they can only attend one of these ", em("n"), " sessions."),
              tags$li("Each session can hold a varying number of people."),
              tags$li("For each of these ", em("n"),  " sessions, an individual will have a strict preference ordering, 
                       meaning that they strictly prefer some sessions over others.")
            ), br(),
            
            "The task is to allocate these ", em("m"), " people to the ", em("n"), " sessions, 
            accounting for their preferences in such a way that the total utility of all ", em("m"), " people is maximised."
          ), br(),
          
          # Methodology
          h2(icon("calculator"), "Methodology"), hr(), 
          
          div(
            "The ", strong("iterative preference"), " algorithm involves a number of rounds.", br(), br(),
            "Each round works as follows:",
            tags$ol(
              tags$li("Pick a delegate at random and assign them to their most preferred session."),
              tags$li("If this session is full, then assign them to their next most preferred session."),
              tags$li("Repeat the previous step until this randomly selected delegate is allocated to a free session."),
              tags$li("Pick another delegate at random and repeat the previous steps until they are allocated to a free session."),
              tags$li("Process continues until all delegates have been assigned to a free session.")
            )
          ), br(),
          
          # Further Information
          h2(icon("question-circle-o"), "Further Information"), hr(),
          div(
            "To view the progress of this project, see the",
            a(href = "https://avisionh.visualstudio.com/Preference%20Allocation/_boards/board/t/Preference%20Allocation%20Team/Stories", 
              "Azure DevOps project Kanban board."), br(), br(),
            
            "The authors of this algorithm and app are:",
            tags$ul(
              tags$li(a(href = "https://github.com/avisionh", "Avision Ho")),
              tags$li(a(href = "https://github.com/ledu1993", "Le Duong"))
            ),
            
            "Please raise any issues to the ", 
            a(href = "https://github.com/avisionh/Preference-Allocation/issues", "GitHub Issues page.")
          ), hr()
          
        ), #box
        
        box(
          width = 5, status = "warning", solidHeader = TRUE,
          
          # Using the app
          h2(icon("users"), "Using the App"), hr(), 
          
          div(
            "Each of the tabs in the app are designed to do the following things:",
            tags$ul(
              tags$li("Navigate across different tabs by clicking on the options in the left-hand black vertical box."),
              tags$li("The ", strong("Guidance"), " tab contains information on the app's purpose, usage, data and construction.")
            )
          ), br(),
          
          # Data Sources
          h2(icon("database"), "Data Sources"), hr(),
          
          div(
            "This app uses dummy-generated data.", br()
          ), hr(),
          
          # Construction
          h2(icon("cogs"), "Construction"), hr(),
          
          div(
            "This app has been constructed using: ", br(),
            tags$ul(
              tags$li(a(href = "https://www.r-project.org/", "R"), "(for the data processing and calculation)"),
              tags$li(a(href = "https://shiny.rstudio.com/", "R Shiny", target = "_blank"), "(for the app design and interactivity)"),
              tags$li(a(href = "https://rstudio.github.io/shinydashboard/", "Shiny Dashboard", target = "_blank"), "(for the app layout and structure)")
            )
          ), hr()
          
        ) #box
        
      ), #tabItem
      
      
      # ----------------------------------------------------------------------- #
      # Tab: Report - Example ---------------------------------------------------
      # ----------------------------------------------------------------------- #
      
      tabItem(
        tabName = "report_example",
        
        tabBox(
          width = NULL,
          tabPanel(title = "Chart: Preference Distribution", height = "100%",
                   
                   fluidRow(
                     box(width = 9, status = "success", solidHeader = TRUE,
                         dataTableOutput(outputId = "present_data_preference")),
                     
                     box(width = 3, status = "success", solidHeader = TRUE,
                         h3("Filters"), hr(),
                         # choose specific person
                         selectInput(inputId = "select_person",
                                     label = "Choose a specific person/people",
                                     choices = NULL,
                                     multiple = TRUE),
                         actionButton(inputId = "clear_filter",
                                      label = "Clear selection",
                                      width = "100%"))
                   ),
                   fluidRow(
                     box(width = 9, status = "success", solidHeader = TRUE,
                         plotOutput(outputId = "plot_data_preference"))
                   )
                   
          ) #tabPanel
        ) #tabBox
      ), #tabItem
      
      
      # ----------------------------------------------------------------------- #
      # Tab: Report - Allocations -----------------------------------------------
      # ----------------------------------------------------------------------- #
      
      tabItem(
        tabName = "report_allocations"
      ) #tabItem
      
      
    ) #tabItems
  ) #dashboardBody
  
  
) #dashboardPage