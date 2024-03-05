library("tidyverse")
library("shiny")

homerange <- read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")

ui <- fluidPage(
  
  radioButtons("x", "Select Fill Variable", choices = c("trophic.guild", "thermoregulation"), 
               selected = "trophic.guild"),
  
  plotOutput("plot", width="500px", height="400px") #providing the size of the size/aspect of the visual
)

server <- function(input, output) {
  
  output$plot <- renderPlot({
    
    ggplot(data=homerange, aes_string(x="locomotion", fill=input$x)) + geom_bar(position="dodge", alpha=0.5, color="black") + labs(x=NULL, fill="Fill Variable")
    
  })
  
}

shinyApp(ui, server)