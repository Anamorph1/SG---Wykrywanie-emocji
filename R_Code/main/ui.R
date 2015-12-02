# ui.R

shinyUI(fluidPage(
  titlePanel(h1("Rozpoznawanie emocji")),
  
  sidebarLayout(
    sidebarPanel("Wczytaj plik", 
                 
                 fileInput('file1', label = "próbka głosu")),
    mainPanel(
      plotOutput('plot'),
      tags$br(),
      textOutput('filename')
     
      
      )
  )
))