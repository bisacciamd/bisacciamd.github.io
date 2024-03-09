death <- sum(data$death_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$death_stress_cmr_v2, na.rm = TRUE)
mi_stress <- sum(data$mi_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$mi_stress_cmr_v2, na.rm = TRUE)
vtvf <- sum(data$vt_vf_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$vt_vf_stress_cmr_v2, na.rm = TRUE)
hosp_stress <- sum(data$hospitalization_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$hospitalization_stress_cmr_v2, na.rm = TRUE)
asystole <- sum(data$asystole_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$asystole_stress_cmr_v2, na.rm = TRUE)
sinuspause <- sum(data$sinus_pause_arrest_stress_car, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$sinus_pause_arrest_stress_car_v2, na.rm = TRUE)
av_block <- sum(data$high_grade_av_block_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$high_grade_av_block_stress_cmr_v2, na.rm = TRUE)
afib <- sum(data$af_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$af_stress_cmr_v2, na.rm = TRUE)
chest_pain <- sum(data$chest_pain_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$chest_pain_stress_cmr_v2, na.rm = TRUE)
hypotension <- sum(data$symptomatic_hypotension_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$symptomatic_hypotension_stress_cmr_v2, na.rm = TRUE)
dyspnea <- sum(data$dyspnea_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$dyspnea_stress_cmr_v2, na.rm = TRUE)
nausea <- sum(data$nausea_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$nausea_stress_cmr_v2, na.rm = TRUE)
headache <- sum(data$headache_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$headache_stress_cmr_v2, na.rm = TRUE)
allergic <- sum(data$allergic_reaction_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$allergic_reaction_stress_cmr_v2, na.rm = TRUE)
extravas <- sum(data$contrast_extravasation_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$contrast_extravasation_stress_cmr_v2, na.rm = TRUE)
thrombophleb <- sum(data$thrombophlebitis_stress_cmr, na.rm = TRUE) +
  sum(data[data$stressor_v2==1,]$thrombophlebitis_stress_cmr_v2, na.rm = TRUE)


safety <- data.frame(
  death = death,
  mi_stress = mi_stress,
  vtvf = vtvf,
  hosp_stress = hosp_stress,
  asystole = asystole,
  sinuspause = sinuspause,
  av_block = av_block,
  afib = afib,
  chest_pain = chest_pain,
  hypotension = hypotension,
  dyspnea = dyspnea,
  nausea = nausea,
  headache = headache,
  allergic = allergic,
  extravas = extravas,
  thrombophleb = thrombophleb
)