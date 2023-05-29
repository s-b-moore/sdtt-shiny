# === define server logic =====================================================

# --- load packages -----------------------------------------------------------
library(shiny)

# --- server ------------------------------------------------------------------
function(input, output, session) {

  # --- automatically assign outcomes and display table -----------------------
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
