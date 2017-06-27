
makeBodyString <- function(client_id, redirect_uri, code ){
  sprintf("client_id=%s&grant_type=authorization_code&redirect_uri=%s&code=%s",
          client_id, redirect_uri, code)
}

queryBody <- makeBodyString(client_id = "2287QM", redirect_uri = "http://127.0.0.1:1410/", code = "1d815edcb20a2e4bfae9960b3015fb61dfb3928a")
#post test
test <- httr::POST(
  encode = "form",
  url = "https://api.fitbit.com/oauth2/token",
  httr::add_headers(Authorization = paste("Basic", "MjI4N1FNOjZhOTliODBlY2Y4NWNiZTMzZDU5YzE3NGU5Yzc0NzQ4"),
                    "Content-Type" =  "application/x-www-form-urlencoded"),
  body = queryBody,
  verbose()
)

test %>%
  httr::content(as="text")

