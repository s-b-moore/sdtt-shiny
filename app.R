# === load packages ===========================================================
library(shiny)

# define user interface
ui <- fluidPage(
  
  # panel title
  titlePanel("sdtt"),
  
  column(4, wellPanel(
    
    h4("Please select the file you wish to analyse."),
    
    fileInput("dataInput", "Choose .csv file",
              accept = c(".csv")),
    
    tags$hr(),
    checkboxInput("header", "Header", TRUE)
  )),
  
  column(5, wellPanel(
    
    tableOutput("contents")
  ))
  
)

# define server logic
server <- function(input, output) {
  
  output$contents <- renderTable({
    inFile <- input$dataInput
    
    if(is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header = input$header)
  })
}

shinyApp(ui, server)