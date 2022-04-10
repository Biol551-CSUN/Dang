library(shiny)
library(tidyverse)

ui <- fluidPage(
  sliderInput(inputId = "num",                   ## ID name for the input
              label = "Choose a number",         ## label above the input
              value = 25, min = 1, max = 100     ## values for the slider
  ),
  textInput(inputId = "title",           ## new Id is title
            label = "Write a title",
            value = "Histogram of Random Normal Values"),    ## starting title
  plotOutput("hist"),     ## creates space for a plot called hist
  verbatimTextOutput("stats")   ## creates space for stats
)

server <- function(input, output){
  output$hist <- renderPlot({
    ## {} allows us to put all our R code in one nice chunk
    data <- reactive({    ## make data matches with plot and summary when slider is moved
      tibble(x = rnorm(input$num))   ## 100 random normal points
    })
    
    ggplot(data(), aes(x = x)) +       ## make a histogram
      geom_histogram() +
      labs(title = input$title)      ## add a new title
  })
  output$stats <- renderPrint({
    summary(data())      ## calculate summary stats based on the numbers
  })
}

shinyApp(ui = ui, server = server)