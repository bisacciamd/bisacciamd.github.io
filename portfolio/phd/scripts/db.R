# Clear existing data and graphics
rm(list = ls())
graphics.off()
# Load Hmisc library
library(Hmisc)
library(lubridate)
# Read Data
wrap <- readLines("scripts/wrap_mode", warn = FALSE)
# to read from terminal: wrap <- readline(prompt = "Offline or online?\nPlease answer either offline or online.") # instructs where to source data

if (wrap == "offline") {
  data <- read.csv("data/latest.csv")
} else if (wrap == "online") {
  source("scripts/datawrap.r") # Uncomment to wrap from redcap
  write.csv(data, file = "data/latest.csv")
} else {
  print("Please specify source (offline or online)", quote = FALSE)
}

data$mace <- as.factor(ifelse(data$death == 1 | data$new_admission_post_cmr == 1,
  1, 0
))
data$mace_date <- ifelse(data$death == 1,
  data$date_death,
  ifelse(data$new_admission_post_cmr == 1,
    data$new_admission_post_cmr_date,
    "2023-06-30"
  )
)
data$mace_date
data$mace_time <- difftime(
  as_date(data$mace_date),
  as_date(data$date_cmr)
)
data$death_fup <- ifelse(data$death == 1, data$death_fup, difftime(
  as_date(data$date_death),
  as_date(data$date_cmr)
))
