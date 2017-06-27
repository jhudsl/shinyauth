library(shiny)
library(shinyauth)
library(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
   # Application title
   titlePanel("Let's query fitbit"),
   shinyauthUI("fitbit_login")
)

server <- function(input, output) {
  source("demo/fitbitTest/api_keys.R")

  authButton <- callModule(shinyauth,
                          "fitbit_login",
                          api_url = 'https://www.fitbit.com/oauth2/authorize',
                          key     = api_keys$key,
                          secret  = api_keys$secret,
                          scope   = c("heartrate", "activity", "sleep")
                          )

  # logic for what happens after a user has drawn their values. Note this will fire on editing again too.
  observeEvent(authButton(), {
    userToken = authButton()

    print(userToken)
  })

}

# Run the application
shinyApp(ui = ui, server = server, options = c("port" = 1410))
