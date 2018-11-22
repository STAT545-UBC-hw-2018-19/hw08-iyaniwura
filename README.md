# Homework 08: Making a shiny app

This repsoitory contains the files used in homework 8. In this homework, we learn how to develop  a shiny app in R, and deploy it online. The app modified in this exercise uses [BC liquor data](https://github.com/STAT545-UBC-students/hw08-seed). This app dispalys a barchart showing the distribution of prices, and a table with information about a selected  drink in a selected country as available in the data set. 



Below are some of the functions that can be performed with the downloaded app (before I modified it):

1. There is a `sliderbar()` that allows you to select a range of price you will like to consider
2. `Radiobutton`   allows on to select the type of drink to be considered
3. The app produces a barchart that displays the distribution of prices and a table of data based on the price selection and the drink type

Here are a few things I have added to the app:

1. A `checkboxInput()` is used to specify whether the price should be sorted in ascending order or not
2. I have also uploaded some BC liquor images on the app
3. Use `DT` package to make an interactive table
4. Use `shinyjs::colourInput()` to create interactive colour selection for the barchart
5. Use `tabsetPanel()` to create an interface for each of the information displayed on the app
6. Use `textOutput()` to dispaly the number of results found with respect to the selections made
7. Included a `downloadButton()` that allows  the user to download the result
8. Indluded a `downloadLink()` that enables the user to download the entire data set

Please click [here](https://iyaniwura.shinyapps.io/bcl-stat/) for the online version of the app.

Acknowledgement:

The original code and data are from [Dean Attali's tutorial](https://deanattali.com/blog/building-shiny-apps-tutorial). The code can specifically be found [here](https://deanattali.com/blog/building-shiny-apps-tutorial/#12-final-shiny-app-code).

