# Remote data fetch
# remotes::install_github('OuhscBbmc/REDCapR')
library(REDCapR)
api_url <- readLines("redcap_api_url.secret")
token <- readLines("redcap_token.secret")
data <- redcap_read(redcap_uri = api_url, token = token)$data # uncomment to wrap
