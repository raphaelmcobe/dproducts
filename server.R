library(shiny)

library(ggplot2)

source("helper.R", local = TRUE)

imdb <- read.csv("movies.csv")

imdb$Count <- 1

genders <- sort(names(imdb)[19:25])

shinyServer(function(input, output, session) {

    values <- reactiveValues(genders = c())

    output$genders <- renderUI({
        checkboxGroupInput('genders', 'Filter By Gender', choices = genders, selected = values$genders)
    })

    output$moviesByYear <- renderChart({
        plotTotalMovies(imdb,input$year[1], input$year[2], input$genders)
    })

    output$budgetByYear <- renderChart({
        plotTotalBudget(imdb,input$year[1], input$year[2], input$genders)
    })

    output$ratingComparison <- renderChart2({
        plotRatingComparison(imdb,input$year[1], input$year[2], input$genders)
    })

})