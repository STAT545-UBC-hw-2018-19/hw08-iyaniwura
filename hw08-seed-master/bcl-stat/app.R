library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(colourpicker)



bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)

ui <- fluidPage(
  titlePanel("BC Liquor Store prices"),  # title
  sidebarLayout(
    sidebarPanel(	      sliderInput("priceInput", "Choose a price range", 0, 100, c(25, 40), pre = "$"),   #  include slidebar
      radioButtons("typeInput", "Product type",
                  choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                  selected = "WINE"),  # include radio button
      checkboxInput("sortInput", "Sort Price", value = FALSE),  # include checkbox
      uiOutput("countryOutput"),  
      colourInput("col", "Select colour for the barchart","blue",returnName = TRUE, palette = "limited"),
      colourInput("col2", "Select colour for the barchart boundary","Green",returnName = TRUE, palette = "limited"), 
      textOutput("statement"),   # include statement
      downloadButton('ResultData', 'Download Result'), # for download button
      textOutput("statement2"),  # include statement
      downloadLink('BclData', 'Click to download data set')  # for download link
      
    ),
    
    mainPanel(  tabsetPanel(
      tabPanel(img(src= "bcliquor_pic.jpg",height = 250, width = 370,align="center")),  # include image
      tabPanel(img(src= "bg-liquor-store-2.jpg",height = 250, width = 370,align="right")),  # include image
      tabPanel(plotOutput("coolplot",height = 400, width = 800)),   # include plot
      br(), br(),    # two lines break
      tabPanel(DT::dataTableOutput("results") )  # include table
      )
      )
)  )

server <- function(input, output) {
  output$countryOutput <- renderUI({
    selectInput("countryInput", "Country",
                sort(unique(bcl$Country)),
                selected = "CANADA")
  })  
  
  filtered <- reactive({
    if (is.null(input$countryInput)) {
      return(NULL)
    }    
    
    Temp <- bcl %>%
        filter(Price >= input$priceInput[1],
               Price <= input$priceInput[2],
               Type == input$typeInput,
               Country == input$countryInput
        ) 
      
    if (input$sortInput) {
        Temp %>%
          arrange(Price)
    } else {
      Temp
    }
    
    if (nrow(Temp) == 0){
    	Temp  <- NULL
    } else {
    	Temp 
    }
    
})
  
 
  
  output$coolplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    ggplot(filtered(), aes(Alcohol_Content)) +
      geom_histogram(aes(color = " ",fill=" ")) +
      scale_fill_manual(values = input$col) +
      scale_color_manual(values = input$col2) 
      
  })

  output$results <- DT::renderDataTable({
    filtered()
  })
  
  
    output$statement <- renderText({
   	paste("We found", toString(dim(filtered())[1]) ,  "options for you")    	
   })
    
    
    output$statement2 <- renderText({
    	"You can also download the entire data set by clicking the link below"
    })
    
    
    
    output$ResultData <- downloadHandler(
    	filename = function() {
    		paste('filtered()', Sys.Date(), '.csv', sep='')
    	},
    	content = function(con) {
    		write.csv(filtered(),con)
    	}
    )
  
    output$BclData <- downloadHandler(
    	  filename = function() {
    	    paste('bcl', Sys.Date(), '.csv', sep='')
    	 },
    	  content = function(con) {
    	    write.csv(bcl, con)
    	 }
    	)
    
}

shinyApp(ui = ui, server = server)
