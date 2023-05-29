#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {

  output$contents <- renderTable({
    inFile <- input$dataInput
    
    if(is.null(inFile))
      return(NULL)
    
    data <- read.csv(inFile$datapath, header = input$header)
    
    data <- sdtt::assign_outcome(data = data,
                                 acc_var = "accuracy",
                                 signal_var = "change_type")
    
  })

}
