#Remote data fetch 
#remotes::install_github('OuhscBbmc/REDCapR')
library(REDCapR)
api_url <- "https://redcap.synology.me/api/"
token <- "E8065DC34088541188300BACBC7ACDF7"  # Replace with your actual API token
data <- redcap_read(redcap_uri = api_url, token = token)$data # uncomment to wrap