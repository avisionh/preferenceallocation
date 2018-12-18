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
    title = "Dashboard: Preference Allocation"
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
      
      # Subregion Report tab
      menuItem(
        text = "Report - Allocations",
        icon = icon(name = "list-ul"),
        tabName = "report_allocations"
      )
      
    ) #sideMenu
  
  ), #dashboardSidebar 
  
  # Body
  body = dashboardBody(
    tabItems(
      
      # Content: Guidance Tab ---------------------------------------------------
      tabItem(
        tabName = "info_guidance",
        
        box(
          width = 7, status = "warning", solidHeader = TRUE,
          
          # Welcome
          h2(icon("info"), "Welcome"), hr(),
          
          div(
            "Welcome to the R Shiny dashboard of Preference Allocations.",
            p("This dashboard enables you to use the ", em("iterative preference"), " algorithm on your own data."),
            p(strong("No responsibility will be taken by the authors if misuse of this information is made."))
          ),
          
          # Using the app
          h2(icon("users"), "Using the App"), hr(), 
          
          div(
            "Each of the tabs in the app are designed to do the following things:",
            tags$ul(
              tags$li("Navigate across different tabs by clicking on the options in the left-hand black vertical box."),
              tags$li("The ", strong("Guidance"), " tab contains information on the app's purpose, usage, data and construction.")
            )
          ),
          
          h2(icon("question-circle-o"), "Further Information"), hr(),
          div(
            "Useful information about the Data Sources used, the 
            Construction and Security of the app are placed in the box on 
            the right hand side of this page. Please raise any issues to the ", 
            a(href = "https://github.com/avisionh/Preference-Allocation/issues", "GitHub Issues page.")
          ), hr()
          
        ), #box
        
        box(
          width = 5, status = "warning", solidHeader = TRUE,
          
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
        
      ) #tabItem
      
    ) #tabItems
  ) #dashboardBody
  
  
) #dashboardPage