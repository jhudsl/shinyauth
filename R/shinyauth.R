#' Allows the easy retreival of a token for using apis in your shiny apps.
#' @param id the id you will use to keep track of this component in your app
#' @return A button that a used presses to login to your given authentication service.
#' @export
#' @examples
#' shinydrawrUI('myrecorder')
shinyauthUI <- function(id) {
  ns <- NS(id)

  #Grab the external javascript and css
  authrjs <- .get_script("authr.js", "js")
  shinyauthjs <- .get_script("shinyauth.js", "js")

  tagList(
    singleton(
      tags$head( #load external scripts.
        tags$script(HTML(authrjs)),
        tags$script(HTML(shinyauthjs))
      )
    ),
    div(id = ns("authButton"),
        h1("hi")
    )

  ) #end tag list.
}


#' Server side component. You supply this with your api credentials.
#'
#' @param input you can ignore this as it is taken care of by shiny
#' @param output you can ignore this as it is taken care of by shiny
#' @param session you can ignore this as it is taken care of by shiny
#' @param api_url destination of the api you're querying from. For instance the fitbit api is 'https://www.fitbit.com/oauth2/authorize'
#' @param api_key your apps personal api key.
#' @param scope a vector of what you're requesting access to in the API. See the given api docs for examples.
#' @export
#' @examples
#'  drawChart <- callModule(shinydrawr,
#'     "outbreak_stats",
#'     random_data,
#'     draw_start = 15,
#'     x_key = "time",
#'     y_key = "metric")
shinyauth <- function(input, output, session,
                      api_url,
                      api_key,
                      scope){

  #Send over a message to the javascript with the id of the div we're placing this chart in along with the data we're placing in it.
  observe({ session$sendCustomMessage(
    type    = "initialize_button",
    message = list(
      api_url,
      api_key,
      scope)
  )
  })

  # The user's api token in string format.
  result <- reactive({ input$loggedIn })
  return(result)
}
