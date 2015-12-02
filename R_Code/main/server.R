rm(list = ls())
library(audio);
library(seewave);
source("svm.R")
source('Segmentation.R')
source('compute_params.R')

load('svm_machine');


shinyServer(function(input, output) {
    
  probka <- reactive({
      plik <- input$file1
      if (is.null(plik))
         return(NULL)
      load.wave(plik$datapath)
    });
  
  sample <- reactive({
    sample <- input$file1
    if (is.null(sample))
      return(NULL)
  });
  
  Params_matrix <- reactive({
    plik <- input$file1
    if (is.null(plik))
      return(NULL)
    params <- compute_params(plik$datapath)
  })
  
  vector <- reactive({
    params <- Params_matrix()
    vector = matrix(data = 0, nrow = 1, ncol = 28)
    for(i in 1:28){
    vector[i] = mean(params[,i])
    }
    vector = vector
  })
  
  result <- reactive({
#    params <- Params_matrix()
#    vector = matrix(data = 0, nrow = 1, ncol = 28)
#    for(i in 1:28){
#      vector[i] = mean(params[,i])
#    }
    v <- vector()
    result <- predict_class(svm_machine,v)
    result = result
  })
  
  
    output$plot <- renderPlot({
#      s <- load.wave(probka$datapath)
     data <- probka()
     if (is.null(data))
       return(NULL)
     a <- spec(data)
      });
    output$filename <-renderPrint({
 #     input$file1$name
#      Params_matrix()
      print(result() )
  #    vector()
      })
    
    })
