# === define the user interface ===============================================

# --- load packages -----------------------------------------------------------
library(shiny)
library(shinydashboard)
library(tidyverse)
library(shinyBS)
        
# --- dashboard page structure ------------------------------------------------
tagList(
  dashboardPage(
    skin = "green",
    
    # --- dashboard header ----------------------------------------------------
    dashboardHeader(title = "sdtt",
                    titleWidth = 200
                    ),
    
    # --- dashboard sidebar ---------------------------------------------------
    dashboardSidebar(width = 200,
                     sidebarMenu(id = "sidebar",
                                 
                                 # --- sidebar item one
                                 menuItem("Information", tabName = "info",
                                          icon = icon("dashboard")),
                                 
                                 # --- sidebar item two
                                 menuItem("sdtt", tabName = "sdtt",
                                          icon = icon("table"))
                                 )
                     ),
    
    # --- dashboard body ------------------------------------------------------
    dashboardBody(
      
      # --- begin list of sidebar items
      tabItems(
        
        # --- sidebar item one
        tabItem(tabName = "info",
                h2("sdtt: information"),
                
                # --- generate boxes to provide information
                fluidRow(
                  
                  # --- how to use box
                  
                  
                  # --- creator box
                  
                  
                )
                
                ),
        
        # --- sidebar item two
        tabItem(tabName = "sdtt",
                h2("sdtt: simple detection theory tool"),
                
                fluidPage(
                  
                  fluidRow(
                    column(4,
                           wellPanel(
                             h4("Please select the file you wish to analyse."),
                             fileInput("dataInput", "Choose .csv file",
                                       accept = c(".csv")),
                             
                             tags$hr(),
                             checkboxInput("header", "Header", TRUE),
                             ))),
                  
                  fluidRow(
                    column(4,
                           wellPanel(
                             h4("Please select the measures you wish to calculate."),
                             tags$hr(),
                             checkboxInput("d_prime", "d'", FALSE),
                             checkboxInput("abs_c", "Absolute criterion", FALSE),
                             checkboxInput("c_prime", "c'", FALSE),
                             checkboxInput("beta", "Log-likelihood", FALSE)
                             ))),
                ),
                  fluidRow(
                    column(5,
                       tableOutput("contents")
                ))
              

        )
      )
    )
  )
)