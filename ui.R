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
            p("This app enables you to use the ", em("iterative preference"), " algorithm on your own data."),
            p(strong("No responsibility will be taken by the authors if misuse of this information is made."))
          ), br(),
          
          # Purpose
          h2(icon("bullseye"), "Purpose"), hr(),
          
          div(
            "The problem being tackle here is of ", em("preference allocation/one-sided matching."), br(), br(),
            
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
            "Each of the tabs in the app are designed to do the following things:",
            tags$ul(
              tags$li("Navigate across different tabs by clicking on the options in the left-hand black vertical box."),
              tags$li("The ", strong("Guidance"), " tab contains information on the app's purpose, usage, data and construction.")
            )
          ), br(),
          
          # Further Information
          h2(icon("question-circle-o"), "Further Information"), hr(),
          div(
            "Useful information about the Data Sources used, the 
            Construction and Security of the app are placed in the box on 
            the right hand side of this page.", br(), br(),
            
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
        
      ) #tabItem
      
    ) #tabItems
  ) #dashboardBody
  
  
) #dashboardPage