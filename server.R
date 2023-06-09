# === define server logic =====================================================

# --- load packages -----------------------------------------------------------
library(shiny)

# --- server ------------------------------------------------------------------
function(input, output, session) {
  
  # --- read data
  inputFile <- reactive({
    
    if(is.null(input$dataInput)){
      return("")
    }
    read.csv(file = input$dataInput$datapath)
  })
  
  # --- assign outcomes and render data
  output$contents <- renderTable({
    
    req(inputFile())
    
    data <- inputFile()
    
    data <- sdtt::assign_outcome(data = data,
                                 acc_var = "accuracy",
                                 signal_var = "change_type")
    
  })
  
  # --- user confirms data to calculate proportions and display measures ------
  confirmBut <- reactiveVal(0)

  observeEvent(input$confirmBut, {

    confirmBut(confirmBut() + 1)

  })
  
  output$proportions <- renderTable({
    
    req(inputFile())
    
    propData <- inputFile()
    
    propData <- sdtt::assign_outcome(data = propData,
                                     acc_var = "accuracy",
                                     signal_var = "change_type")
    
    propData <- sdtt::get_props(data = propData,
                                id_var = "id",
                                outcome_var = "outcome",
                                condition_var = "sequence",
                                correction = NULL)
  })
  
  shinyMeasure <- function(measure){
    
    req(inputFile())
    
    propData <- inputFile()
    
    propData <- sdtt::assign_outcome(data = propData,
                                     acc_var = "accuracy",
                                     signal_var = "change_type")
    
    propData <- sdtt::get_props(data = propData,
                                id_var = "id",
                                outcome_var = "outcome",
                                condition_var = "sequence",
                                correction = "loglinear")
    
    if(input$mType == "d'"){
      sdtt::calc_measures(propData,
                          hit_var = "p_hit",
                          fa_var = "p_fa",
                          measure = "d_prime")
    }
  }
  
  output$measures <- renderTable({
    
    req(shinyMeasure())
    
    shinyMeasure()
  })
  
}
