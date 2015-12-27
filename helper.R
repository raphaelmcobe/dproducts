
library(dplyr)
library(rCharts)

plotTotalMovies <- function(imdb, minDate, maxDate, selectedGender){
    imdb <- filterByGender(selectedGender,imdb)
    selectedDataset <- aggregate(imdb$Count, by = list(year = imdb$year), FUN = sum)
    filteredData <- filter(selectedDataset, year > minDate & year < maxDate)
    plot <- nPlot(x ~ year, data = filteredData, type = "multiBarChart", width=480)
    plot$yAxis(axisLabel = "Total")
    plot$xAxis(axisLabel = "Year")
    plot$addParams(dom = "moviesByYear")
    return(plot)
}

plotTotalBudget <- function(imdb, minDate, maxDate, selectedGender){
    imdb <- filterByGender(selectedGender,imdb)
    imdb$budget <- as.numeric(imdb$budget)
    selectedDataset <- aggregate(imdb$budget, by = list(year = imdb$year), FUN = sum, na.rm=T)
    filteredData <- filter(selectedDataset, year > minDate & year < maxDate)
    plot <- nPlot(x ~ year, data = filteredData, type = "multiBarChart", width=480)
    plot$yAxis(axisLabel = "Total")
    plot$xAxis(axisLabel = "Budget")
    plot$addParams(dom = "budgetByYear")
    return(plot)
}

filterByGender <- function(genderList, imdb){
    if(is.null(genderList))
        return(imdb)
    expression <- ""
    for(i in genderList){
        if(expression!=""){
            expression <- paste(expression, "&")
        }
        expression <- paste(expression, i)
        expression <- paste(expression, "== 1")
    }
    return(subset(imdb,eval(parse(text=expression))))

}


plotRatingComparison <- function(imdb, minDate, maxDate, selectedGender){
    imdb <- filterByGender(selectedGender,imdb)
    imdb$budget <- as.numeric(imdb$budget)
    imdb$rating <- as.numeric(imdb$rating)
    selectedDataset <- aggregate(imdb$budget, by = list(year = imdb$year), FUN = mean, na.rm=T)
    selectedDatasetRating <- aggregate(imdb$rating, by = list(year = imdb$year), FUN = mean, na.rm=T)
    selectedDataset$rating <- selectedDatasetRating$x
    filteredData <- filter(selectedDataset, year > minDate & year < maxDate)

    h <- Highcharts$new()
    h$xAxis(categories = filteredData$year, tickInterval=5, width=480)
    h$yAxis(list(list(title = list(text = 'Budget'))
                 , list(title = list(text = 'Ratings'), opposite = TRUE))
    )
    h$series(name = 'Budget', type = 'spline', color = '#4572A7',
             data = filteredData$x)
    h$series(name = 'Ratings', type = 'spline', color = '#89A54E',
             data = filteredData$rating,
             yAxis = 1)
    return(h)
}
































