studies <- sum(!is.na(data$stressor))+sum(!is.na(data$stressor_v2))-sum(data$stressor==2, na.rm = T)-sum(data$stressor_v2==2, na.rm = T)
safety <- data.frame(
  death = c(death, studies - death),
  mi_stress = c(mi_stress, studies - mi_stress),
  vtvf = c(vtvf, studies - vtvf),
  hosp_stress = c(hosp_stress, studies - hosp_stress),
  asystole = c(asystole, studies - asystole),
  sinuspause = c(sinuspause, studies - sinuspause),
  av_block = c(av_block, studies - av_block),
  afib = c(afib, studies - afib),
  chest_pain = c(chest_pain, studies - chest_pain),
  hypotension = c(hypotension, studies - hypotension),
  dyspnea = c(dyspnea, studies - dyspnea),
  nausea = c(nausea, studies - nausea),
  headache = c(headache, studies - headache),
  allergic = c(allergic, studies - allergic),
  extravas = c(extravas, studies - extravas),
  thrombophleb = c(thrombophleb, studies - thrombophleb)
)

sf <- data.frame(event = character(), est = numeric(), CI = character(), stringsAsFactors = FALSE)

for (col_name in names(safety)) {
  event <- safety[[col_name]]
  result <- epi.conf(as.matrix(cbind(event[1], event[2])), ctype = "inc.risk", method = "wilson")
  
  # Extracting relevant information from the result
  est <- result$est[1]
  lower <- result$lower[1]
  upper <- result$upper[1]
  
  # Creating a new row for the result_df
  new_row <- data.frame(event = col_name, est = est*100, CI = paste0(round(lower*100, digits=1), "–", round(upper*100, digits=1)))
  
  # Binding the new row to the result_df
  sf <- rbind(sf, new_row)
}

sf

1/60+1.96*sqrt(1/60*59/60**3)

epi.conf(c, ctype = "inc.risk", method = "wilson")
  