library(shiny)
library(rCharts)

require(markdown)

shinyUI(
    navbarPage("IMDB app",
        tabPanel("Plot",
            sidebarPanel(
                sliderInput("year", "Year:", min = 1900, max = 2005,
                            value = c(1900, 2005), format="####"),
                uiOutput("genders")
            ),
            mainPanel(
                tabsetPanel(
                    tabPanel(p(icon("line-chart"), "By Year"),
                        h4('Number of Movies by year', align = "center"),
                        showOutput("moviesByYear", "nvd3")
                    ),
                    tabPanel(p(icon("line-chart"), "By budget"),
                        h4('Film cost by year', align = "center"),
                        showOutput("budgetByYear", "nvd3")
                    ),
                    tabPanel(p(icon("line-chart"), "Comparisons"),
                             h4('Film cost by year', align = "center"),
                             showOutput("ratingComparison", "highcharts")
                     )
                )
            )
        ),
        tabPanel("About",
            mainPanel(
                includeMarkdown("about.md")
            )
        )
    )
)