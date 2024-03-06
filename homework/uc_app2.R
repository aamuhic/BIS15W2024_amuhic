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
          selectInput("x", "Select Campus", 
                      choices = unique(cleanUC_admit$campus), 
                      selected = "Davis"), 
          selectInput("y", "Select Category", 
                      choices = unique(cleanUC_admit$category), 
                      selected = "Applicants"), 
          selectInput("z", "Select Admit Ethnicity", 
                      choices = unique(cleanUC_admit$ethnicity), 
                      selected = "International")
      ), #close first box
      
      box(title = "Yearly Trends", width = 9,
          plotOutput("plot", width = "800px", height = "600px")
      ) #close second box
    ) #close row
    
  ) #close dashboard body
) #close ui

server <- function(input, output, session) {
  
  session$onSessionEnded(stopApp)
  output$plot <- renderPlot({
    
    cleanUC_admit %>% mutate(academic_yr=as.factor(academic_yr)) %>% 
      filter(ethnicity != "All" & perc_fr != "NA") %>% 
      filter(campus == input$x) %>% 
      filter(category == input$y) %>% 
      filter(ethnicity == input$z) %>%
      ggplot(aes_string(x="academic_yr", y="perc_fr")) +
      geom_point(color="red") +
      geom_path(group="keep") +
      labs(x="Academic Year",
           y="% Applicants, Admits, or Enrollees") +
      theme(axis.title.x = element_text(size=10),
            axis.title.y = element_text(size=10))
    
  })
  
}

shinyApp(ui, server)
