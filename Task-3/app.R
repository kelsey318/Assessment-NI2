#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


#Task 3

library(shiny)
library (ggplot2)
data
# Define UI
ui <- fluidPage(
  titlePanel("CD8 T cells mRNA expression of Mthfd1l level after activation"),
  sidebarLayout(
    sidebarPanel(
      selectInput("category", "Category", choices = unique(data$Category)),
      numericInput("barWidth", "Bar Width", value = 0.5, min = 0.1, max = 2, step = 0.1),
      numericInput("valueThreshold", "Value Threshold", value = 0, min = 0, max = max(data$Value))
    ),
    mainPanel(
      plotOutput("barPlot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$barPlot <- renderPlot({
    filtered_data <- subset(data, Category == input$category & Value >= input$valueThreshold)
    ggplot(filtered_data, aes(x = Condition, y = Value, fill = Condition)) +
      geom_bar(stat = "identity", position = "dodge", width = input$barWidth) +
      labs(title = paste("CD8 T cells mRNA expression of Mthfd1l level after activation", input$category), x = "hrs post activation", y = "relative mRNA expression") +
      theme_minimal()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

