#' Performs a post request to retreive a user's token.
#' @param auth_code User's previously retreived authorization code.
#' @param redirect_uri your apps redirect URL (aka where you app lives on the internet or localhost)
#' @param key Your apps api key.
#' @param token_url the token retreival address for your api.
#' @param key_secret_code a base 64 mashup of the key and secret. Taken care of by the package
#' @return A list with the response of the token post request. If no erorr will contain the access_token.
#' @export
#' @examples
#' token_request <- getToken(
#'   auth_code = "sdfaf43qgasgadsfadsfadsfadsf",
#'   redirect_uri = "http://127.0.0.1:1410/",
#'   key = api_keys$key,
#'   token_url = api_keys$token_url)
getToken <- function(auth_code, redirect_uri, key, token_url, key_secret_code){
  queryBody <- makeBodyString(key, redirect_uri, auth_code)

  httr::POST(
    encode = "form",
    url = token_url,
    httr::add_headers(Authorization = paste("Basic", key_secret_code),
                      "Content-Type" =  "application/x-www-form-urlencoded"),
    body = queryBody
    # ,
    # verbose()
  ) %>%
    httr::content(as="text") %>%
    jsonlite::fromJSON()
}

