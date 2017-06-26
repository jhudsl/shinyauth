#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyauth)

# Define UI for application that draws a histogram
ui <- fluidPage(

   # Application title
   titlePanel("Let's query fitbit"),
   shinyauthUI("fitbit_login")
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  #server side call of the drawr module
  authButton <- callModule(shinyauth,
                          "fitbit_login",
                          api_url = 'https://www.fitbit.com/oauth2/authorize',
                          api_key =  "2287QM",
                          scope = c("heartrate", "activity", "sleep"))

  #logic for what happens after a user has drawn their values. Note this will fire on editing again too.
  observeEvent(authButton(), {
    userToken = authButton()

    print(userToken)
  })

}

# Run the application
shinyApp(ui = ui, server = server)
