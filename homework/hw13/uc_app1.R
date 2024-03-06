library(tidyverse)
library(shiny)
library(shinydashboard)
library(naniar)
library(janitor)

UC_admit <- read_csv("/Users/aminamuhic/Desktop/BIS15W2024_amuhic/lab14/data/UC_admit.csv")

cleanUC_admit <- UC_admit %>% 
  mutate(`Perc FR`=as.numeric(sub("%", "", `Perc FR`))) %>% 
  clean_names()

ui <- dashboardPage(
  dashboardHeader(title = "UC Admissions"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    
    fluidRow(
      
      box(title = "Plot Options", width = 3, 
          selectInput("x", "Select Year", 
                      choices = unique(cleanUC_admit$academic_yr), 
                      selected = 2010), 
          selectInput("y", "Select Campus", 
                      choices = unique(cleanUC_admit$campus), 
                      selected = "Davis"), 
          selectInput("z", "Select Admit Category", 
                      choices = unique(cleanUC_admit$category), 
                      selected = "Applicants")
      ), #close first box
      
      box(title = "Ethnicity", width = 9,
          plotOutput("plot", width = "800px", height = "600px")
      ) 
    ) 
    
  )
) 

server <- function(input, output, session) {
  
  session$onSessionEnded(stopApp)
  output$plot <- renderPlot({
    
    cleanUC_admit %>% filter(ethnicity != "All" & perc_fr != "NA") %>% 
      filter(academic_yr == input$x) %>% 
      filter(campus == input$y) %>% 
      filter(category == input$z) %>%
      ggplot(aes_string(x="ethnicity", y="perc_fr", fill="ethnicity")) +
      geom_col(alpha=0.5, color="black") +
      labs(x=NULL,
           y="% Applicants, Admits, or Enrollees",
           fill="Ethnicity") +
      theme(axis.text.x = element_text(angle=60, hjust=1),
            axis.title.x = element_text(size=10),
            axis.title.y = element_text(size=10))
    
  })
  
}

shinyApp(ui, server)