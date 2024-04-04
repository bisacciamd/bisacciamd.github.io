library(lubridate)
library(dplyr)
library(Hmisc)
library(tidyr)
data_stress <- data[!is.na(data$stressor), ]

data_stress$age <- as.numeric(difftime(time2=as_date(data_stress$date_of_birth), 
                            time1=as_date(data_stress$stress_cmr_index_date))/365)
data_stress$ckd <- ifelse(is.na(data_stress$ckd),0,data_stress$ckd)
data_stress$cause_2.factor <- replace_na(data_stress$cause_2.factor,replace = "Not specified")
#correcting for bad prognosis assessment

data_stress <- data_stress[data_stress$stressor==1, ]
data_stress$new_admission_post_cmr[1] <- 0
data_stress$new_admission_post_cmr[4] <- 0
data_stress$new_admission_post_cmr[18] <- 0
data_stress$new_admission_post_cmr[34] <- 0
data_stress$new_admission_post_cmr[58] <- 0
events <- data_stress[data_stress$new_admission_post_cmr==1, ]$new_admission_post_cmr_text %>% na.omit()

data_stress$mace <- as.factor(ifelse(data_stress$death==1 | data_stress$new_admission_post_cmr==1,
                              1, 0)
)
data_stress$mace_date <- ifelse(data_stress$death==1, 
                         data_stress$date_death, 
                         ifelse(data_stress$new_admission_post_cmr==1, 
                                data_stress$new_admission_post_cmr_date, 
                                "2023-06-30"))
stress <- data.frame(
  age=data_stress$age,
  bsa=data_stress$bsa,
  weight=data_stress$weight,
  dsa=as.factor(ifelse(data_stress$hla_ab_stress==0, 
             yes = "Negative", 
             no = ifelse(data_stress$dsa_stress==1, 
                         "DSA", 
                         "Non-DSA"))),
  dsa_fup=as.factor(ifelse(data_stress$hla_ab_latest==0, 
                       yes = "Negative", 
                       no = ifelse(data_stress$dsa_latest==1, 
                                   "DSA", 
                                   "Non-DSA"))),
  gender=as.factor(data_stress$gender),
  ado_dose=data_stress$adenosine_dose,
  stressor=data_stress$stressor,
  lvef=data_stress$lvef_cmr,
  gls=data_stress$global_peak_strain_longitudinal,
  peaksbp=data_stress$peak_stress_sbp,
  peakhr=data_stress$peak_hr,
  resthr=data_stress$pre_stress_hr_car,
  hr_delta=data_stress$peak_hr-data_stress$pre_stress_hr_car,
  dbp_delta=data_stress$peak_stress_dbp-data_stress$pre_stress_dbp,
  sbp_delta=data_stress$peak_stress_sbp-data_stress$pre_stress_sbp,
  mbf=data_stress$mbf_stress_cmr,
  mpr=data_stress$mpr_stress_cmr,
  nosymptom=data_stress$stress_symptoms___1,
  symptomtype=as.factor(ifelse(
    data_stress$stress_symptoms___1 == 1, "No symptoms",
    ifelse(data_stress$stress_symptoms___2 == 1 | data_stress$stress_symptoms___4 == 1,
           "Chest pain",
           ifelse(data_stress$stress_symptoms___3 == 1, "SoB",
                  ifelse(data_stress$stress_symptoms___5 == 1, "Hot flush", NA))
    ))),
  time_from_tx=difftime(time2 = data_stress$tx_date,
                        time1 = data_stress$date_cmr),
  rejection=as.factor(data_stress$rejection),
  ischemia=data_stress$qualitative_perfusion_defect_stress_cmr,
  ischemic_burden=(data_stress$perfusion_defect_segments_stress_cmr___1	+
                     data_stress$perfusion_defect_segments_stress_cmr___2	+
                     data_stress$perfusion_defect_segments_stress_cmr___3	+
                     data_stress$perfusion_defect_segments_stress_cmr___4	+
                     data_stress$perfusion_defect_segments_stress_cmr___5	+
                     data_stress$perfusion_defect_segments_stress_cmr___6	+
                     data_stress$perfusion_defect_segments_stress_cmr___7	+
                     data_stress$perfusion_defect_segments_stress_cmr___8	+
                     data_stress$perfusion_defect_segments_stress_cmr___9	+
                     data_stress$perfusion_defect_segments_stress_cmr___10	+
                     data_stress$perfusion_defect_segments_stress_cmr___11	+
                     data_stress$perfusion_defect_segments_stress_cmr___12	+
                     data_stress$perfusion_defect_segments_stress_cmr___13	+
                     data_stress$perfusion_defect_segments_stress_cmr___14	+
                     data_stress$perfusion_defect_segments_stress_cmr___15	+
                     data_stress$perfusion_defect_segments_stress_cmr___16	+
                     data_stress$perfusion_defect_segments_stress_cmr___17	)/17*100,
  cav_angio=data_stress$cav_angio_grade,
  cav_ctca=data_stress$cav_ctca_grade,
  death=data_stress$death,
  hosp=data_stress$new_admission_post_cmr
)


stress$mace <- data_stress$mace
stress$mace_time <- data_stress$mace_time/365

cav_angio_date <- data_stress$angio_date
cav_ctca_date <- data_stress$ctca_date
cav_date <- ifelse(!is.na(cav_angio_date),
                   yes = cav_angio_date, 
                   no = cav_ctca_date) %>% as_date()

stress$time_cav_cmr <- difftime(time2 = cav_date,
                                time1 = data_stress$date_cmr)
stress$time_angio_tx <- as.numeric(difftime(time1 = cav_date,
                                time2 = data_stress$tx_date))
stress$tx_old <- stress$time_from_tx>600

label(stress$tx_old) <- "Graft > 600 days old"
data_stress$rpp <- data_stress$peak_hr*data_stress$peak_stress_sbp

stress$rpp <- stress$resthr*(stress$peaksbp-stress$sbp_delta)
stress$srpp <- stress$peakhr*stress$peaksbp
label(stress$rpp) <- "Rest Rate-pressure product"
#label(stress$srpp) <- "Stress Rate-pressure product"
stress$mbf <- ifelse(is.na(stress$mbf), yes = data_stress$mbf_stress_cmr_v2, no = stress$mbf)
stress$mpr <- ifelse(is.na(stress$mpr), yes = data_stress$mpr_stress_cmr_v2, no = stress$mpr)

stress$mbfi <- stress$mbf#/stress$srpp*10000
stress$mpri <- stress$mpr/stress$rpp*10000
data_stress$mbfi <- stress$mbfi
data_stress$mpri <- stress$mpri
stress$rmbf <- stress$mbf/stress$mpr
stress$rmbfi <- stress$rmbf/stress$rpp*10000
stress$mpri <- stress$mbfi/stress$rmbfi

label(stress$rmbfi) <- "Rest Myocardial Blood Flow Index"
label(stress$mpri) <- "Stress Myocardial Perfusion Reserve Index"
label(stress$mbfi) <- "Stress Myocardial Blood Flow"
label(stress$ischemic_burden) <- "Ischemic burden"
label(stress$ischemia) <- "Presence of inducible myocardial ischemia"
label(stress$rejection) <- "Presence of rejection"
label(stress$hr_delta) <- "Change in HR (bpm)"
label(stress$dbp_delta) <- "Change in diastolic BP (mmHg)"
label(stress$sbp_delta) <- "Change in systolic BP (mmHg)"
label(stress$mace) <- "Major adverse CV events at follow-up"

stress$time_from_tx <- as.numeric(stress$time_from_tx)
#stress$record_id <- data_stress$record_id

data_stress$cav_composite <- ifelse(test = is.na(data_stress$cav_angio_grade), 
                             yes = data_stress$cav_ctca_grade, no = data_stress$cav_angio_grade
)
stress$time_from_tx <- stress$time_from_tx/365

label(stress$time_from_tx) <- "Time from transplantation to CMR (years)"

stress$cav=as.factor(data_stress$cav_composite #data_stress$cav_angio_grade
)

stress$ptt_centroid <- data_stress$ptt_centroid_stress_cmr
stress$ptt_ptp <- data_stress$ptt_pap_stress_cmr

stress$cav_grade <- stress$cav

levels(stress$cav) <- c("CAV grade ≤ 2", "CAV grade ≤ 2", "CAV grade > 2", "CAV grade > 2")
data_stress$cav <- stress$cav
data_stress$mbfi <- data_stress$mbf_stress_cmr/stress$rpp*10000
label(data_stress$mbfi) <- "Stress Myocardial Blood Flow Index"

#library(writexl); write_xlsx(data_stress,path = "data/latest_stress.xlsx")

rm(cav_angio_date)
rm(cav_ctca_date)
rm(cav_date)

data_stress$stress_cmr_index_date <- as_date(data_stress$stress_cmr_index_date)
data_stress$hla_ab_stress_date <- as_date(data_stress$hla_ab_stress_date)
data_stress$hla_ab_latest_date <- as_date(data_stress$hla_ab_latest_date)
data_stress$dsa_to_cmr <- difftime(data_stress$hla_ab_stress_date, data_stress$stress_cmr_index_date,units = "days")
data_stress$dsa_to_cmr <- abs(data_stress$dsa_to_cmr)
levels(stress$dsa) <- c("DSA+", "DSA-", "DSA-")
label(stress$dsa) <- "Donor-specific Ab"
levels(stress$dsa_fup) <- c("DSA+", "DSA-", "DSA-")
label(stress$dsa_fup) <- "Donor-specific Ab at follow-up"
label(stress$age) <- "Age"
label(stress$gender) <- "Sex"
label(stress$symptomtype) <- "Symptoms during stress"
label(data_stress$ckd) <- label(data$ckd)

#write_xlsx(data_stress, path="data_stress.xlsx")
stress$time_cav_cmr <- stress$time_cav_cmr/365.25


stress$time_angio_tx <- stress$time_angio_tx/365.25

stress <- upData(stress,
                 units=c(time_cav_cmr='years',
                         time_angio_tx='years',
                         time_from_tx='years'))



