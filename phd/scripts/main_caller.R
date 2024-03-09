rm(list=ls())
options(digits  = 3)

library(survival)
library(gtsummary)
library(dplyr)
library(knitr)
library(DescTools)

source("phd/scripts/db.r")
source("phd/scripts/stressDB.r")
source("phd/scripts/angio.r")
source("phd/scripts/safety.r")
#Setting Labels

label(data$record_id) <- "Record ID"
label(data$nhs_number) <- "Patient ID (NHS)"
label(data$date_of_birth) <- "Date of Birth"
label(data$age) <- "Age"
label(data$gender) <- "Gender"
label(data$height) <- "Height (cm)"
label(data$weight) <- "Weight (Kg)"
label(data$bmi) <- "BMI"
label(data$bsa) <- "BSA"
label(data$patient_data_complete) <- "Complete?"
label(data$stressor) <- "Stressor"
label(data$adenosine_dose) <- "Adenosine Dosage"
label(data$pre_stress_hr_car) <- "Pre-stress HR (bpm)"
label(data$pre_stress_sbp) <- "Pre-stress systolic BP (mmHg)"
label(data$pre_stress_dbp) <- "Pre-stress diastolic BP (mmHg)"
label(data$peak_hr) <- "Peak HR (bpm)"
label(data$peak_stress_sbp) <- "Peak systolic BP (mmHg)"
label(data$peak_stress_dbp) <- "Peak diastolic BP (mmHg)"
label(data$stress_symptoms___1) <- "Symptoms (choice <- no symptoms)"
label(data$stress_symptoms___2) <- "Symptoms (choice <- chest pain)"
label(data$stress_symptoms___3) <- "Symptoms (choice <- shortness of breath)"
label(data$stress_symptoms___4) <- "Symptoms (choice <- chest tightness)"
label(data$stress_symptoms___5) <- "Symptoms (choice <- hot flush)"
label(data$qualitative_perfusion_defect_stress_cmr) <- "Qualitative Perfusion Defect"
label(data$perfusion_defect_segments_stress_cmr___1) <- "Perfusion defect segments (choice <- basal anterior)"
label(data$perfusion_defect_segments_stress_cmr___2) <- "Perfusion defect segments (choice <- basal anteroseptal)"
label(data$perfusion_defect_segments_stress_cmr___3) <- "Perfusion defect segments (choice <- basal inferoseptal)"
label(data$perfusion_defect_segments_stress_cmr___4) <- "Perfusion defect segments (choice <- basal inferior)"
label(data$perfusion_defect_segments_stress_cmr___5) <- "Perfusion defect segments (choice <- basal inferolateral)"
label(data$perfusion_defect_segments_stress_cmr___6) <- "Perfusion defect segments (choice <- basal anterolateral)"
label(data$perfusion_defect_segments_stress_cmr___7) <- "Perfusion defect segments (choice <- mid anterior)"
label(data$perfusion_defect_segments_stress_cmr___8) <- "Perfusion defect segments (choice <- mid anteroseptal)"
label(data$perfusion_defect_segments_stress_cmr___9) <- "Perfusion defect segments (choice <- mid inferoseptal)"
label(data$perfusion_defect_segments_stress_cmr___10) <- "Perfusion defect segments (choice <- mid inferior)"
label(data$perfusion_defect_segments_stress_cmr___11) <- "Perfusion defect segments (choice <- mid inferolateral)"
label(data$perfusion_defect_segments_stress_cmr___12) <- "Perfusion defect segments (choice <- mid anterolateral)"
label(data$perfusion_defect_segments_stress_cmr___13) <- "Perfusion defect segments (choice <- apical anterior)"
label(data$perfusion_defect_segments_stress_cmr___14) <- "Perfusion defect segments (choice <- apical septal)"
label(data$perfusion_defect_segments_stress_cmr___15) <- "Perfusion defect segments (choice <- apical inferior)"
label(data$perfusion_defect_segments_stress_cmr___16) <- "Perfusion defect segments (choice <- apical lateral)"
label(data$perfusion_defect_segments_stress_cmr___17) <- "Perfusion defect segments (choice <- apex)"
label(data$mbf_stress_cmr) <- "Stress Myocardial Blood Flow (ml/g*min)"
label(data$ptt_pap_stress_cmr) <- "Stress Pulmonary Transit Time peak to peak"
label(data$ptt_centroid_stress_cmr) <- "Stress Pulmonary Transit Time Centroid"
label(data$mpr_stress_cmr) <- "Myocardial Perfusion Reserve"
label(data$death_stress_cmr) <- "Death"
label(data$asystole_stress_cmr) <- "Asystole"
label(data$sinus_pause_arrest_stress_car) <- "Sinus pause or arrest"
label(data$high_grade_av_block_stress_cmr) <- "High-grade atrioventricular block"
label(data$vt_vf_stress_cmr) <- "Ventricular tachycardia or ventricular fibrillation"
label(data$af_stress_cmr) <- "Atrial fibrillation"
label(data$chest_pain_stress_cmr) <- "Chest pain requiring sublingual nitroglycerin"
label(data$mi_stress_cmr) <- "Myocardial infarction"
label(data$symptomatic_hypotension_stress_cmr) <- "Symptomatic hypotension"
label(data$dyspnea_stress_cmr) <- "Dyspnea"
label(data$nausea_stress_cmr) <- "Nausea"
label(data$headache_stress_cmr) <- "Headache"
label(data$allergic_reaction_stress_cmr) <- "Allergic reaction (rash, hives, etc.)"
label(data$contrast_extravasation_stress_cmr) <- "Contrast extravasation"
label(data$thrombophlebitis_stress_cmr) <- "Thrombophlebitis"
label(data$hospitalization_stress_cmr) <- "Subsequent Related Hospitalization"
label(data$any_adverse_effect_stress) <- "Any adverse effect during Stress CMR"
label(data$stress_cmr_complete) <- "Complete?"
label(data$procedure_name) <- "Procedure Name"
label(data$date_cmr) <- "Date of baseline CMR exam"
label(data$second_cmr) <- "Second CMR"
label(data$second_cmr_date) <- "Second CMR Date"
label(data$third_cmr) <- "Third CMR"
label(data$third_cmr_date) <- "Third CMR Date"
label(data$akinesia_cmr) <- "Akinesia"
label(data$akinesia_seg_cmr___1) <- "Akinesia Segments (choice <- basal anterior)"
label(data$akinesia_seg_cmr___2) <- "Akinesia Segments (choice <- basal anteroseptal)"
label(data$akinesia_seg_cmr___3) <- "Akinesia Segments (choice <- basal inferoseptal)"
label(data$akinesia_seg_cmr___4) <- "Akinesia Segments (choice <- basal inferior)"
label(data$akinesia_seg_cmr___5) <- "Akinesia Segments (choice <- basal inferolateral)"
label(data$akinesia_seg_cmr___6) <- "Akinesia Segments (choice <- basal anterolateral)"
label(data$akinesia_seg_cmr___7) <- "Akinesia Segments (choice <- mid anterior)"
label(data$akinesia_seg_cmr___8) <- "Akinesia Segments (choice <- mid anteroseptal)"
label(data$akinesia_seg_cmr___9) <- "Akinesia Segments (choice <- mid inferoseptal)"
label(data$akinesia_seg_cmr___10) <- "Akinesia Segments (choice <- mid inferior)"
label(data$akinesia_seg_cmr___11) <- "Akinesia Segments (choice <- mid inferolateral)"
label(data$akinesia_seg_cmr___12) <- "Akinesia Segments (choice <- mid anterolateral)"
label(data$akinesia_seg_cmr___13) <- "Akinesia Segments (choice <- apical anterior)"
label(data$akinesia_seg_cmr___14) <- "Akinesia Segments (choice <- apical septal)"
label(data$akinesia_seg_cmr___15) <- "Akinesia Segments (choice <- apical inferior)"
label(data$akinesia_seg_cmr___16) <- "Akinesia Segments (choice <- apical lateral)"
label(data$akinesia_seg_cmr___17) <- "Akinesia Segments (choice <- apex)"
label(data$hypokinesia_cmr) <- "Hypokinesia"
label(data$hypokinesia_seg_cmr___1) <- "Hypokinesia Segments (choice <- basal anterior)"
label(data$hypokinesia_seg_cmr___2) <- "Hypokinesia Segments (choice <- basal anteroseptal)"
label(data$hypokinesia_seg_cmr___3) <- "Hypokinesia Segments (choice <- basal inferoseptal)"
label(data$hypokinesia_seg_cmr___4) <- "Hypokinesia Segments (choice <- basal inferior)"
label(data$hypokinesia_seg_cmr___5) <- "Hypokinesia Segments (choice <- basal inferolateral)"
label(data$hypokinesia_seg_cmr___6) <- "Hypokinesia Segments (choice <- basal anterolateral)"
label(data$hypokinesia_seg_cmr___7) <- "Hypokinesia Segments (choice <- mid anterior)"
label(data$hypokinesia_seg_cmr___8) <- "Hypokinesia Segments (choice <- mid anteroseptal)"
label(data$hypokinesia_seg_cmr___9) <- "Hypokinesia Segments (choice <- mid inferoseptal)"
label(data$hypokinesia_seg_cmr___10) <- "Hypokinesia Segments (choice <- mid inferior)"
label(data$hypokinesia_seg_cmr___11) <- "Hypokinesia Segments (choice <- mid inferolateral)"
label(data$hypokinesia_seg_cmr___12) <- "Hypokinesia Segments (choice <- mid anterolateral)"
label(data$hypokinesia_seg_cmr___13) <- "Hypokinesia Segments (choice <- apical anterior)"
label(data$hypokinesia_seg_cmr___14) <- "Hypokinesia Segments (choice <- apical septal)"
label(data$hypokinesia_seg_cmr___15) <- "Hypokinesia Segments (choice <- apical inferior)"
label(data$hypokinesia_seg_cmr___16) <- "Hypokinesia Segments (choice <- apical lateral)"
label(data$hypokinesia_seg_cmr___17) <- "Hypokinesia Segments (choice <- apex)"
label(data$dyskinesia_cmr) <- "Dyskinesia"
label(data$dyskinesia_seg_cmr___1) <- "Dyskinesia Segments (choice <- basal anterior)"
label(data$dyskinesia_seg_cmr___2) <- "Dyskinesia Segments (choice <- basal anteroseptal)"
label(data$dyskinesia_seg_cmr___3) <- "Dyskinesia Segments (choice <- basal inferoseptal)"
label(data$dyskinesia_seg_cmr___4) <- "Dyskinesia Segments (choice <- basal inferior)"
label(data$dyskinesia_seg_cmr___5) <- "Dyskinesia Segments (choice <- basal inferolateral)"
label(data$dyskinesia_seg_cmr___6) <- "Dyskinesia Segments (choice <- basal anterolateral)"
label(data$dyskinesia_seg_cmr___7) <- "Dyskinesia Segments (choice <- mid anterior)"
label(data$dyskinesia_seg_cmr___8) <- "Dyskinesia Segments (choice <- mid anteroseptal)"
label(data$dyskinesia_seg_cmr___9) <- "Dyskinesia Segments (choice <- mid inferoseptal)"
label(data$dyskinesia_seg_cmr___10) <- "Dyskinesia Segments (choice <- mid inferior)"
label(data$dyskinesia_seg_cmr___11) <- "Dyskinesia Segments (choice <- mid inferolateral)"
label(data$dyskinesia_seg_cmr___12) <- "Dyskinesia Segments (choice <- mid anterolateral)"
label(data$dyskinesia_seg_cmr___13) <- "Dyskinesia Segments (choice <- apical anterior)"
label(data$dyskinesia_seg_cmr___14) <- "Dyskinesia Segments (choice <- apical septal)"
label(data$dyskinesia_seg_cmr___15) <- "Dyskinesia Segments (choice <- apical inferior)"
label(data$dyskinesia_seg_cmr___16) <- "Dyskinesia Segments (choice <- apical lateral)"
label(data$dyskinesia_seg_cmr___17) <- "Dyskinesia Segments (choice <- apex)"
label(data$aneurysm_cmr) <- "Aneurysm"
label(data$aneurysm_seg_cmr___1) <- "Aneurysm Segments (choice <- basal anterior)"
label(data$aneurysm_seg_cmr___2) <- "Aneurysm Segments (choice <- basal anteroseptal)"
label(data$aneurysm_seg_cmr___3) <- "Aneurysm Segments (choice <- basal inferoseptal)"
label(data$aneurysm_seg_cmr___4) <- "Aneurysm Segments (choice <- basal inferior)"
label(data$aneurysm_seg_cmr___5) <- "Aneurysm Segments (choice <- basal inferolateral)"
label(data$aneurysm_seg_cmr___6) <- "Aneurysm Segments (choice <- basal anterolateral)"
label(data$aneurysm_seg_cmr___7) <- "Aneurysm Segments (choice <- mid anterior)"
label(data$aneurysm_seg_cmr___8) <- "Aneurysm Segments (choice <- mid anteroseptal)"
label(data$aneurysm_seg_cmr___9) <- "Aneurysm Segments (choice <- mid inferoseptal)"
label(data$aneurysm_seg_cmr___10) <- "Aneurysm Segments (choice <- mid inferior)"
label(data$aneurysm_seg_cmr___11) <- "Aneurysm Segments (choice <- mid inferolateral)"
label(data$aneurysm_seg_cmr___12) <- "Aneurysm Segments (choice <- mid anterolateral)"
label(data$aneurysm_seg_cmr___13) <- "Aneurysm Segments (choice <- apical anterior)"
label(data$aneurysm_seg_cmr___14) <- "Aneurysm Segments (choice <- apical septal)"
label(data$aneurysm_seg_cmr___15) <- "Aneurysm Segments (choice <- apical inferior)"
label(data$aneurysm_seg_cmr___16) <- "Aneurysm Segments (choice <- apical lateral)"
label(data$aneurysm_seg_cmr___17) <- "Aneurysm Segments (choice <- apex)"
label(data$wmsi_cmr) <- "WMSi"
label(data$thrombus_cmr) <- "LV thrombus "
label(data$thrombus_dim_cmr) <- "Thrombus max dimensions"
label(data$thrombus_text_cmr) <- "Thrombus free text"
label(data$rvwma_cmr) <- "RV regional wall motion abnormalities "
label(data$rvwma1___2) <- "1 basal anterior free wall (choice <- hypokinetic)"
label(data$rvwma1___3) <- "1 basal anterior free wall (choice <- akinetic)"
label(data$rvwma1___4) <- "1 basal anterior free wall (choice <- dyskinetic)"
label(data$rvwma2___2) <- "2 basal lateral free wall (choice <- hypokinetic)"
label(data$rvwma2___3) <- "2 basal lateral free wall (choice <- akinetic)"
label(data$rvwma2___4) <- "2 basal lateral free wall (choice <- dyskinetic)"
label(data$rvwma3___2) <- "3 basal inferior wall (choice <- hypokinetic)"
label(data$rvwma3___3) <- "3 basal inferior wall (choice <- akinetic)"
label(data$rvwma3___4) <- "3 basal inferior wall (choice <- dyskinetic)"
label(data$rvwma4___2) <- "4 mid anterior free wall (choice <- hypokinetic)"
label(data$rvwma4___3) <- "4 mid anterior free wall (choice <- akinetic)"
label(data$rvwma4___4) <- "4 mid anterior free wall (choice <- dyskinetic)"
label(data$rvwma5___2) <- "5 mid lateral free wall (choice <- hypokinetic)"
label(data$rvwma5___3) <- "5 mid lateral free wall (choice <- akinetic)"
label(data$rvwma5___4) <- "5 mid lateral free wall (choice <- dyskinetic)"
label(data$rvwma6___2) <- "6 mid inferior wall (choice <- hypokinetic)"
label(data$rvwma6___3) <- "6 mid inferior wall (choice <- akinetic)"
label(data$rvwma6___4) <- "6 mid inferior wall (choice <- dyskinetic)"
label(data$rvwma7___2) <- "7 apex (choice <- hypokinetic)"
label(data$rvwma7___3) <- "7 apex (choice <- akinetic)"
label(data$rvwma7___4) <- "7 apex (choice <- dyskinetic)"
label(data$rvwma8___2) <- "8 RVOT (choice <- hypokinetic)"
label(data$rvwma8___3) <- "8 RVOT (choice <- akinetic)"
label(data$rvwma8___4) <- "8 RVOT (choice <- dyskinetic)"
label(data$lge_cmr) <- "LGE presence "
label(data$lge1___1) <- " basal anterior (choice <- Sub-endo)"
label(data$lge1___2) <- " basal anterior (choice <- Mid-wall)"
label(data$lge1___3) <- " basal anterior (choice <- Sub-epi)"
label(data$lge1___4) <- " basal anterior (choice <- Transmural)"
label(data$lge1___5) <- " basal anterior (choice <- Mild enhancent)"
label(data$lge2___1) <- " basal anteroseptal (choice <- Sub-endo)"
label(data$lge2___2) <- " basal anteroseptal (choice <- Mid-wall)"
label(data$lge2___3) <- " basal anteroseptal (choice <- Sub-epi)"
label(data$lge2___4) <- " basal anteroseptal (choice <- Transmural)"
label(data$lge2___5) <- " basal anteroseptal (choice <- Mild enhancent)"
label(data$lge3___1) <- " basal inferoseptal (choice <- Sub-endo)"
label(data$lge3___2) <- " basal inferoseptal (choice <- Mid-wall)"
label(data$lge3___3) <- " basal inferoseptal (choice <- Sub-epi)"
label(data$lge3___4) <- " basal inferoseptal (choice <- Transmural)"
label(data$lge3___5) <- " basal inferoseptal (choice <- Mild enhancent)"
label(data$lge4___1) <- " basal inferior (choice <- Sub-endo)"
label(data$lge4___2) <- " basal inferior (choice <- Mid-wall)"
label(data$lge4___3) <- " basal inferior (choice <- Sub-epi)"
label(data$lge4___4) <- " basal inferior (choice <- Transmural)"
label(data$lge4___5) <- " basal inferior (choice <- Mild enhancent)"
label(data$lge5___1) <- " basal inferolateral (choice <- Sub-endo)"
label(data$lge5___2) <- " basal inferolateral (choice <- Mid-wall)"
label(data$lge5___3) <- " basal inferolateral (choice <- Sub-epi)"
label(data$lge5___4) <- " basal inferolateral (choice <- Transmural)"
label(data$lge5___5) <- " basal inferolateral (choice <- Mild enhancent)"
label(data$lge6___1) <- " basal anterolateral (choice <- Sub-endo)"
label(data$lge6___2) <- " basal anterolateral (choice <- Mid-wall)"
label(data$lge6___3) <- " basal anterolateral (choice <- Sub-epi)"
label(data$lge6___4) <- " basal anterolateral (choice <- Transmural)"
label(data$lge6___5) <- " basal anterolateral (choice <- Mild enhancent)"
label(data$lge7___1) <- " mid anterior (choice <- Sub-endo)"
label(data$lge7___2) <- " mid anterior (choice <- Mid-wall)"
label(data$lge7___3) <- " mid anterior (choice <- Sub-epi)"
label(data$lge7___4) <- " mid anterior (choice <- Transmural)"
label(data$lge7___5) <- " mid anterior (choice <- Mild enhancent)"
label(data$lge8___1) <- " mid anteroseptal (choice <- Sub-endo)"
label(data$lge8___2) <- " mid anteroseptal (choice <- Mid-wall)"
label(data$lge8___3) <- " mid anteroseptal (choice <- Sub-epi)"
label(data$lge8___4) <- " mid anteroseptal (choice <- Transmural)"
label(data$lge8___5) <- " mid anteroseptal (choice <- Mild enhancent)"
label(data$lge9___1) <- " mid inferoseptal (choice <- Sub-endo)"
label(data$lge9___2) <- " mid inferoseptal (choice <- Mid-wall)"
label(data$lge9___3) <- " mid inferoseptal (choice <- Sub-epi)"
label(data$lge9___4) <- " mid inferoseptal (choice <- Transmural)"
label(data$lge9___5) <- " mid inferoseptal (choice <- Mild enhancent)"
label(data$lge10___1) <- " mid inferior (choice <- Sub-endo)"
label(data$lge10___2) <- " mid inferior (choice <- Mid-wall)"
label(data$lge10___3) <- " mid inferior (choice <- Sub-epi)"
label(data$lge10___4) <- " mid inferior (choice <- Transmural)"
label(data$lge10___5) <- " mid inferior (choice <- Mild enhancent)"
label(data$lge11___1) <- " mid inferolateral (choice <- Sub-endo)"
label(data$lge11___2) <- " mid inferolateral (choice <- Mid-wall)"
label(data$lge11___3) <- " mid inferolateral (choice <- Sub-epi)"
label(data$lge11___4) <- " mid inferolateral (choice <- Transmural)"
label(data$lge11___5) <- " mid inferolateral (choice <- Mild enhancent)"
label(data$lge12___1) <- " mid anterolateral (choice <- Sub-endo)"
label(data$lge12___2) <- " mid anterolateral (choice <- Mid-wall)"
label(data$lge12___3) <- " mid anterolateral (choice <- Sub-epi)"
label(data$lge12___4) <- " mid anterolateral (choice <- Transmural)"
label(data$lge12___5) <- " mid anterolateral (choice <- Mild enhancent)"
label(data$lge13___1) <- " apical anterior (choice <- Sub-endo)"
label(data$lge13___2) <- " apical anterior (choice <- Mid-wall)"
label(data$lge13___3) <- " apical anterior (choice <- Sub-epi)"
label(data$lge13___4) <- " apical anterior (choice <- Transmural)"
label(data$lge13___5) <- " apical anterior (choice <- Mild enhancent)"
label(data$lge14___1) <- " apical septal (choice <- Sub-endo)"
label(data$lge14___2) <- " apical septal (choice <- Mid-wall)"
label(data$lge14___3) <- " apical septal (choice <- Sub-epi)"
label(data$lge14___4) <- " apical septal (choice <- Transmural)"
label(data$lge14___5) <- " apical septal (choice <- Mild enhancent)"
label(data$lge15___1) <- " apical inferior (choice <- Sub-endo)"
label(data$lge15___2) <- " apical inferior (choice <- Mid-wall)"
label(data$lge15___3) <- " apical inferior (choice <- Sub-epi)"
label(data$lge15___4) <- " apical inferior (choice <- Transmural)"
label(data$lge15___5) <- " apical inferior (choice <- Mild enhancent)"
label(data$lge16___1) <- " apical lateral (choice <- Sub-endo)"
label(data$lge16___2) <- " apical lateral (choice <- Mid-wall)"
label(data$lge16___3) <- " apical lateral (choice <- Sub-epi)"
label(data$lge16___4) <- " apical lateral (choice <- Transmural)"
label(data$lge16___5) <- " apical lateral (choice <- Mild enhancent)"
label(data$lge17___1) <- " apex (choice <- Sub-endo)"
label(data$lge17___2) <- " apex (choice <- Mid-wall)"
label(data$lge17___3) <- " apex (choice <- Sub-epi)"
label(data$lge17___4) <- " apex (choice <- Transmural)"
label(data$lge17___5) <- " apex (choice <- Mild enhancent)"
label(data$lge_mass_cmr) <- "LGE (g) "
label(data$lge_mass_per_cmr) <- "LGE mass (%)"
label(data$rvlge_cmr) <- "RV LGE"
label(data$rvlge_location_cmr___1) <- "RV LGE Location (choice <- basal anterior)"
label(data$rvlge_location_cmr___2) <- "RV LGE Location (choice <- basal lateral)"
label(data$rvlge_location_cmr___3) <- "RV LGE Location (choice <- basal inferior)"
label(data$rvlge_location_cmr___4) <- "RV LGE Location (choice <- mid anterior)"
label(data$rvlge_location_cmr___5) <- "RV LGE Location (choice <- mid lateral)"
label(data$rvlge_location_cmr___6) <- "RV LGE Location (choice <- mid inferior)"
label(data$rvlge_location_cmr___7) <- "RV LGE Location (choice <- apical)"
label(data$rvlge_location_cmr___8) <- "RV LGE Location (choice <- RVOT)"
label(data$global_t1_cmr) <- "Global Native T1"
label(data$t1_mapping_elevated_cmr) <- "Presence of elevated T1 mapping foci"
label(data$high_t1_location_cmr___1) <- "Segments with high native T1 (choice <- basal anterior)"
label(data$high_t1_location_cmr___2) <- "Segments with high native T1 (choice <- basal anteroseptal)"
label(data$high_t1_location_cmr___3) <- "Segments with high native T1 (choice <- basal inferoseptal)"
label(data$high_t1_location_cmr___4) <- "Segments with high native T1 (choice <- basal inferior)"
label(data$high_t1_location_cmr___5) <- "Segments with high native T1 (choice <- basal inferolateral)"
label(data$high_t1_location_cmr___6) <- "Segments with high native T1 (choice <- basal anterolateral)"
label(data$high_t1_location_cmr___7) <- "Segments with high native T1 (choice <- mid anterior)"
label(data$high_t1_location_cmr___8) <- "Segments with high native T1 (choice <- mid anteroseptal)"
label(data$high_t1_location_cmr___9) <- "Segments with high native T1 (choice <- mid inferoseptal)"
label(data$high_t1_location_cmr___10) <- "Segments with high native T1 (choice <- mid inferior)"
label(data$high_t1_location_cmr___11) <- "Segments with high native T1 (choice <- mid inferolateral)"
label(data$high_t1_location_cmr___12) <- "Segments with high native T1 (choice <- mid anterolateral)"
label(data$high_t1_location_cmr___13) <- "Segments with high native T1 (choice <- apical anterior)"
label(data$high_t1_location_cmr___14) <- "Segments with high native T1 (choice <- apical septal)"
label(data$high_t1_location_cmr___15) <- "Segments with high native T1 (choice <- apical inferior)"
label(data$high_t1_location_cmr___16) <- "Segments with high native T1 (choice <- apical lateral)"
label(data$high_t1_location_cmr___17) <- "Segments with high native T1 (choice <- apex)"
label(data$global_ca_t1) <- "Global Ca T1"
label(data$global_ecv) <- "Global ECV"
label(data$stir_oedema_presence_cmr) <- "STIR T2 Oedema presence"
label(data$oedema1___1) <- " basal anterior (choice <- sub-endo)"
label(data$oedema1___2) <- " basal anterior (choice <- mid-wall)"
label(data$oedema1___3) <- " basal anterior (choice <- sub-epi)"
label(data$oedema1___4) <- " basal anterior (choice <- transmural)"
label(data$oedema2___1) <- " basal anteroseptal (choice <- sub-endo)"
label(data$oedema2___2) <- " basal anteroseptal (choice <- mid-wall)"
label(data$oedema2___3) <- " basal anteroseptal (choice <- sub-epi)"
label(data$oedema2___4) <- " basal anteroseptal (choice <- transmural)"
label(data$oedema3___1) <- " basal inferoseptal (choice <- sub-endo)"
label(data$oedema3___2) <- " basal inferoseptal (choice <- mid-wall)"
label(data$oedema3___3) <- " basal inferoseptal (choice <- sub-epi)"
label(data$oedema3___4) <- " basal inferoseptal (choice <- transmural)"
label(data$oedema4___1) <- " basal inferior (choice <- sub-endo)"
label(data$oedema4___2) <- " basal inferior (choice <- mid-wall)"
label(data$oedema4___3) <- " basal inferior (choice <- sub-epi)"
label(data$oedema4___4) <- " basal inferior (choice <- transmural)"
label(data$oedema5___1) <- " basal inferolateral (choice <- sub-endo)"
label(data$oedema5___2) <- " basal inferolateral (choice <- mid-wall)"
label(data$oedema5___3) <- " basal inferolateral (choice <- sub-epi)"
label(data$oedema5___4) <- " basal inferolateral (choice <- transmural)"
label(data$oedema6___1) <- " basal anterolateral (choice <- sub-endo)"
label(data$oedema6___2) <- " basal anterolateral (choice <- mid-wall)"
label(data$oedema6___3) <- " basal anterolateral (choice <- sub-epi)"
label(data$oedema6___4) <- " basal anterolateral (choice <- transmural)"
label(data$oedema7___1) <- " mid anterior (choice <- sub-endo)"
label(data$oedema7___2) <- " mid anterior (choice <- mid-wall)"
label(data$oedema7___3) <- " mid anterior (choice <- sub-epi)"
label(data$oedema7___4) <- " mid anterior (choice <- transmural)"
label(data$oedema8___1) <- " mid anteroseptal (choice <- sub-endo)"
label(data$oedema8___2) <- " mid anteroseptal (choice <- mid-wall)"
label(data$oedema8___3) <- " mid anteroseptal (choice <- sub-epi)"
label(data$oedema8___4) <- " mid anteroseptal (choice <- transmural)"
label(data$oedema9___1) <- " mid inferoseptal (choice <- sub-endo)"
label(data$oedema9___2) <- " mid inferoseptal (choice <- mid-wall)"
label(data$oedema9___3) <- " mid inferoseptal (choice <- sub-epi)"
label(data$oedema9___4) <- " mid inferoseptal (choice <- transmural)"
label(data$oedema10___1) <- " mid inferior (choice <- sub-endo)"
label(data$oedema10___2) <- " mid inferior (choice <- mid-wall)"
label(data$oedema10___3) <- " mid inferior (choice <- sub-epi)"
label(data$oedema10___4) <- " mid inferior (choice <- transmural)"
label(data$oedema11___1) <- " mid inferolateral (choice <- sub-endo)"
label(data$oedema11___2) <- " mid inferolateral (choice <- mid-wall)"
label(data$oedema11___3) <- " mid inferolateral (choice <- sub-epi)"
label(data$oedema11___4) <- " mid inferolateral (choice <- transmural)"
label(data$oedema12___1) <- " mid anterolateral (choice <- sub-endo)"
label(data$oedema12___2) <- " mid anterolateral (choice <- mid-wall)"
label(data$oedema12___3) <- " mid anterolateral (choice <- sub-epi)"
label(data$oedema12___4) <- " mid anterolateral (choice <- transmural)"
label(data$oedema13___1) <- " apical anterior (choice <- sub-endo)"
label(data$oedema13___2) <- " apical anterior (choice <- mid-wall)"
label(data$oedema13___3) <- " apical anterior (choice <- sub-epi)"
label(data$oedema13___4) <- " apical anterior (choice <- transmural)"
label(data$oedema14___1) <- " apical septal (choice <- sub-endo)"
label(data$oedema14___2) <- " apical septal (choice <- mid-wall)"
label(data$oedema14___3) <- " apical septal (choice <- sub-epi)"
label(data$oedema14___4) <- " apical septal (choice <- transmural)"
label(data$oedema15___1) <- " apical inferior (choice <- sub-endo)"
label(data$oedema15___2) <- " apical inferior (choice <- mid-wall)"
label(data$oedema15___3) <- " apical inferior (choice <- sub-epi)"
label(data$oedema15___4) <- " apical inferior (choice <- transmural)"
label(data$oedema16___1) <- " apical lateral (choice <- sub-endo)"
label(data$oedema16___2) <- " apical lateral (choice <- mid-wall)"
label(data$oedema16___3) <- " apical lateral (choice <- sub-epi)"
label(data$oedema16___4) <- " apical lateral (choice <- transmural)"
label(data$oedema17___1) <- " apex (choice <- sub-endo)"
label(data$oedema17___2) <- " apex (choice <- mid-wall)"
label(data$oedema17___3) <- " apex (choice <- sub-epi)"
label(data$oedema17___4) <- " apex (choice <- transmural)"
label(data$global_t2_cmr) <- "Global T2"
label(data$t2_mapping_elevated_cmr) <- "Presence of elevated T2 mapping foci"
label(data$high_t2_location_cmr___1) <- "Segments with high T2 (choice <- basal anterior)"
label(data$high_t2_location_cmr___2) <- "Segments with high T2 (choice <- basal anteroseptal)"
label(data$high_t2_location_cmr___3) <- "Segments with high T2 (choice <- basal inferoseptal)"
label(data$high_t2_location_cmr___4) <- "Segments with high T2 (choice <- basal inferior)"
label(data$high_t2_location_cmr___5) <- "Segments with high T2 (choice <- basal inferolateral)"
label(data$high_t2_location_cmr___6) <- "Segments with high T2 (choice <- basal anterolateral)"
label(data$high_t2_location_cmr___7) <- "Segments with high T2 (choice <- mid anterior)"
label(data$high_t2_location_cmr___8) <- "Segments with high T2 (choice <- mid anteroseptal)"
label(data$high_t2_location_cmr___9) <- "Segments with high T2 (choice <- mid inferoseptal)"
label(data$high_t2_location_cmr___10) <- "Segments with high T2 (choice <- mid inferior)"
label(data$high_t2_location_cmr___11) <- "Segments with high T2 (choice <- mid inferolateral)"
label(data$high_t2_location_cmr___12) <- "Segments with high T2 (choice <- mid anterolateral)"
label(data$high_t2_location_cmr___13) <- "Segments with high T2 (choice <- apical anterior)"
label(data$high_t2_location_cmr___14) <- "Segments with high T2 (choice <- apical septal)"
label(data$high_t2_location_cmr___15) <- "Segments with high T2 (choice <- apical inferior)"
label(data$high_t2_location_cmr___16) <- "Segments with high T2 (choice <- apical lateral)"
label(data$high_t2_location_cmr___17) <- "Segments with high T2 (choice <- apex)"
label(data$pericardial_oedema_cmr) <- "pericardial oedema T2+"
label(data$pericardial_lge_cmr) <- "pericardial LGE+"
label(data$vers_peri_cmr) <- "pericardial effusion "
label(data$ver_per_dim_cmr) <- "pericardial effusion  max dimensions"
label(data$comments_cmr) <- "comments       "
label(data$hr_cmr) <- "Heart Rate"
label(data$lvedv_cmr) <- "LVEDV (ml)"
label(data$lvesv_cmr) <- "LVESV (ml)"
label(data$lvsv_cmr) <- "LVSV (ml)        "
label(data$lvef_cmr) <- "LVEF (%)      "
label(data$lvco_cmr) <- "LVCO (l/min)"
label(data$lvci_cmr) <- "LVCI (l/min/m2)"
label(data$lv_mass_cmr) <- "LV mass (g)"
label(data$lvedvi_cmr) <- "LVEDVi (ml/m2)          "
label(data$lvesvi_cmr) <- "LVESVi (ml/m2)          "
label(data$lvsvi_cmr) <- "LVSVi (ml/m2)"
label(data$lvmi_cmr) <- "LV mass index (g/m2)        "
label(data$rvedv_cmr) <- "RVEDV (ml)"
label(data$rvesv_cmr) <- "RVESV (ml)"
label(data$rvsv_cmr) <- "RVSV (ml)        "
label(data$rvef_cmr) <- "RVEF (%)      "
label(data$rvco_cmr) <- "RVCO (l/min)"
label(data$rvci_cmr) <- "RVCI (l/min/m2)"
label(data$rvedvi_cmr) <- "RVEDVi (ml/m2)          "
label(data$rvesvi_cmr) <- "RVESVi (ml/m2)          "
label(data$rvsvi_cmr) <- "RVSVi (ml/m2)"
label(data$mapseinf_cmr) <- "MAPSE Inferior"
label(data$mapseant_cmr) <- "MAPSE Anterior"
label(data$mapselat_cmr) <- "MAPSE Lateral"
label(data$mapsesep_cmr) <- "MAPSE Septal"
label(data$tapse_cmr) <- "TAPSE"
label(data$min_la_vol_cmr) <- "Min LA Volume"
label(data$max_la_vol_cmr) <- "Max LA Volume"
label(data$min_la_vol_index_cmr) <- "Min LA Vol/BSA"
label(data$max_la_vol_index_cmr) <- "Max LA Vol/BSA"
label(data$la_ef_cmr) <- "LA EF (%)"
label(data$sax_gcs_cmr) <- "SAX Global Circumferential Strain"
label(data$sax_grs_cmr) <- "SAX Global Radial Strain"
label(data$lax_gls_cmr) <- "LAX Global Longitudinal Strain"
label(data$lax_grs_cmr) <- "LAX Global Radial Strain"
label(data$total_forward_volume_ao_cmr) <- "Total Forward Volume"
label(data$total_backward_volume_ao_cmr) <- "Total Backward Volume"
label(data$total_volume_ao_cmr) <- "Total Volume"
label(data$regurgitation_fraction_ao_cmr) <- "Regurgitation Fraction"
label(data$vol_min_ao_cmr) <- "Vol/min"
label(data$max_pressure_gradient_ao_cmr) <- "Max Pressure Gradient"
label(data$mean_pressure_gradient_ao_cmr) <- "Mean Pressure Gradient"
label(data$maximum_velocity_ao_cmr) <- "Maximum Velocity (1x1 px)"
label(data$mr_cmr) <- "mitral regurgitation"
label(data$mr_fraction_cmr) <- "mitral regurgitant fraction"
label(data$mr_vol_cmr) <- "mitral regurgitant volume"
label(data$total_forward_volume_pa_cmr) <- "Total Forward Volume"
label(data$total_backward_volume_pa_cmr) <- "Total Backward Volume"
label(data$total_volume_pa_cmr) <- "Total Volume"
label(data$regurgitation_fraction_pa_cmr) <- "Regurgitation Fraction"
label(data$vol_min_pa_cmr) <- "Vol/min"
label(data$max_pressure_gradient_pa_cmr) <- "Max Pressure Gradient"
label(data$mean_pressure_gradient_pa_cmr) <- "Mean Pressure Gradient"
label(data$maximum_velocity_pa_cmr) <- "Maximum Velocity (1x1 px)"
label(data$tr_cmr) <- "Tricuspid regurgitation"
label(data$tr_fraction_cmr) <- "Tricuspid regurgitant fraction"
label(data$tr_vol_cmr) <- "Tricuspid regurgitant volume"
label(data$qp_qs_cmr) <- "Qp/Qs Volume"
label(data$basal_peak_strain_radial) <- "Basal Peak Strain Radial"
label(data$mid_peak_strain_radial) <- "Mid Peak Strain Radial"
label(data$apical_peak_strain_radial) <- "Apical Peak Strain Radial"
label(data$global_peak_strain_radial) <- "Global Peak Strain Radial"
label(data$peak_strain_radial_1) <- "Peak Strain Radial 1"
label(data$peak_strain_radial_2) <- "Peak Strain Radial 2"
label(data$peak_strain_radial_3) <- "Peak Strain Radial 3"
label(data$peak_strain_radial_4) <- "Peak Strain Radial 4"
label(data$peak_strain_radial_5) <- "Peak Strain Radial 5"
label(data$peak_strain_radial_6) <- "Peak Strain Radial 6"
label(data$peak_strain_radial_7) <- "Peak Strain Radial 7"
label(data$peak_strain_radial_8) <- "Peak Strain Radial 8"
label(data$peak_strain_radial_9) <- "Peak Strain Radial 9"
label(data$peak_strain_radial_10) <- "Peak Strain Radial 10"
label(data$peak_strain_radial_11) <- "Peak Strain Radial 11"
label(data$peak_strain_radial_12) <- "Peak Strain Radial 12"
label(data$peak_strain_radial_13) <- "Peak Strain Radial 13"
label(data$peak_strain_radial_14) <- "Peak Strain Radial 14"
label(data$peak_strain_radial_15) <- "Peak Strain Radial 15"
label(data$peak_strain_radial_16) <- "Peak Strain Radial 16"
label(data$basal_peak_strain_circumferential) <- "Basal Peak Strain Circumferential"
label(data$mid_peak_strain_circumferential) <- "Mid Peak Strain Circumferential"
label(data$apical_peak_strain_circumferential) <- "Apical Peak Strain Circumferential"
label(data$global_peak_strain_circumferential) <- "Global Peak Strain Circumferential"
label(data$peak_strain_circumferential_1) <- "Peak Strain Circumferential 1"
label(data$peak_strain_circumferential_2) <- "Peak Strain Circumferential 2"
label(data$peak_strain_circumferential_3) <- "Peak Strain Circumferential 3"
label(data$peak_strain_circumferential_4) <- "Peak Strain Circumferential 4"
label(data$peak_strain_circumferential_5) <- "Peak Strain Circumferential 5"
label(data$peak_strain_circumferential_6) <- "Peak Strain Circumferential 6"
label(data$peak_strain_circumferential_7) <- "Peak Strain Circumferential 7"
label(data$peak_strain_circumferential_8) <- "Peak Strain Circumferential 8"
label(data$peak_strain_circumferential_9) <- "Peak Strain Circumferential 9"
label(data$peak_strain_circumferential_10) <- "Peak Strain Circumferential 10"
label(data$peak_strain_circumferential_11) <- "Peak Strain Circumferential 11"
label(data$peak_strain_circumferential_12) <- "Peak Strain Circumferential 12"
label(data$peak_strain_circumferential_13) <- "Peak Strain Circumferential 13"
label(data$peak_strain_circumferential_14) <- "Peak Strain Circumferential 14"
label(data$peak_strain_circumferential_15) <- "Peak Strain Circumferential 15"
label(data$peak_strain_circumferential_16) <- "Peak Strain Circumferential 16"
label(data$basal_peak_strain_longitudinal) <- "Basal Peak Strain Longitudinal"
label(data$mid_peak_strain_longitudinal) <- "Mid Peak Strain Longitudinal"
label(data$apical_peak_strain_longitudinal) <- "Apical Peak Strain Longitudinal"
label(data$global_peak_strain_longitudinal) <- "Global Peak Strain Longitudinal"
label(data$peak_strain_longitudinal_1) <- "Peak Strain Longitudinal 1"
label(data$peak_strain_longitudinal_2) <- "Peak Strain Longitudinal 2"
label(data$peak_strain_longitudinal_3) <- "Peak Strain Longitudinal 3"
label(data$peak_strain_longitudinal_4) <- "Peak Strain Longitudinal 4"
label(data$peak_strain_longitudinal_5) <- "Peak Strain Longitudinal 5"
label(data$peak_strain_longitudinal_6) <- "Peak Strain Longitudinal 6"
label(data$peak_strain_longitudinal_7) <- "Peak Strain Longitudinal 7"
label(data$peak_strain_longitudinal_8) <- "Peak Strain Longitudinal 8"
label(data$peak_strain_longitudinal_9) <- "Peak Strain Longitudinal 9"
label(data$peak_strain_longitudinal_10) <- "Peak Strain Longitudinal 10"
label(data$peak_strain_longitudinal_11) <- "Peak Strain Longitudinal 11"
label(data$peak_strain_longitudinal_12) <- "Peak Strain Longitudinal 12"
label(data$peak_strain_longitudinal_13) <- "Peak Strain Longitudinal 13"
label(data$peak_strain_longitudinal_14) <- "Peak Strain Longitudinal 14"
label(data$peak_strain_longitudinal_15) <- "Peak Strain Longitudinal 15"
label(data$peak_strain_longitudinal_16) <- "Peak Strain Longitudinal 16"
label(data$basal_time_to_peak_radial) <- "Basal Time To Peak Radial"
label(data$mid_time_to_peak_radial) <- "Mid Time To Peak Radial"
label(data$apical_time_to_peak_radial) <- "Apical Time To Peak Radial"
label(data$global_time_to_peak_radial) <- "Global Time To Peak Radial"
label(data$time_to_peak_radial_1) <- "Time To Peak Radial 1"
label(data$time_to_peak_radial_2) <- "Time To Peak Radial 2"
label(data$time_to_peak_radial_3) <- "Time To Peak Radial 3"
label(data$time_to_peak_radial_4) <- "Time To Peak Radial 4"
label(data$time_to_peak_radial_5) <- "Time To Peak Radial 5"
label(data$time_to_peak_radial_6) <- "Time To Peak Radial 6"
label(data$time_to_peak_radial_7) <- "Time To Peak Radial 7"
label(data$time_to_peak_radial_8) <- "Time To Peak Radial 8"
label(data$time_to_peak_radial_9) <- "Time To Peak Radial 9"
label(data$time_to_peak_radial_10) <- "Time To Peak Radial 10"
label(data$time_to_peak_radial_11) <- "Time To Peak Radial 11"
label(data$time_to_peak_radial_12) <- "Time To Peak Radial 12"
label(data$time_to_peak_radial_13) <- "Time To Peak Radial 13"
label(data$time_to_peak_radial_14) <- "Time To Peak Radial 14"
label(data$time_to_peak_radial_15) <- "Time To Peak Radial 15"
label(data$time_to_peak_radial_16) <- "Time To Peak Radial 16"
label(data$basal_time_to_peak_circumferential) <- "Basal Time To Peak Circumferential"
label(data$mid_time_to_peak_circumferential) <- "Mid Time To Peak Circumferential"
label(data$apical_time_to_peak_circumferential) <- "Apical Time To Peak Circumferential"
label(data$global_time_to_peak_circumferential) <- "Global Time To Peak Circumferential"
label(data$time_to_peak_circumferential_1) <- "Time To Peak Circumferential 1"
label(data$time_to_peak_circumferential_2) <- "Time To Peak Circumferential 2"
label(data$time_to_peak_circumferential_3) <- "Time To Peak Circumferential 3"
label(data$time_to_peak_circumferential_4) <- "Time To Peak Circumferential 4"
label(data$time_to_peak_circumferential_5) <- "Time To Peak Circumferential 5"
label(data$time_to_peak_circumferential_6) <- "Time To Peak Circumferential 6"
label(data$time_to_peak_circumferential_7) <- "Time To Peak Circumferential 7"
label(data$time_to_peak_circumferential_8) <- "Time To Peak Circumferential 8"
label(data$time_to_peak_circumferential_9) <- "Time To Peak Circumferential 9"
label(data$time_to_peak_circumferential_10) <- "Time To Peak Circumferential 10"
label(data$time_to_peak_circumferential_11) <- "Time To Peak Circumferential 11"
label(data$time_to_peak_circumferential_12) <- "Time To Peak Circumferential 12"
label(data$time_to_peak_circumferential_13) <- "Time To Peak Circumferential 13"
label(data$time_to_peak_circumferential_14) <- "Time To Peak Circumferential 14"
label(data$time_to_peak_circumferential_15) <- "Time To Peak Circumferential 15"
label(data$time_to_peak_circumferential_16) <- "Time To Peak Circumferential 16"
label(data$basal_time_to_peak_longitudinal) <- "Basal Time To Peak Longitudinal"
label(data$mid_time_to_peak_longitudinal) <- "Mid Time To Peak Longitudinal"
label(data$apical_time_to_peak_longitudinal) <- "Apical Time To Peak Longitudinal"
label(data$global_time_to_peak_longitudinal) <- "Global Time To Peak Longitudinal"
label(data$time_to_peak_longitudinal_1) <- "Time To Peak Longitudinal 1"
label(data$time_to_peak_longitudinal_2) <- "Time To Peak Longitudinal 2"
label(data$time_to_peak_longitudinal_3) <- "Time To Peak Longitudinal 3"
label(data$time_to_peak_longitudinal_4) <- "Time To Peak Longitudinal 4"
label(data$time_to_peak_longitudinal_5) <- "Time To Peak Longitudinal 5"
label(data$time_to_peak_longitudinal_6) <- "Time To Peak Longitudinal 6"
label(data$time_to_peak_longitudinal_7) <- "Time To Peak Longitudinal 7"
label(data$time_to_peak_longitudinal_8) <- "Time To Peak Longitudinal 8"
label(data$time_to_peak_longitudinal_9) <- "Time To Peak Longitudinal 9"
label(data$time_to_peak_longitudinal_10) <- "Time To Peak Longitudinal 10"
label(data$time_to_peak_longitudinal_11) <- "Time To Peak Longitudinal 11"
label(data$time_to_peak_longitudinal_12) <- "Time To Peak Longitudinal 12"
label(data$time_to_peak_longitudinal_13) <- "Time To Peak Longitudinal 13"
label(data$time_to_peak_longitudinal_14) <- "Time To Peak Longitudinal 14"
label(data$time_to_peak_longitudinal_15) <- "Time To Peak Longitudinal 15"
label(data$time_to_peak_longitudinal_16) <- "Time To Peak Longitudinal 16"
label(data$basal_peak_systolic_strain_rate_radial) <- "Basal Peak Systolic Strain Rate Radial"
label(data$mid_peak_systolic_strain_rate_radial) <- "Mid Peak Systolic Strain Rate Radial"
label(data$apical_peak_systolic_strain_rate_radial) <- "Apical Peak Systolic Strain Rate Radial"
label(data$global_peak_systolic_strain_rate_radial) <- "Global Peak Systolic Strain Rate Radial"
label(data$peak_systolic_strain_rate_radial_1) <- "Peak Systolic Strain Rate Radial 1"
label(data$peak_systolic_strain_rate_radial_2) <- "Peak Systolic Strain Rate Radial 2"
label(data$peak_systolic_strain_rate_radial_3) <- "Peak Systolic Strain Rate Radial 3"
label(data$peak_systolic_strain_rate_radial_4) <- "Peak Systolic Strain Rate Radial 4"
label(data$peak_systolic_strain_rate_radial_5) <- "Peak Systolic Strain Rate Radial 5"
label(data$peak_systolic_strain_rate_radial_6) <- "Peak Systolic Strain Rate Radial 6"
label(data$peak_systolic_strain_rate_radial_7) <- "Peak Systolic Strain Rate Radial 7"
label(data$peak_systolic_strain_rate_radial_8) <- "Peak Systolic Strain Rate Radial 8"
label(data$peak_systolic_strain_rate_radial_9) <- "Peak Systolic Strain Rate Radial 9"
label(data$peak_systolic_strain_rate_radial_10) <- "Peak Systolic Strain Rate Radial 10"
label(data$peak_systolic_strain_rate_radial_11) <- "Peak Systolic Strain Rate Radial 11"
label(data$peak_systolic_strain_rate_radial_12) <- "Peak Systolic Strain Rate Radial 12"
label(data$peak_systolic_strain_rate_radial_13) <- "Peak Systolic Strain Rate Radial 13"
label(data$peak_systolic_strain_rate_radial_14) <- "Peak Systolic Strain Rate Radial 14"
label(data$peak_systolic_strain_rate_radial_15) <- "Peak Systolic Strain Rate Radial 15"
label(data$peak_systolic_strain_rate_radial_16) <- "Peak Systolic Strain Rate Radial 16"
label(data$basal_peak_systolic_strain_rate_circumferential) <- "Basal Peak Systolic Strain Rate Circumferential"
label(data$mid_peak_systolic_strain_rate_circumferential) <- "Mid Peak Systolic Strain Rate Circumferential"
label(data$apical_peak_systolic_strain_rate_circumferential) <- "Apical Peak Systolic Strain Rate Circumferential"
label(data$global_peak_systolic_strain_rate_circumferential) <- "Global Peak Systolic Strain Rate Circumferential"
label(data$peak_systolic_strain_rate_circumferential_1) <- "Peak Systolic Strain Rate Circumferential 1"
label(data$peak_systolic_strain_rate_circumferential_2) <- "Peak Systolic Strain Rate Circumferential 2"
label(data$peak_systolic_strain_rate_circumferential_3) <- "Peak Systolic Strain Rate Circumferential 3"
label(data$peak_systolic_strain_rate_circumferential_4) <- "Peak Systolic Strain Rate Circumferential 4"
label(data$peak_systolic_strain_rate_circumferential_5) <- "Peak Systolic Strain Rate Circumferential 5"
label(data$peak_systolic_strain_rate_circumferential_6) <- "Peak Systolic Strain Rate Circumferential 6"
label(data$peak_systolic_strain_rate_circumferential_7) <- "Peak Systolic Strain Rate Circumferential 7"
label(data$peak_systolic_strain_rate_circumferential_8) <- "Peak Systolic Strain Rate Circumferential 8"
label(data$peak_systolic_strain_rate_circumferential_9) <- "Peak Systolic Strain Rate Circumferential 9"
label(data$peak_systolic_strain_rate_circumferential_10) <- "Peak Systolic Strain Rate Circumferential 10"
label(data$peak_systolic_strain_rate_circumferential_11) <- "Peak Systolic Strain Rate Circumferential 11"
label(data$peak_systolic_strain_rate_circumferential_12) <- "Peak Systolic Strain Rate Circumferential 12"
label(data$peak_systolic_strain_rate_circumferential_13) <- "Peak Systolic Strain Rate Circumferential 13"
label(data$peak_systolic_strain_rate_circumferential_14) <- "Peak Systolic Strain Rate Circumferential 14"
label(data$peak_systolic_strain_rate_circumferential_15) <- "Peak Systolic Strain Rate Circumferential 15"
label(data$peak_systolic_strain_rate_circumferential_16) <- "Peak Systolic Strain Rate Circumferential 16"
label(data$basal_peak_systolic_strain_rate_longitudinal) <- "Basal Peak Systolic Strain Rate Longitudinal"
label(data$mid_peak_systolic_strain_rate_longitudinal) <- "Mid Peak Systolic Strain Rate Longitudinal"
label(data$apical_peak_systolic_strain_rate_longitudinal) <- "Apical Peak Systolic Strain Rate Longitudinal"
label(data$global_peak_systolic_strain_rate_longitudinal) <- "Global Peak Systolic Strain Rate Longitudinal"
label(data$peak_systolic_strain_rate_longitudinal_1) <- "Peak Systolic Strain Rate Longitudinal 1"
label(data$peak_systolic_strain_rate_longitudinal_2) <- "Peak Systolic Strain Rate Longitudinal 2"
label(data$peak_systolic_strain_rate_longitudinal_3) <- "Peak Systolic Strain Rate Longitudinal 3"
label(data$peak_systolic_strain_rate_longitudinal_4) <- "Peak Systolic Strain Rate Longitudinal 4"
label(data$peak_systolic_strain_rate_longitudinal_5) <- "Peak Systolic Strain Rate Longitudinal 5"
label(data$peak_systolic_strain_rate_longitudinal_6) <- "Peak Systolic Strain Rate Longitudinal 6"
label(data$peak_systolic_strain_rate_longitudinal_7) <- "Peak Systolic Strain Rate Longitudinal 7"
label(data$peak_systolic_strain_rate_longitudinal_8) <- "Peak Systolic Strain Rate Longitudinal 8"
label(data$peak_systolic_strain_rate_longitudinal_9) <- "Peak Systolic Strain Rate Longitudinal 9"
label(data$peak_systolic_strain_rate_longitudinal_10) <- "Peak Systolic Strain Rate Longitudinal 10"
label(data$peak_systolic_strain_rate_longitudinal_11) <- "Peak Systolic Strain Rate Longitudinal 11"
label(data$peak_systolic_strain_rate_longitudinal_12) <- "Peak Systolic Strain Rate Longitudinal 12"
label(data$peak_systolic_strain_rate_longitudinal_13) <- "Peak Systolic Strain Rate Longitudinal 13"
label(data$peak_systolic_strain_rate_longitudinal_14) <- "Peak Systolic Strain Rate Longitudinal 14"
label(data$peak_systolic_strain_rate_longitudinal_15) <- "Peak Systolic Strain Rate Longitudinal 15"
label(data$peak_systolic_strain_rate_longitudinal_16) <- "Peak Systolic Strain Rate Longitudinal 16"
label(data$basal_peak_diastolic_strain_rate_radial) <- "Basal Peak Diastolic Strain Rate Radial"
label(data$mid_peak_diastolic_strain_rate_radial) <- "Mid Peak Diastolic Strain Rate Radial"
label(data$apical_peak_diastolic_strain_rate_radial) <- "Apical Peak Diastolic Strain Rate Radial"
label(data$global_peak_diastolic_strain_rate_radial) <- "Global Peak Diastolic Strain Rate Radial"
label(data$peak_diastolic_strain_rate_radial_1) <- "Peak Diastolic Strain Rate Radial 1"
label(data$peak_diastolic_strain_rate_radial_2) <- "Peak Diastolic Strain Rate Radial 2"
label(data$peak_diastolic_strain_rate_radial_3) <- "Peak Diastolic Strain Rate Radial 3"
label(data$peak_diastolic_strain_rate_radial_4) <- "Peak Diastolic Strain Rate Radial 4"
label(data$peak_diastolic_strain_rate_radial_5) <- "Peak Diastolic Strain Rate Radial 5"
label(data$peak_diastolic_strain_rate_radial_6) <- "Peak Diastolic Strain Rate Radial 6"
label(data$peak_diastolic_strain_rate_radial_7) <- "Peak Diastolic Strain Rate Radial 7"
label(data$peak_diastolic_strain_rate_radial_8) <- "Peak Diastolic Strain Rate Radial 8"
label(data$peak_diastolic_strain_rate_radial_9) <- "Peak Diastolic Strain Rate Radial 9"
label(data$peak_diastolic_strain_rate_radial_10) <- "Peak Diastolic Strain Rate Radial 10"
label(data$peak_diastolic_strain_rate_radial_11) <- "Peak Diastolic Strain Rate Radial 11"
label(data$peak_diastolic_strain_rate_radial_12) <- "Peak Diastolic Strain Rate Radial 12"
label(data$peak_diastolic_strain_rate_radial_13) <- "Peak Diastolic Strain Rate Radial 13"
label(data$peak_diastolic_strain_rate_radial_14) <- "Peak Diastolic Strain Rate Radial 14"
label(data$peak_diastolic_strain_rate_radial_15) <- "Peak Diastolic Strain Rate Radial 15"
label(data$peak_diastolic_strain_rate_radial_16) <- "Peak Diastolic Strain Rate Radial 16"
label(data$basal_peak_diastolic_strain_rate_circumferential) <- "Basal Peak Diastolic Strain Rate Circumferential"
label(data$mid_peak_diastolic_strain_rate_circumferential) <- "Mid Peak Diastolic Strain Rate Circumferential"
label(data$apical_peak_diastolic_strain_rate_circumferential) <- "Apical Peak Diastolic Strain Rate Circumferential"
label(data$global_peak_diastolic_strain_rate_circumferential) <- "Global Peak Diastolic Strain Rate Circumferential"
label(data$peak_diastolic_strain_rate_circumferential_1) <- "Peak Diastolic Strain Rate Circumferential 1"
label(data$peak_diastolic_strain_rate_circumferential_2) <- "Peak Diastolic Strain Rate Circumferential 2"
label(data$peak_diastolic_strain_rate_circumferential_3) <- "Peak Diastolic Strain Rate Circumferential 3"
label(data$peak_diastolic_strain_rate_circumferential_4) <- "Peak Diastolic Strain Rate Circumferential 4"
label(data$peak_diastolic_strain_rate_circumferential_5) <- "Peak Diastolic Strain Rate Circumferential 5"
label(data$peak_diastolic_strain_rate_circumferential_6) <- "Peak Diastolic Strain Rate Circumferential 6"
label(data$peak_diastolic_strain_rate_circumferential_7) <- "Peak Diastolic Strain Rate Circumferential 7"
label(data$peak_diastolic_strain_rate_circumferential_8) <- "Peak Diastolic Strain Rate Circumferential 8"
label(data$peak_diastolic_strain_rate_circumferential_9) <- "Peak Diastolic Strain Rate Circumferential 9"
label(data$peak_diastolic_strain_rate_circumferential_10) <- "Peak Diastolic Strain Rate Circumferential 10"
label(data$peak_diastolic_strain_rate_circumferential_11) <- "Peak Diastolic Strain Rate Circumferential 11"
label(data$peak_diastolic_strain_rate_circumferential_12) <- "Peak Diastolic Strain Rate Circumferential 12"
label(data$peak_diastolic_strain_rate_circumferential_13) <- "Peak Diastolic Strain Rate Circumferential 13"
label(data$peak_diastolic_strain_rate_circumferential_14) <- "Peak Diastolic Strain Rate Circumferential 14"
label(data$peak_diastolic_strain_rate_circumferential_15) <- "Peak Diastolic Strain Rate Circumferential 15"
label(data$peak_diastolic_strain_rate_circumferential_16) <- "Peak Diastolic Strain Rate Circumferential 16"
label(data$basal_peak_diastolic_strain_rate_longitudinal) <- "Basal Peak Diastolic Strain Rate Longitudinal"
label(data$mid_peak_diastolic_strain_rate_longitudinal) <- "Mid Peak Diastolic Strain Rate Longitudinal"
label(data$apical_peak_diastolic_strain_rate_longitudinal) <- "Apical Peak Diastolic Strain Rate Longitudinal"
label(data$global_peak_diastolic_strain_rate_longitudinal) <- "Global Peak Diastolic Strain Rate Longitudinal"
label(data$peak_diastolic_strain_rate_longitudinal_1) <- "Peak Diastolic Strain Rate Longitudinal 1"
label(data$peak_diastolic_strain_rate_longitudinal_2) <- "Peak Diastolic Strain Rate Longitudinal 2"
label(data$peak_diastolic_strain_rate_longitudinal_3) <- "Peak Diastolic Strain Rate Longitudinal 3"
label(data$peak_diastolic_strain_rate_longitudinal_4) <- "Peak Diastolic Strain Rate Longitudinal 4"
label(data$peak_diastolic_strain_rate_longitudinal_5) <- "Peak Diastolic Strain Rate Longitudinal 5"
label(data$peak_diastolic_strain_rate_longitudinal_6) <- "Peak Diastolic Strain Rate Longitudinal 6"
label(data$peak_diastolic_strain_rate_longitudinal_7) <- "Peak Diastolic Strain Rate Longitudinal 7"
label(data$peak_diastolic_strain_rate_longitudinal_8) <- "Peak Diastolic Strain Rate Longitudinal 8"
label(data$peak_diastolic_strain_rate_longitudinal_9) <- "Peak Diastolic Strain Rate Longitudinal 9"
label(data$peak_diastolic_strain_rate_longitudinal_10) <- "Peak Diastolic Strain Rate Longitudinal 10"
label(data$peak_diastolic_strain_rate_longitudinal_11) <- "Peak Diastolic Strain Rate Longitudinal 11"
label(data$peak_diastolic_strain_rate_longitudinal_12) <- "Peak Diastolic Strain Rate Longitudinal 12"
label(data$peak_diastolic_strain_rate_longitudinal_13) <- "Peak Diastolic Strain Rate Longitudinal 13"
label(data$peak_diastolic_strain_rate_longitudinal_14) <- "Peak Diastolic Strain Rate Longitudinal 14"
label(data$peak_diastolic_strain_rate_longitudinal_15) <- "Peak Diastolic Strain Rate Longitudinal 15"
label(data$peak_diastolic_strain_rate_longitudinal_16) <- "Peak Diastolic Strain Rate Longitudinal 16"
label(data$basal_peak_displacement_radial) <- "Basal Peak Displacement Radial"
label(data$mid_peak_displacement_radial) <- "Mid Peak Displacement Radial"
label(data$apical_peak_displacement_radial) <- "Apical Peak Displacement Radial"
label(data$global_peak_displacement_radial) <- "Global Peak Displacement Radial"
label(data$peak_displacement_radial_1) <- "Peak Displacement Radial 1"
label(data$peak_displacement_radial_2) <- "Peak Displacement Radial 2"
label(data$peak_displacement_radial_3) <- "Peak Displacement Radial 3"
label(data$peak_displacement_radial_4) <- "Peak Displacement Radial 4"
label(data$peak_displacement_radial_5) <- "Peak Displacement Radial 5"
label(data$peak_displacement_radial_6) <- "Peak Displacement Radial 6"
label(data$peak_displacement_radial_7) <- "Peak Displacement Radial 7"
label(data$peak_displacement_radial_8) <- "Peak Displacement Radial 8"
label(data$peak_displacement_radial_9) <- "Peak Displacement Radial 9"
label(data$peak_displacement_radial_10) <- "Peak Displacement Radial 10"
label(data$peak_displacement_radial_11) <- "Peak Displacement Radial 11"
label(data$peak_displacement_radial_12) <- "Peak Displacement Radial 12"
label(data$peak_displacement_radial_13) <- "Peak Displacement Radial 13"
label(data$peak_displacement_radial_14) <- "Peak Displacement Radial 14"
label(data$peak_displacement_radial_15) <- "Peak Displacement Radial 15"
label(data$peak_displacement_radial_16) <- "Peak Displacement Radial 16"
label(data$basal_peak_displacement_circumferential) <- "Basal Peak Displacement Circumferential"
label(data$mid_peak_displacement_circumferential) <- "Mid Peak Displacement Circumferential"
label(data$apical_peak_displacement_circumferential) <- "Apical Peak Displacement Circumferential"
label(data$global_peak_displacement_circumferential) <- "Global Peak Displacement Circumferential"
label(data$peak_displacement_circumferential_1) <- "Peak Displacement Circumferential 1"
label(data$peak_displacement_circumferential_2) <- "Peak Displacement Circumferential 2"
label(data$peak_displacement_circumferential_3) <- "Peak Displacement Circumferential 3"
label(data$peak_displacement_circumferential_4) <- "Peak Displacement Circumferential 4"
label(data$peak_displacement_circumferential_5) <- "Peak Displacement Circumferential 5"
label(data$peak_displacement_circumferential_6) <- "Peak Displacement Circumferential 6"
label(data$peak_displacement_circumferential_7) <- "Peak Displacement Circumferential 7"
label(data$peak_displacement_circumferential_8) <- "Peak Displacement Circumferential 8"
label(data$peak_displacement_circumferential_9) <- "Peak Displacement Circumferential 9"
label(data$peak_displacement_circumferential_10) <- "Peak Displacement Circumferential 10"
label(data$peak_displacement_circumferential_11) <- "Peak Displacement Circumferential 11"
label(data$peak_displacement_circumferential_12) <- "Peak Displacement Circumferential 12"
label(data$peak_displacement_circumferential_13) <- "Peak Displacement Circumferential 13"
label(data$peak_displacement_circumferential_14) <- "Peak Displacement Circumferential 14"
label(data$peak_displacement_circumferential_15) <- "Peak Displacement Circumferential 15"
label(data$peak_displacement_circumferential_16) <- "Peak Displacement Circumferential 16"
label(data$basal_peak_displacement_longitudinal) <- "Basal Peak Displacement Longitudinal"
label(data$mid_peak_displacement_longitudinal) <- "Mid Peak Displacement Longitudinal"
label(data$apical_peak_displacement_longitudinal) <- "Apical Peak Displacement Longitudinal"
label(data$global_peak_displacement_longitudinal) <- "Global Peak Displacement Longitudinal"
label(data$peak_displacement_longitudinal_1) <- "Peak Displacement Longitudinal 1"
label(data$peak_displacement_longitudinal_2) <- "Peak Displacement Longitudinal 2"
label(data$peak_displacement_longitudinal_3) <- "Peak Displacement Longitudinal 3"
label(data$peak_displacement_longitudinal_4) <- "Peak Displacement Longitudinal 4"
label(data$peak_displacement_longitudinal_5) <- "Peak Displacement Longitudinal 5"
label(data$peak_displacement_longitudinal_6) <- "Peak Displacement Longitudinal 6"
label(data$peak_displacement_longitudinal_7) <- "Peak Displacement Longitudinal 7"
label(data$peak_displacement_longitudinal_8) <- "Peak Displacement Longitudinal 8"
label(data$peak_displacement_longitudinal_9) <- "Peak Displacement Longitudinal 9"
label(data$peak_displacement_longitudinal_10) <- "Peak Displacement Longitudinal 10"
label(data$peak_displacement_longitudinal_11) <- "Peak Displacement Longitudinal 11"
label(data$peak_displacement_longitudinal_12) <- "Peak Displacement Longitudinal 12"
label(data$peak_displacement_longitudinal_13) <- "Peak Displacement Longitudinal 13"
label(data$peak_displacement_longitudinal_14) <- "Peak Displacement Longitudinal 14"
label(data$peak_displacement_longitudinal_15) <- "Peak Displacement Longitudinal 15"
label(data$peak_displacement_longitudinal_16) <- "Peak Displacement Longitudinal 16"
label(data$basal_peak_systolic_velocity_radial) <- "Basal Peak Systolic Velocity Radial"
label(data$mid_peak_systolic_velocity_radial) <- "Mid Peak Systolic Velocity Radial"
label(data$apical_peak_systolic_velocity_radial) <- "Apical Peak Systolic Velocity Radial"
label(data$global_peak_systolic_velocity_radial) <- "Global Peak Systolic Velocity Radial"
label(data$peak_systolic_velocity_radial_1) <- "Peak Systolic Velocity Radial 1"
label(data$peak_systolic_velocity_radial_2) <- "Peak Systolic Velocity Radial 2"
label(data$peak_systolic_velocity_radial_3) <- "Peak Systolic Velocity Radial 3"
label(data$peak_systolic_velocity_radial_4) <- "Peak Systolic Velocity Radial 4"
label(data$peak_systolic_velocity_radial_5) <- "Peak Systolic Velocity Radial 5"
label(data$peak_systolic_velocity_radial_6) <- "Peak Systolic Velocity Radial 6"
label(data$peak_systolic_velocity_radial_7) <- "Peak Systolic Velocity Radial 7"
label(data$peak_systolic_velocity_radial_8) <- "Peak Systolic Velocity Radial 8"
label(data$peak_systolic_velocity_radial_9) <- "Peak Systolic Velocity Radial 9"
label(data$peak_systolic_velocity_radial_10) <- "Peak Systolic Velocity Radial 10"
label(data$peak_systolic_velocity_radial_11) <- "Peak Systolic Velocity Radial 11"
label(data$peak_systolic_velocity_radial_12) <- "Peak Systolic Velocity Radial 12"
label(data$peak_systolic_velocity_radial_13) <- "Peak Systolic Velocity Radial 13"
label(data$peak_systolic_velocity_radial_14) <- "Peak Systolic Velocity Radial 14"
label(data$peak_systolic_velocity_radial_15) <- "Peak Systolic Velocity Radial 15"
label(data$peak_systolic_velocity_radial_16) <- "Peak Systolic Velocity Radial 16"
label(data$basal_peak_systolic_velocity_circumferential) <- "Basal Peak Systolic Velocity Circumferential"
label(data$mid_peak_systolic_velocity_circumferential) <- "Mid Peak Systolic Velocity Circumferential"
label(data$apical_peak_systolic_velocity_circumferential) <- "Apical Peak Systolic Velocity Circumferential"
label(data$global_peak_systolic_velocity_circumferential) <- "Global Peak Systolic Velocity Circumferential"
label(data$peak_systolic_velocity_circumferential_1) <- "Peak Systolic Velocity Circumferential 1"
label(data$peak_systolic_velocity_circumferential_2) <- "Peak Systolic Velocity Circumferential 2"
label(data$peak_systolic_velocity_circumferential_3) <- "Peak Systolic Velocity Circumferential 3"
label(data$peak_systolic_velocity_circumferential_4) <- "Peak Systolic Velocity Circumferential 4"
label(data$peak_systolic_velocity_circumferential_5) <- "Peak Systolic Velocity Circumferential 5"
label(data$peak_systolic_velocity_circumferential_6) <- "Peak Systolic Velocity Circumferential 6"
label(data$peak_systolic_velocity_circumferential_7) <- "Peak Systolic Velocity Circumferential 7"
label(data$peak_systolic_velocity_circumferential_8) <- "Peak Systolic Velocity Circumferential 8"
label(data$peak_systolic_velocity_circumferential_9) <- "Peak Systolic Velocity Circumferential 9"
label(data$peak_systolic_velocity_circumferential_10) <- "Peak Systolic Velocity Circumferential 10"
label(data$peak_systolic_velocity_circumferential_11) <- "Peak Systolic Velocity Circumferential 11"
label(data$peak_systolic_velocity_circumferential_12) <- "Peak Systolic Velocity Circumferential 12"
label(data$peak_systolic_velocity_circumferential_13) <- "Peak Systolic Velocity Circumferential 13"
label(data$peak_systolic_velocity_circumferential_14) <- "Peak Systolic Velocity Circumferential 14"
label(data$peak_systolic_velocity_circumferential_15) <- "Peak Systolic Velocity Circumferential 15"
label(data$peak_systolic_velocity_circumferential_16) <- "Peak Systolic Velocity Circumferential 16"
label(data$basal_peak_systolic_velocity_longitudinal) <- "Basal Peak Systolic Velocity Longitudinal"
label(data$mid_peak_systolic_velocity_longitudinal) <- "Mid Peak Systolic Velocity Longitudinal"
label(data$apical_peak_systolic_velocity_longitudinal) <- "Apical Peak Systolic Velocity Longitudinal"
label(data$global_peak_systolic_velocity_longitudinal) <- "Global Peak Systolic Velocity Longitudinal"
label(data$peak_systolic_velocity_longitudinal_1) <- "Peak Systolic Velocity Longitudinal 1"
label(data$peak_systolic_velocity_longitudinal_2) <- "Peak Systolic Velocity Longitudinal 2"
label(data$peak_systolic_velocity_longitudinal_3) <- "Peak Systolic Velocity Longitudinal 3"
label(data$peak_systolic_velocity_longitudinal_4) <- "Peak Systolic Velocity Longitudinal 4"
label(data$peak_systolic_velocity_longitudinal_5) <- "Peak Systolic Velocity Longitudinal 5"
label(data$peak_systolic_velocity_longitudinal_6) <- "Peak Systolic Velocity Longitudinal 6"
label(data$peak_systolic_velocity_longitudinal_7) <- "Peak Systolic Velocity Longitudinal 7"
label(data$peak_systolic_velocity_longitudinal_8) <- "Peak Systolic Velocity Longitudinal 8"
label(data$peak_systolic_velocity_longitudinal_9) <- "Peak Systolic Velocity Longitudinal 9"
label(data$peak_systolic_velocity_longitudinal_10) <- "Peak Systolic Velocity Longitudinal 10"
label(data$peak_systolic_velocity_longitudinal_11) <- "Peak Systolic Velocity Longitudinal 11"
label(data$peak_systolic_velocity_longitudinal_12) <- "Peak Systolic Velocity Longitudinal 12"
label(data$peak_systolic_velocity_longitudinal_13) <- "Peak Systolic Velocity Longitudinal 13"
label(data$peak_systolic_velocity_longitudinal_14) <- "Peak Systolic Velocity Longitudinal 14"
label(data$peak_systolic_velocity_longitudinal_15) <- "Peak Systolic Velocity Longitudinal 15"
label(data$peak_systolic_velocity_longitudinal_16) <- "Peak Systolic Velocity Longitudinal 16"
label(data$basal_peak_diastolic_velocity_radial) <- "Basal Peak Diastolic Velocity Radial"
label(data$mid_peak_diastolic_velocity_radial) <- "Mid Peak Diastolic Velocity Radial"
label(data$apical_peak_diastolic_velocity_radial) <- "Apical Peak Diastolic Velocity Radial"
label(data$global_peak_diastolic_velocity_radial) <- "Global Peak Diastolic Velocity Radial"
label(data$peak_diastolic_velocity_radial_1) <- "Peak Diastolic Velocity Radial 1"
label(data$peak_diastolic_velocity_radial_2) <- "Peak Diastolic Velocity Radial 2"
label(data$peak_diastolic_velocity_radial_3) <- "Peak Diastolic Velocity Radial 3"
label(data$peak_diastolic_velocity_radial_4) <- "Peak Diastolic Velocity Radial 4"
label(data$peak_diastolic_velocity_radial_5) <- "Peak Diastolic Velocity Radial 5"
label(data$peak_diastolic_velocity_radial_6) <- "Peak Diastolic Velocity Radial 6"
label(data$peak_diastolic_velocity_radial_7) <- "Peak Diastolic Velocity Radial 7"
label(data$peak_diastolic_velocity_radial_8) <- "Peak Diastolic Velocity Radial 8"
label(data$peak_diastolic_velocity_radial_9) <- "Peak Diastolic Velocity Radial 9"
label(data$peak_diastolic_velocity_radial_10) <- "Peak Diastolic Velocity Radial 10"
label(data$peak_diastolic_velocity_radial_11) <- "Peak Diastolic Velocity Radial 11"
label(data$peak_diastolic_velocity_radial_12) <- "Peak Diastolic Velocity Radial 12"
label(data$peak_diastolic_velocity_radial_13) <- "Peak Diastolic Velocity Radial 13"
label(data$peak_diastolic_velocity_radial_14) <- "Peak Diastolic Velocity Radial 14"
label(data$peak_diastolic_velocity_radial_15) <- "Peak Diastolic Velocity Radial 15"
label(data$peak_diastolic_velocity_radial_16) <- "Peak Diastolic Velocity Radial 16"
label(data$basal_peak_diastolic_velocity_circumferential) <- "Basal Peak Diastolic Velocity Circumferential"
label(data$mid_peak_diastolic_velocity_circumferential) <- "Mid Peak Diastolic Velocity Circumferential"
label(data$apical_peak_diastolic_velocity_circumferential) <- "Apical Peak Diastolic Velocity Circumferential"
label(data$global_peak_diastolic_velocity_circumferential) <- "Global Peak Diastolic Velocity Circumferential"
label(data$peak_diastolic_velocity_circumferential_1) <- "Peak Diastolic Velocity Circumferential 1"
label(data$peak_diastolic_velocity_circumferential_2) <- "Peak Diastolic Velocity Circumferential 2"
label(data$peak_diastolic_velocity_circumferential_3) <- "Peak Diastolic Velocity Circumferential 3"
label(data$peak_diastolic_velocity_circumferential_4) <- "Peak Diastolic Velocity Circumferential 4"
label(data$peak_diastolic_velocity_circumferential_5) <- "Peak Diastolic Velocity Circumferential 5"
label(data$peak_diastolic_velocity_circumferential_6) <- "Peak Diastolic Velocity Circumferential 6"
label(data$peak_diastolic_velocity_circumferential_7) <- "Peak Diastolic Velocity Circumferential 7"
label(data$peak_diastolic_velocity_circumferential_8) <- "Peak Diastolic Velocity Circumferential 8"
label(data$peak_diastolic_velocity_circumferential_9) <- "Peak Diastolic Velocity Circumferential 9"
label(data$peak_diastolic_velocity_circumferential_10) <- "Peak Diastolic Velocity Circumferential 10"
label(data$peak_diastolic_velocity_circumferential_11) <- "Peak Diastolic Velocity Circumferential 11"
label(data$peak_diastolic_velocity_circumferential_12) <- "Peak Diastolic Velocity Circumferential 12"
label(data$peak_diastolic_velocity_circumferential_13) <- "Peak Diastolic Velocity Circumferential 13"
label(data$peak_diastolic_velocity_circumferential_14) <- "Peak Diastolic Velocity Circumferential 14"
label(data$peak_diastolic_velocity_circumferential_15) <- "Peak Diastolic Velocity Circumferential 15"
label(data$peak_diastolic_velocity_circumferential_16) <- "Peak Diastolic Velocity Circumferential 16"
label(data$basal_peak_diastolic_velocity_longitudinal) <- "Basal Peak Diastolic Velocity Longitudinal"
label(data$mid_peak_diastolic_velocity_longitudinal) <- "Mid Peak Diastolic Velocity Longitudinal"
label(data$apical_peak_diastolic_velocity_longitudinal) <- "Apical Peak Diastolic Velocity Longitudinal"
label(data$global_peak_diastolic_velocity_longitudinal) <- "Global Peak Diastolic Velocity Longitudinal"
label(data$peak_diastolic_velocity_longitudinal_1) <- "Peak Diastolic Velocity Longitudinal 1"
label(data$peak_diastolic_velocity_longitudinal_2) <- "Peak Diastolic Velocity Longitudinal 2"
label(data$peak_diastolic_velocity_longitudinal_3) <- "Peak Diastolic Velocity Longitudinal 3"
label(data$peak_diastolic_velocity_longitudinal_4) <- "Peak Diastolic Velocity Longitudinal 4"
label(data$peak_diastolic_velocity_longitudinal_5) <- "Peak Diastolic Velocity Longitudinal 5"
label(data$peak_diastolic_velocity_longitudinal_6) <- "Peak Diastolic Velocity Longitudinal 6"
label(data$peak_diastolic_velocity_longitudinal_7) <- "Peak Diastolic Velocity Longitudinal 7"
label(data$peak_diastolic_velocity_longitudinal_8) <- "Peak Diastolic Velocity Longitudinal 8"
label(data$peak_diastolic_velocity_longitudinal_9) <- "Peak Diastolic Velocity Longitudinal 9"
label(data$peak_diastolic_velocity_longitudinal_10) <- "Peak Diastolic Velocity Longitudinal 10"
label(data$peak_diastolic_velocity_longitudinal_11) <- "Peak Diastolic Velocity Longitudinal 11"
label(data$peak_diastolic_velocity_longitudinal_12) <- "Peak Diastolic Velocity Longitudinal 12"
label(data$peak_diastolic_velocity_longitudinal_13) <- "Peak Diastolic Velocity Longitudinal 13"
label(data$peak_diastolic_velocity_longitudinal_14) <- "Peak Diastolic Velocity Longitudinal 14"
label(data$peak_diastolic_velocity_longitudinal_15) <- "Peak Diastolic Velocity Longitudinal 15"
label(data$peak_diastolic_velocity_longitudinal_16) <- "Peak Diastolic Velocity Longitudinal 16"
label(data$cmr_complete) <- "Complete?"
label(data$tx_date) <- "Transplant Date"
label(data$ischemic_time) <- "Ischemic time"
label(data$cause_2) <- "Transplantation Cause"
label(data$etiology_detail) <- "Etiology Detail"
label(data$type_transplant) <- "Type of heart transplantation"
label(data$diabetes_mellitus) <- "Diabetes mellitus "
label(data$hypertension) <- "Hypertension   "
label(data$dyslipidemia) <- "Dyslipidemia  "
label(data$smoking) <- "Smoking  "
label(data$drug_use_abuse) <- "drug use/abuse"
label(data$etoh_use_abuse) <- "etoh use/abuse"
label(data$physical_activity) <- "Physical Activity"
label(data$pad) <- "Peripheral arterial disease"
label(data$pad_site___1) <- "Peripheral arterial disease site (choice <- carotid)"
label(data$pad_site___2) <- "Peripheral arterial disease site (choice <- lower limbs)"
label(data$pad_site___3) <- "Peripheral arterial disease site (choice <- upper limbs)"
label(data$pad_site___4) <- "Peripheral arterial disease site (choice <- aorta)"
label(data$pad_site___5) <- "Peripheral arterial disease site (choice <- mesenteric)"
label(data$pad_site___6) <- "Peripheral arterial disease site (choice <- others)"
label(data$pad_site_text) <- "Peripheral arterial disease site"
label(data$ckd) <- "Chronic kidney disease (eGFR < 60 ml/min)"
label(data$thyroid_disfunction) <- "Thyroid Disfunction"
label(data$previous_bleeding) <- "Previous bleeding requiring medical attention"
label(data$prior_bleeding_site) <- "prior bleeding site before inclusion"
label(data$copd) <- "COPD"
label(data$atrial_fibrillation) <- "Atrial fibrillation"
label(data$pm) <- "PM"
label(data$crt) <- "CRT"
label(data$icd) <- "ICD"
label(data$history_of_vte) <- "History of VTE"
label(data$history_of_cancer) <- "History of Cancer (> 5 years)"
label(data$autoimmune_diseases) <- "Autoimmune Diseases"
label(data$depression) <- "Depression"
label(data$anxiety) <- "Anxiety"
label(data$baseline_complete) <- "Complete?"
label(data$death) <- "Death"
label(data$date_death) <- "Date of death"
label(data$death_fup) <- "Follow-up time to Death"
label(data$cause_of_death) <- "Cause of death"
label(data$rejection) <- "Any Rejection at follow-up"
label(data$howmany_biopsies) <- "Number of Biopsies at Follow-up"
label(data$biopsy_date_1) <- "Biopsy Date (1)"
label(data$ishlt_grade_1) <- "ACR ISHLT Grade for Biopsy 1  "
label(data$amr_grade_1) <- "AMR at Biopsy 1 (AMR)  "
label(data$biopsy_date_2) <- "Biopsy Date (2)"
label(data$ishlt_grade_2) <- "ACR ISHLT Grade for Biopsy 2"
label(data$amr_grade_2) <- "AMR at Biopsy 2"
label(data$biopsy_date_3) <- "Biopsy Date (3)"
label(data$ishlt_grade_3) <- "ACR ISHLT Grade for Biopsy 3"
label(data$amr_grade_3) <- "AMR at Biopsy 3"
label(data$biopsy_date_4) <- "Biopsy Date (4)"
label(data$ishlt_grade_4) <- "ACR ISHLT Grade for Biopsy 4"
label(data$amr_grade_4) <- "AMR at Biopsy 4"
label(data$biopsy_date_5) <- "Biopsy Date (5)"
label(data$ishlt_grade_5) <- "ACR ISHLT Grade for Biopsy 5"
label(data$amr_grade_5) <- "AMR at Biopsy 5"
label(data$biopsy_date_6) <- "Biopsy Date (6)"
label(data$ishlt_grade_6) <- "ACR ACR ISHLT Grade for Biopsy 6"
label(data$amr_grade_6) <- "AMR at Biopsy 6"
label(data$biopsy_date_7) <- "Biopsy Date (7)"
label(data$ishlt_grade_7) <- "ACR ISHLT Grade for Biopsy 7"
label(data$amr_grade_7) <- "AMR at Biopsy 7"
label(data$biopsy_date_8) <- "Biopsy Date (8)"
label(data$ishlt_grade_8) <- "ACR ISHLT Grade for Biopsy 8"
label(data$amr_grade_8) <- "AMR at Biopsy 8"
label(data$angio_available) <- "Coronary Angiography Available"
label(data$angio_date) <- "Angiography date (CAV assessment)"
label(data$cav_angio_grade) <- "CAV ISHLT Grade (angiography)  "
label(data$cav_angio_site___1) <- "CAV Site (angiography) (choice <- RCA)"
label(data$cav_angio_site___2) <- "CAV Site (angiography) (choice <- LM)"
label(data$cav_angio_site___3) <- "CAV Site (angiography) (choice <- LAD)"
label(data$cav_angio_site___4) <- "CAV Site (angiography) (choice <- LCx)"
label(data$pci_performed) <- "PCI perfomed"
label(data$ctca_available) <- "CTCA Available"
label(data$ctca_date) <- "CTCA date (CAV assessment)"
label(data$cav_ctca_grade) <- "CAV grade (CTCA)"
label(data$cav_ctca_site___1) <- "CAV Site (CTCA) (choice <- RCA)"
label(data$cav_ctca_site___2) <- "CAV Site (CTCA) (choice <- LM)"
label(data$cav_ctca_site___3) <- "CAV Site (CTCA) (choice <- LAD)"
label(data$cav_ctca_site___4) <- "CAV Site (CTCA) (choice <- LCx)"
label(data$new_admission_post_cmr) <- "New Admission after CMR"
label(data$new_admission_post_cmr_date) <- "New Admission after CMR Date"
label(data$new_admission_post_cmr_text) <- "New Admission after CMR (free text)"
label(data$hf_diagnosis) <- "Admission for HF"
label(data$hf_diagnosis_date) <- "Admission for HF Date"
label(data$mi_diagnosis) <- "Admission for MI"
label(data$mi_diagnosis_date) <- "Admission for MI Date"
label(data$stroke_diagnosis) <- "Admission for Stroke"
label(data$stroke_diagnosis_date) <- "Admission for Stroke Date"
label(data$endocarditis_diagnosis) <- "Admission for Endocarditis"
label(data$endocarditis_diagnosis_date) <- "Admission for Endocarditis Date"
label(data$events_complete) <- "Complete?"
label(data$hla_ab_index_date) <- "Tissue Typing Date (CMR)"
label(data$hla_ab_index) <- "HLA Ab at time of CMR"
label(data$dsa_index) <- "Donor Specific Ab at time of CMR"
label(data$hla_ab_latest_date) <- "Tissue Typing Date (Follow-up)"
label(data$hla_ab_latest) <- "HLA Ab at follow-up"
label(data$dsa_latest) <- "Donor Specific Ab at follow-up"
label(data$lab_date) <- "Lab Test Date"
label(data$hemoglobin) <- "Hemoglobin"
label(data$plt) <- "Platelets"
label(data$wbc) <- "White blood cells"
label(data$sodium) <- "Sodium"
label(data$creatinine) <- "Creatinine"
label(data$egfr) <- "eGFR"
label(data$glucose) <- "Glucose"
label(data$alt) <- "ALT"
label(data$cholesterol) <- "Total Cholesterol "
label(data$hdl) <- "HDL Cholesterol "
label(data$triglycerides) <- "Triglycerides "
label(data$non_hdl) <- "Non-HDL Cholesterol "
label(data$ldl_cholesterol) <- "LDL Cholesterol "
label(data$glycated_hb) <- "Glycated Hb  "
label(data$lab_complete) <- "Complete?"
#Setting Units


#Setting Factors(will create new variable for factors)
data$gender.factor  <-  factor(data$gender,levels <- c("1","2"))
data$patient_data_complete.factor  <-  factor(data$patient_data_complete,levels <- c("0","1","2"))
data$stressor.factor  <-  factor(data$stressor,levels <- c("1","2"))
data$adenosine_dose.factor  <-  factor(data$adenosine_dose,levels <- c("1","2","3"))
data$stress_symptoms___1.factor  <-  factor(data$stress_symptoms___1,levels <- c("0","1"))
data$stress_symptoms___2.factor  <-  factor(data$stress_symptoms___2,levels <- c("0","1"))
data$stress_symptoms___3.factor  <-  factor(data$stress_symptoms___3,levels <- c("0","1"))
data$stress_symptoms___4.factor  <-  factor(data$stress_symptoms___4,levels <- c("0","1"))
data$stress_symptoms___5.factor  <-  factor(data$stress_symptoms___5,levels <- c("0","1"))
data$qualitative_perfusion_defect_stress_cmr.factor  <-  factor(data$qualitative_perfusion_defect_stress_cmr,levels <- c("1","0"))
data$perfusion_defect_segments_stress_cmr___1.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___1,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___2.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___2,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___3.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___3,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___4.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___4,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___5.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___5,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___6.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___6,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___7.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___7,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___8.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___8,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___9.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___9,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___10.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___10,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___11.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___11,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___12.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___12,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___13.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___13,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___14.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___14,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___15.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___15,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___16.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___16,levels <- c("0","1"))
data$perfusion_defect_segments_stress_cmr___17.factor  <-  factor(data$perfusion_defect_segments_stress_cmr___17,levels <- c("0","1"))
data$death_stress_cmr.factor  <-  factor(data$death_stress_cmr,levels <- c("1","0"))
data$asystole_stress_cmr.factor  <-  factor(data$asystole_stress_cmr,levels <- c("1","0"))
data$sinus_pause_arrest_stress_car.factor  <-  factor(data$sinus_pause_arrest_stress_car,levels <- c("1","0"))
data$high_grade_av_block_stress_cmr.factor  <-  factor(data$high_grade_av_block_stress_cmr,levels <- c("1","0"))
data$vt_vf_stress_cmr.factor  <-  factor(data$vt_vf_stress_cmr,levels <- c("1","0"))
data$af_stress_cmr.factor  <-  factor(data$af_stress_cmr,levels <- c("1","0"))
data$chest_pain_stress_cmr.factor  <-  factor(data$chest_pain_stress_cmr,levels <- c("1","0"))
data$mi_stress_cmr.factor  <-  factor(data$mi_stress_cmr,levels <- c("1","0"))
data$symptomatic_hypotension_stress_cmr.factor  <-  factor(data$symptomatic_hypotension_stress_cmr,levels <- c("1","0"))
data$dyspnea_stress_cmr.factor  <-  factor(data$dyspnea_stress_cmr,levels <- c("1","0"))
data$nausea_stress_cmr.factor  <-  factor(data$nausea_stress_cmr,levels <- c("1","0"))
data$headache_stress_cmr.factor  <-  factor(data$headache_stress_cmr,levels <- c("1","0"))
data$allergic_reaction_stress_cmr.factor  <-  factor(data$allergic_reaction_stress_cmr,levels <- c("1","0"))
data$contrast_extravasation_stress_cmr.factor  <-  factor(data$contrast_extravasation_stress_cmr,levels <- c("1","0"))
data$thrombophlebitis_stress_cmr.factor  <-  factor(data$thrombophlebitis_stress_cmr,levels <- c("1","0"))
data$hospitalization_stress_cmr.factor  <-  factor(data$hospitalization_stress_cmr,levels <- c("1","0"))
data$any_adverse_effect_stress.factor  <-  factor(data$any_adverse_effect_stress,levels <- c("1","0"))
data$stress_cmr_complete.factor  <-  factor(data$stress_cmr_complete,levels <- c("0","1","2"))
data$second_cmr.factor  <-  factor(data$second_cmr,levels <- c("1","0"))
data$third_cmr.factor  <-  factor(data$third_cmr,levels <- c("1","0"))
data$akinesia_cmr.factor  <-  factor(data$akinesia_cmr,levels <- c("1","0"))
data$akinesia_seg_cmr___1.factor  <-  factor(data$akinesia_seg_cmr___1,levels <- c("0","1"))
data$akinesia_seg_cmr___2.factor  <-  factor(data$akinesia_seg_cmr___2,levels <- c("0","1"))
data$akinesia_seg_cmr___3.factor  <-  factor(data$akinesia_seg_cmr___3,levels <- c("0","1"))
data$akinesia_seg_cmr___4.factor  <-  factor(data$akinesia_seg_cmr___4,levels <- c("0","1"))
data$akinesia_seg_cmr___5.factor  <-  factor(data$akinesia_seg_cmr___5,levels <- c("0","1"))
data$akinesia_seg_cmr___6.factor  <-  factor(data$akinesia_seg_cmr___6,levels <- c("0","1"))
data$akinesia_seg_cmr___7.factor  <-  factor(data$akinesia_seg_cmr___7,levels <- c("0","1"))
data$akinesia_seg_cmr___8.factor  <-  factor(data$akinesia_seg_cmr___8,levels <- c("0","1"))
data$akinesia_seg_cmr___9.factor  <-  factor(data$akinesia_seg_cmr___9,levels <- c("0","1"))
data$akinesia_seg_cmr___10.factor  <-  factor(data$akinesia_seg_cmr___10,levels <- c("0","1"))
data$akinesia_seg_cmr___11.factor  <-  factor(data$akinesia_seg_cmr___11,levels <- c("0","1"))
data$akinesia_seg_cmr___12.factor  <-  factor(data$akinesia_seg_cmr___12,levels <- c("0","1"))
data$akinesia_seg_cmr___13.factor  <-  factor(data$akinesia_seg_cmr___13,levels <- c("0","1"))
data$akinesia_seg_cmr___14.factor  <-  factor(data$akinesia_seg_cmr___14,levels <- c("0","1"))
data$akinesia_seg_cmr___15.factor  <-  factor(data$akinesia_seg_cmr___15,levels <- c("0","1"))
data$akinesia_seg_cmr___16.factor  <-  factor(data$akinesia_seg_cmr___16,levels <- c("0","1"))
data$akinesia_seg_cmr___17.factor  <-  factor(data$akinesia_seg_cmr___17,levels <- c("0","1"))
data$hypokinesia_cmr.factor  <-  factor(data$hypokinesia_cmr,levels <- c("1","0"))
data$hypokinesia_seg_cmr___1.factor  <-  factor(data$hypokinesia_seg_cmr___1,levels <- c("0","1"))
data$hypokinesia_seg_cmr___2.factor  <-  factor(data$hypokinesia_seg_cmr___2,levels <- c("0","1"))
data$hypokinesia_seg_cmr___3.factor  <-  factor(data$hypokinesia_seg_cmr___3,levels <- c("0","1"))
data$hypokinesia_seg_cmr___4.factor  <-  factor(data$hypokinesia_seg_cmr___4,levels <- c("0","1"))
data$hypokinesia_seg_cmr___5.factor  <-  factor(data$hypokinesia_seg_cmr___5,levels <- c("0","1"))
data$hypokinesia_seg_cmr___6.factor  <-  factor(data$hypokinesia_seg_cmr___6,levels <- c("0","1"))
data$hypokinesia_seg_cmr___7.factor  <-  factor(data$hypokinesia_seg_cmr___7,levels <- c("0","1"))
data$hypokinesia_seg_cmr___8.factor  <-  factor(data$hypokinesia_seg_cmr___8,levels <- c("0","1"))
data$hypokinesia_seg_cmr___9.factor  <-  factor(data$hypokinesia_seg_cmr___9,levels <- c("0","1"))
data$hypokinesia_seg_cmr___10.factor  <-  factor(data$hypokinesia_seg_cmr___10,levels <- c("0","1"))
data$hypokinesia_seg_cmr___11.factor  <-  factor(data$hypokinesia_seg_cmr___11,levels <- c("0","1"))
data$hypokinesia_seg_cmr___12.factor  <-  factor(data$hypokinesia_seg_cmr___12,levels <- c("0","1"))
data$hypokinesia_seg_cmr___13.factor  <-  factor(data$hypokinesia_seg_cmr___13,levels <- c("0","1"))
data$hypokinesia_seg_cmr___14.factor  <-  factor(data$hypokinesia_seg_cmr___14,levels <- c("0","1"))
data$hypokinesia_seg_cmr___15.factor  <-  factor(data$hypokinesia_seg_cmr___15,levels <- c("0","1"))
data$hypokinesia_seg_cmr___16.factor  <-  factor(data$hypokinesia_seg_cmr___16,levels <- c("0","1"))
data$hypokinesia_seg_cmr___17.factor  <-  factor(data$hypokinesia_seg_cmr___17,levels <- c("0","1"))
data$dyskinesia_cmr.factor  <-  factor(data$dyskinesia_cmr,levels <- c("1","0"))
data$dyskinesia_seg_cmr___1.factor  <-  factor(data$dyskinesia_seg_cmr___1,levels <- c("0","1"))
data$dyskinesia_seg_cmr___2.factor  <-  factor(data$dyskinesia_seg_cmr___2,levels <- c("0","1"))
data$dyskinesia_seg_cmr___3.factor  <-  factor(data$dyskinesia_seg_cmr___3,levels <- c("0","1"))
data$dyskinesia_seg_cmr___4.factor  <-  factor(data$dyskinesia_seg_cmr___4,levels <- c("0","1"))
data$dyskinesia_seg_cmr___5.factor  <-  factor(data$dyskinesia_seg_cmr___5,levels <- c("0","1"))
data$dyskinesia_seg_cmr___6.factor  <-  factor(data$dyskinesia_seg_cmr___6,levels <- c("0","1"))
data$dyskinesia_seg_cmr___7.factor  <-  factor(data$dyskinesia_seg_cmr___7,levels <- c("0","1"))
data$dyskinesia_seg_cmr___8.factor  <-  factor(data$dyskinesia_seg_cmr___8,levels <- c("0","1"))
data$dyskinesia_seg_cmr___9.factor  <-  factor(data$dyskinesia_seg_cmr___9,levels <- c("0","1"))
data$dyskinesia_seg_cmr___10.factor  <-  factor(data$dyskinesia_seg_cmr___10,levels <- c("0","1"))
data$dyskinesia_seg_cmr___11.factor  <-  factor(data$dyskinesia_seg_cmr___11,levels <- c("0","1"))
data$dyskinesia_seg_cmr___12.factor  <-  factor(data$dyskinesia_seg_cmr___12,levels <- c("0","1"))
data$dyskinesia_seg_cmr___13.factor  <-  factor(data$dyskinesia_seg_cmr___13,levels <- c("0","1"))
data$dyskinesia_seg_cmr___14.factor  <-  factor(data$dyskinesia_seg_cmr___14,levels <- c("0","1"))
data$dyskinesia_seg_cmr___15.factor  <-  factor(data$dyskinesia_seg_cmr___15,levels <- c("0","1"))
data$dyskinesia_seg_cmr___16.factor  <-  factor(data$dyskinesia_seg_cmr___16,levels <- c("0","1"))
data$dyskinesia_seg_cmr___17.factor  <-  factor(data$dyskinesia_seg_cmr___17,levels <- c("0","1"))
data$aneurysm_cmr.factor  <-  factor(data$aneurysm_cmr,levels <- c("1","0"))
data$aneurysm_seg_cmr___1.factor  <-  factor(data$aneurysm_seg_cmr___1,levels <- c("0","1"))
data$aneurysm_seg_cmr___2.factor  <-  factor(data$aneurysm_seg_cmr___2,levels <- c("0","1"))
data$aneurysm_seg_cmr___3.factor  <-  factor(data$aneurysm_seg_cmr___3,levels <- c("0","1"))
data$aneurysm_seg_cmr___4.factor  <-  factor(data$aneurysm_seg_cmr___4,levels <- c("0","1"))
data$aneurysm_seg_cmr___5.factor  <-  factor(data$aneurysm_seg_cmr___5,levels <- c("0","1"))
data$aneurysm_seg_cmr___6.factor  <-  factor(data$aneurysm_seg_cmr___6,levels <- c("0","1"))
data$aneurysm_seg_cmr___7.factor  <-  factor(data$aneurysm_seg_cmr___7,levels <- c("0","1"))
data$aneurysm_seg_cmr___8.factor  <-  factor(data$aneurysm_seg_cmr___8,levels <- c("0","1"))
data$aneurysm_seg_cmr___9.factor  <-  factor(data$aneurysm_seg_cmr___9,levels <- c("0","1"))
data$aneurysm_seg_cmr___10.factor  <-  factor(data$aneurysm_seg_cmr___10,levels <- c("0","1"))
data$aneurysm_seg_cmr___11.factor  <-  factor(data$aneurysm_seg_cmr___11,levels <- c("0","1"))
data$aneurysm_seg_cmr___12.factor  <-  factor(data$aneurysm_seg_cmr___12,levels <- c("0","1"))
data$aneurysm_seg_cmr___13.factor  <-  factor(data$aneurysm_seg_cmr___13,levels <- c("0","1"))
data$aneurysm_seg_cmr___14.factor  <-  factor(data$aneurysm_seg_cmr___14,levels <- c("0","1"))
data$aneurysm_seg_cmr___15.factor  <-  factor(data$aneurysm_seg_cmr___15,levels <- c("0","1"))
data$aneurysm_seg_cmr___16.factor  <-  factor(data$aneurysm_seg_cmr___16,levels <- c("0","1"))
data$aneurysm_seg_cmr___17.factor  <-  factor(data$aneurysm_seg_cmr___17,levels <- c("0","1"))
data$thrombus_cmr.factor  <-  factor(data$thrombus_cmr,levels <- c("1","0"))
data$rvwma_cmr.factor  <-  factor(data$rvwma_cmr,levels <- c("1","0"))
data$rvwma1___2.factor  <-  factor(data$rvwma1___2,levels <- c("0","1"))
data$rvwma1___3.factor  <-  factor(data$rvwma1___3,levels <- c("0","1"))
data$rvwma1___4.factor  <-  factor(data$rvwma1___4,levels <- c("0","1"))
data$rvwma2___2.factor  <-  factor(data$rvwma2___2,levels <- c("0","1"))
data$rvwma2___3.factor  <-  factor(data$rvwma2___3,levels <- c("0","1"))
data$rvwma2___4.factor  <-  factor(data$rvwma2___4,levels <- c("0","1"))
data$rvwma3___2.factor  <-  factor(data$rvwma3___2,levels <- c("0","1"))
data$rvwma3___3.factor  <-  factor(data$rvwma3___3,levels <- c("0","1"))
data$rvwma3___4.factor  <-  factor(data$rvwma3___4,levels <- c("0","1"))
data$rvwma4___2.factor  <-  factor(data$rvwma4___2,levels <- c("0","1"))
data$rvwma4___3.factor  <-  factor(data$rvwma4___3,levels <- c("0","1"))
data$rvwma4___4.factor  <-  factor(data$rvwma4___4,levels <- c("0","1"))
data$rvwma5___2.factor  <-  factor(data$rvwma5___2,levels <- c("0","1"))
data$rvwma5___3.factor  <-  factor(data$rvwma5___3,levels <- c("0","1"))
data$rvwma5___4.factor  <-  factor(data$rvwma5___4,levels <- c("0","1"))
data$rvwma6___2.factor  <-  factor(data$rvwma6___2,levels <- c("0","1"))
data$rvwma6___3.factor  <-  factor(data$rvwma6___3,levels <- c("0","1"))
data$rvwma6___4.factor  <-  factor(data$rvwma6___4,levels <- c("0","1"))
data$rvwma7___2.factor  <-  factor(data$rvwma7___2,levels <- c("0","1"))
data$rvwma7___3.factor  <-  factor(data$rvwma7___3,levels <- c("0","1"))
data$rvwma7___4.factor  <-  factor(data$rvwma7___4,levels <- c("0","1"))
data$rvwma8___2.factor  <-  factor(data$rvwma8___2,levels <- c("0","1"))
data$rvwma8___3.factor  <-  factor(data$rvwma8___3,levels <- c("0","1"))
data$rvwma8___4.factor  <-  factor(data$rvwma8___4,levels <- c("0","1"))
data$lge_cmr.factor  <-  factor(data$lge_cmr,levels <- c("1","0"))
data$lge1___1.factor  <-  factor(data$lge1___1,levels <- c("0","1"))
data$lge1___2.factor  <-  factor(data$lge1___2,levels <- c("0","1"))
data$lge1___3.factor  <-  factor(data$lge1___3,levels <- c("0","1"))
data$lge1___4.factor  <-  factor(data$lge1___4,levels <- c("0","1"))
data$lge1___5.factor  <-  factor(data$lge1___5,levels <- c("0","1"))
data$lge2___1.factor  <-  factor(data$lge2___1,levels <- c("0","1"))
data$lge2___2.factor  <-  factor(data$lge2___2,levels <- c("0","1"))
data$lge2___3.factor  <-  factor(data$lge2___3,levels <- c("0","1"))
data$lge2___4.factor  <-  factor(data$lge2___4,levels <- c("0","1"))
data$lge2___5.factor  <-  factor(data$lge2___5,levels <- c("0","1"))
data$lge3___1.factor  <-  factor(data$lge3___1,levels <- c("0","1"))
data$lge3___2.factor  <-  factor(data$lge3___2,levels <- c("0","1"))
data$lge3___3.factor  <-  factor(data$lge3___3,levels <- c("0","1"))
data$lge3___4.factor  <-  factor(data$lge3___4,levels <- c("0","1"))
data$lge3___5.factor  <-  factor(data$lge3___5,levels <- c("0","1"))
data$lge4___1.factor  <-  factor(data$lge4___1,levels <- c("0","1"))
data$lge4___2.factor  <-  factor(data$lge4___2,levels <- c("0","1"))
data$lge4___3.factor  <-  factor(data$lge4___3,levels <- c("0","1"))
data$lge4___4.factor  <-  factor(data$lge4___4,levels <- c("0","1"))
data$lge4___5.factor  <-  factor(data$lge4___5,levels <- c("0","1"))
data$lge5___1.factor  <-  factor(data$lge5___1,levels <- c("0","1"))
data$lge5___2.factor  <-  factor(data$lge5___2,levels <- c("0","1"))
data$lge5___3.factor  <-  factor(data$lge5___3,levels <- c("0","1"))
data$lge5___4.factor  <-  factor(data$lge5___4,levels <- c("0","1"))
data$lge5___5.factor  <-  factor(data$lge5___5,levels <- c("0","1"))
data$lge6___1.factor  <-  factor(data$lge6___1,levels <- c("0","1"))
data$lge6___2.factor  <-  factor(data$lge6___2,levels <- c("0","1"))
data$lge6___3.factor  <-  factor(data$lge6___3,levels <- c("0","1"))
data$lge6___4.factor  <-  factor(data$lge6___4,levels <- c("0","1"))
data$lge6___5.factor  <-  factor(data$lge6___5,levels <- c("0","1"))
data$lge7___1.factor  <-  factor(data$lge7___1,levels <- c("0","1"))
data$lge7___2.factor  <-  factor(data$lge7___2,levels <- c("0","1"))
data$lge7___3.factor  <-  factor(data$lge7___3,levels <- c("0","1"))
data$lge7___4.factor  <-  factor(data$lge7___4,levels <- c("0","1"))
data$lge7___5.factor  <-  factor(data$lge7___5,levels <- c("0","1"))
data$lge8___1.factor  <-  factor(data$lge8___1,levels <- c("0","1"))
data$lge8___2.factor  <-  factor(data$lge8___2,levels <- c("0","1"))
data$lge8___3.factor  <-  factor(data$lge8___3,levels <- c("0","1"))
data$lge8___4.factor  <-  factor(data$lge8___4,levels <- c("0","1"))
data$lge8___5.factor  <-  factor(data$lge8___5,levels <- c("0","1"))
data$lge9___1.factor  <-  factor(data$lge9___1,levels <- c("0","1"))
data$lge9___2.factor  <-  factor(data$lge9___2,levels <- c("0","1"))
data$lge9___3.factor  <-  factor(data$lge9___3,levels <- c("0","1"))
data$lge9___4.factor  <-  factor(data$lge9___4,levels <- c("0","1"))
data$lge9___5.factor  <-  factor(data$lge9___5,levels <- c("0","1"))
data$lge10___1.factor  <-  factor(data$lge10___1,levels <- c("0","1"))
data$lge10___2.factor  <-  factor(data$lge10___2,levels <- c("0","1"))
data$lge10___3.factor  <-  factor(data$lge10___3,levels <- c("0","1"))
data$lge10___4.factor  <-  factor(data$lge10___4,levels <- c("0","1"))
data$lge10___5.factor  <-  factor(data$lge10___5,levels <- c("0","1"))
data$lge11___1.factor  <-  factor(data$lge11___1,levels <- c("0","1"))
data$lge11___2.factor  <-  factor(data$lge11___2,levels <- c("0","1"))
data$lge11___3.factor  <-  factor(data$lge11___3,levels <- c("0","1"))
data$lge11___4.factor  <-  factor(data$lge11___4,levels <- c("0","1"))
data$lge11___5.factor  <-  factor(data$lge11___5,levels <- c("0","1"))
data$lge12___1.factor  <-  factor(data$lge12___1,levels <- c("0","1"))
data$lge12___2.factor  <-  factor(data$lge12___2,levels <- c("0","1"))
data$lge12___3.factor  <-  factor(data$lge12___3,levels <- c("0","1"))
data$lge12___4.factor  <-  factor(data$lge12___4,levels <- c("0","1"))
data$lge12___5.factor  <-  factor(data$lge12___5,levels <- c("0","1"))
data$lge13___1.factor  <-  factor(data$lge13___1,levels <- c("0","1"))
data$lge13___2.factor  <-  factor(data$lge13___2,levels <- c("0","1"))
data$lge13___3.factor  <-  factor(data$lge13___3,levels <- c("0","1"))
data$lge13___4.factor  <-  factor(data$lge13___4,levels <- c("0","1"))
data$lge13___5.factor  <-  factor(data$lge13___5,levels <- c("0","1"))
data$lge14___1.factor  <-  factor(data$lge14___1,levels <- c("0","1"))
data$lge14___2.factor  <-  factor(data$lge14___2,levels <- c("0","1"))
data$lge14___3.factor  <-  factor(data$lge14___3,levels <- c("0","1"))
data$lge14___4.factor  <-  factor(data$lge14___4,levels <- c("0","1"))
data$lge14___5.factor  <-  factor(data$lge14___5,levels <- c("0","1"))
data$lge15___1.factor  <-  factor(data$lge15___1,levels <- c("0","1"))
data$lge15___2.factor  <-  factor(data$lge15___2,levels <- c("0","1"))
data$lge15___3.factor  <-  factor(data$lge15___3,levels <- c("0","1"))
data$lge15___4.factor  <-  factor(data$lge15___4,levels <- c("0","1"))
data$lge15___5.factor  <-  factor(data$lge15___5,levels <- c("0","1"))
data$lge16___1.factor  <-  factor(data$lge16___1,levels <- c("0","1"))
data$lge16___2.factor  <-  factor(data$lge16___2,levels <- c("0","1"))
data$lge16___3.factor  <-  factor(data$lge16___3,levels <- c("0","1"))
data$lge16___4.factor  <-  factor(data$lge16___4,levels <- c("0","1"))
data$lge16___5.factor  <-  factor(data$lge16___5,levels <- c("0","1"))
data$lge17___1.factor  <-  factor(data$lge17___1,levels <- c("0","1"))
data$lge17___2.factor  <-  factor(data$lge17___2,levels <- c("0","1"))
data$lge17___3.factor  <-  factor(data$lge17___3,levels <- c("0","1"))
data$lge17___4.factor  <-  factor(data$lge17___4,levels <- c("0","1"))
data$lge17___5.factor  <-  factor(data$lge17___5,levels <- c("0","1"))
data$rvlge_cmr.factor  <-  factor(data$rvlge_cmr,levels <- c("1","0"))
data$rvlge_location_cmr___1.factor  <-  factor(data$rvlge_location_cmr___1,levels <- c("0","1"))
data$rvlge_location_cmr___2.factor  <-  factor(data$rvlge_location_cmr___2,levels <- c("0","1"))
data$rvlge_location_cmr___3.factor  <-  factor(data$rvlge_location_cmr___3,levels <- c("0","1"))
data$rvlge_location_cmr___4.factor  <-  factor(data$rvlge_location_cmr___4,levels <- c("0","1"))
data$rvlge_location_cmr___5.factor  <-  factor(data$rvlge_location_cmr___5,levels <- c("0","1"))
data$rvlge_location_cmr___6.factor  <-  factor(data$rvlge_location_cmr___6,levels <- c("0","1"))
data$rvlge_location_cmr___7.factor  <-  factor(data$rvlge_location_cmr___7,levels <- c("0","1"))
data$rvlge_location_cmr___8.factor  <-  factor(data$rvlge_location_cmr___8,levels <- c("0","1"))
data$t1_mapping_elevated_cmr.factor  <-  factor(data$t1_mapping_elevated_cmr,levels <- c("1","0"))
data$high_t1_location_cmr___1.factor  <-  factor(data$high_t1_location_cmr___1,levels <- c("0","1"))
data$high_t1_location_cmr___2.factor  <-  factor(data$high_t1_location_cmr___2,levels <- c("0","1"))
data$high_t1_location_cmr___3.factor  <-  factor(data$high_t1_location_cmr___3,levels <- c("0","1"))
data$high_t1_location_cmr___4.factor  <-  factor(data$high_t1_location_cmr___4,levels <- c("0","1"))
data$high_t1_location_cmr___5.factor  <-  factor(data$high_t1_location_cmr___5,levels <- c("0","1"))
data$high_t1_location_cmr___6.factor  <-  factor(data$high_t1_location_cmr___6,levels <- c("0","1"))
data$high_t1_location_cmr___7.factor  <-  factor(data$high_t1_location_cmr___7,levels <- c("0","1"))
data$high_t1_location_cmr___8.factor  <-  factor(data$high_t1_location_cmr___8,levels <- c("0","1"))
data$high_t1_location_cmr___9.factor  <-  factor(data$high_t1_location_cmr___9,levels <- c("0","1"))
data$high_t1_location_cmr___10.factor  <-  factor(data$high_t1_location_cmr___10,levels <- c("0","1"))
data$high_t1_location_cmr___11.factor  <-  factor(data$high_t1_location_cmr___11,levels <- c("0","1"))
data$high_t1_location_cmr___12.factor  <-  factor(data$high_t1_location_cmr___12,levels <- c("0","1"))
data$high_t1_location_cmr___13.factor  <-  factor(data$high_t1_location_cmr___13,levels <- c("0","1"))
data$high_t1_location_cmr___14.factor  <-  factor(data$high_t1_location_cmr___14,levels <- c("0","1"))
data$high_t1_location_cmr___15.factor  <-  factor(data$high_t1_location_cmr___15,levels <- c("0","1"))
data$high_t1_location_cmr___16.factor  <-  factor(data$high_t1_location_cmr___16,levels <- c("0","1"))
data$high_t1_location_cmr___17.factor  <-  factor(data$high_t1_location_cmr___17,levels <- c("0","1"))
data$stir_oedema_presence_cmr.factor  <-  factor(data$stir_oedema_presence_cmr,levels <- c("1","0"))
data$oedema1___1.factor  <-  factor(data$oedema1___1,levels <- c("0","1"))
data$oedema1___2.factor  <-  factor(data$oedema1___2,levels <- c("0","1"))
data$oedema1___3.factor  <-  factor(data$oedema1___3,levels <- c("0","1"))
data$oedema1___4.factor  <-  factor(data$oedema1___4,levels <- c("0","1"))
data$oedema2___1.factor  <-  factor(data$oedema2___1,levels <- c("0","1"))
data$oedema2___2.factor  <-  factor(data$oedema2___2,levels <- c("0","1"))
data$oedema2___3.factor  <-  factor(data$oedema2___3,levels <- c("0","1"))
data$oedema2___4.factor  <-  factor(data$oedema2___4,levels <- c("0","1"))
data$oedema3___1.factor  <-  factor(data$oedema3___1,levels <- c("0","1"))
data$oedema3___2.factor  <-  factor(data$oedema3___2,levels <- c("0","1"))
data$oedema3___3.factor  <-  factor(data$oedema3___3,levels <- c("0","1"))
data$oedema3___4.factor  <-  factor(data$oedema3___4,levels <- c("0","1"))
data$oedema4___1.factor  <-  factor(data$oedema4___1,levels <- c("0","1"))
data$oedema4___2.factor  <-  factor(data$oedema4___2,levels <- c("0","1"))
data$oedema4___3.factor  <-  factor(data$oedema4___3,levels <- c("0","1"))
data$oedema4___4.factor  <-  factor(data$oedema4___4,levels <- c("0","1"))
data$oedema5___1.factor  <-  factor(data$oedema5___1,levels <- c("0","1"))
data$oedema5___2.factor  <-  factor(data$oedema5___2,levels <- c("0","1"))
data$oedema5___3.factor  <-  factor(data$oedema5___3,levels <- c("0","1"))
data$oedema5___4.factor  <-  factor(data$oedema5___4,levels <- c("0","1"))
data$oedema6___1.factor  <-  factor(data$oedema6___1,levels <- c("0","1"))
data$oedema6___2.factor  <-  factor(data$oedema6___2,levels <- c("0","1"))
data$oedema6___3.factor  <-  factor(data$oedema6___3,levels <- c("0","1"))
data$oedema6___4.factor  <-  factor(data$oedema6___4,levels <- c("0","1"))
data$oedema7___1.factor  <-  factor(data$oedema7___1,levels <- c("0","1"))
data$oedema7___2.factor  <-  factor(data$oedema7___2,levels <- c("0","1"))
data$oedema7___3.factor  <-  factor(data$oedema7___3,levels <- c("0","1"))
data$oedema7___4.factor  <-  factor(data$oedema7___4,levels <- c("0","1"))
data$oedema8___1.factor  <-  factor(data$oedema8___1,levels <- c("0","1"))
data$oedema8___2.factor  <-  factor(data$oedema8___2,levels <- c("0","1"))
data$oedema8___3.factor  <-  factor(data$oedema8___3,levels <- c("0","1"))
data$oedema8___4.factor  <-  factor(data$oedema8___4,levels <- c("0","1"))
data$oedema9___1.factor  <-  factor(data$oedema9___1,levels <- c("0","1"))
data$oedema9___2.factor  <-  factor(data$oedema9___2,levels <- c("0","1"))
data$oedema9___3.factor  <-  factor(data$oedema9___3,levels <- c("0","1"))
data$oedema9___4.factor  <-  factor(data$oedema9___4,levels <- c("0","1"))
data$oedema10___1.factor  <-  factor(data$oedema10___1,levels <- c("0","1"))
data$oedema10___2.factor  <-  factor(data$oedema10___2,levels <- c("0","1"))
data$oedema10___3.factor  <-  factor(data$oedema10___3,levels <- c("0","1"))
data$oedema10___4.factor  <-  factor(data$oedema10___4,levels <- c("0","1"))
data$oedema11___1.factor  <-  factor(data$oedema11___1,levels <- c("0","1"))
data$oedema11___2.factor  <-  factor(data$oedema11___2,levels <- c("0","1"))
data$oedema11___3.factor  <-  factor(data$oedema11___3,levels <- c("0","1"))
data$oedema11___4.factor  <-  factor(data$oedema11___4,levels <- c("0","1"))
data$oedema12___1.factor  <-  factor(data$oedema12___1,levels <- c("0","1"))
data$oedema12___2.factor  <-  factor(data$oedema12___2,levels <- c("0","1"))
data$oedema12___3.factor  <-  factor(data$oedema12___3,levels <- c("0","1"))
data$oedema12___4.factor  <-  factor(data$oedema12___4,levels <- c("0","1"))
data$oedema13___1.factor  <-  factor(data$oedema13___1,levels <- c("0","1"))
data$oedema13___2.factor  <-  factor(data$oedema13___2,levels <- c("0","1"))
data$oedema13___3.factor  <-  factor(data$oedema13___3,levels <- c("0","1"))
data$oedema13___4.factor  <-  factor(data$oedema13___4,levels <- c("0","1"))
data$oedema14___1.factor  <-  factor(data$oedema14___1,levels <- c("0","1"))
data$oedema14___2.factor  <-  factor(data$oedema14___2,levels <- c("0","1"))
data$oedema14___3.factor  <-  factor(data$oedema14___3,levels <- c("0","1"))
data$oedema14___4.factor  <-  factor(data$oedema14___4,levels <- c("0","1"))
data$oedema15___1.factor  <-  factor(data$oedema15___1,levels <- c("0","1"))
data$oedema15___2.factor  <-  factor(data$oedema15___2,levels <- c("0","1"))
data$oedema15___3.factor  <-  factor(data$oedema15___3,levels <- c("0","1"))
data$oedema15___4.factor  <-  factor(data$oedema15___4,levels <- c("0","1"))
data$oedema16___1.factor  <-  factor(data$oedema16___1,levels <- c("0","1"))
data$oedema16___2.factor  <-  factor(data$oedema16___2,levels <- c("0","1"))
data$oedema16___3.factor  <-  factor(data$oedema16___3,levels <- c("0","1"))
data$oedema16___4.factor  <-  factor(data$oedema16___4,levels <- c("0","1"))
data$oedema17___1.factor  <-  factor(data$oedema17___1,levels <- c("0","1"))
data$oedema17___2.factor  <-  factor(data$oedema17___2,levels <- c("0","1"))
data$oedema17___3.factor  <-  factor(data$oedema17___3,levels <- c("0","1"))
data$oedema17___4.factor  <-  factor(data$oedema17___4,levels <- c("0","1"))
data$t2_mapping_elevated_cmr.factor  <-  factor(data$t2_mapping_elevated_cmr,levels <- c("1","0"))
data$high_t2_location_cmr___1.factor  <-  factor(data$high_t2_location_cmr___1,levels <- c("0","1"))
data$high_t2_location_cmr___2.factor  <-  factor(data$high_t2_location_cmr___2,levels <- c("0","1"))
data$high_t2_location_cmr___3.factor  <-  factor(data$high_t2_location_cmr___3,levels <- c("0","1"))
data$high_t2_location_cmr___4.factor  <-  factor(data$high_t2_location_cmr___4,levels <- c("0","1"))
data$high_t2_location_cmr___5.factor  <-  factor(data$high_t2_location_cmr___5,levels <- c("0","1"))
data$high_t2_location_cmr___6.factor  <-  factor(data$high_t2_location_cmr___6,levels <- c("0","1"))
data$high_t2_location_cmr___7.factor  <-  factor(data$high_t2_location_cmr___7,levels <- c("0","1"))
data$high_t2_location_cmr___8.factor  <-  factor(data$high_t2_location_cmr___8,levels <- c("0","1"))
data$high_t2_location_cmr___9.factor  <-  factor(data$high_t2_location_cmr___9,levels <- c("0","1"))
data$high_t2_location_cmr___10.factor  <-  factor(data$high_t2_location_cmr___10,levels <- c("0","1"))
data$high_t2_location_cmr___11.factor  <-  factor(data$high_t2_location_cmr___11,levels <- c("0","1"))
data$high_t2_location_cmr___12.factor  <-  factor(data$high_t2_location_cmr___12,levels <- c("0","1"))
data$high_t2_location_cmr___13.factor  <-  factor(data$high_t2_location_cmr___13,levels <- c("0","1"))
data$high_t2_location_cmr___14.factor  <-  factor(data$high_t2_location_cmr___14,levels <- c("0","1"))
data$high_t2_location_cmr___15.factor  <-  factor(data$high_t2_location_cmr___15,levels <- c("0","1"))
data$high_t2_location_cmr___16.factor  <-  factor(data$high_t2_location_cmr___16,levels <- c("0","1"))
data$high_t2_location_cmr___17.factor  <-  factor(data$high_t2_location_cmr___17,levels <- c("0","1"))
data$pericardial_oedema_cmr.factor  <-  factor(data$pericardial_oedema_cmr,levels <- c("1","0"))
data$pericardial_lge_cmr.factor  <-  factor(data$pericardial_lge_cmr,levels <- c("1","0"))
data$vers_peri_cmr.factor  <-  factor(data$vers_peri_cmr,levels <- c("1","0"))
data$mr_cmr.factor  <-  factor(data$mr_cmr,levels <- c("1","0"))
data$tr_cmr.factor  <-  factor(data$tr_cmr,levels <- c("1","0"))
data$cmr_complete.factor  <-  factor(data$cmr_complete,levels <- c("0","1","2"))
data$cause_2.factor  <-  factor(data$cause_2,levels <- c("1","2","3","4","5","6","7","8","9","10","11","12"))
data$type_transplant.factor  <-  factor(data$type_transplant,levels <- c("1","2","3"))
data$diabetes_mellitus.factor  <-  factor(data$diabetes_mellitus,levels <- c("1","0"))
data$hypertension.factor  <-  factor(data$hypertension,levels <- c("1","0"))
data$dyslipidemia.factor  <-  factor(data$dyslipidemia,levels <- c("1","0"))
data$smoking.factor  <-  factor(data$smoking,levels <- c("1","2","3"))
data$drug_use_abuse.factor  <-  factor(data$drug_use_abuse,levels <- c("1","2","3"))
data$etoh_use_abuse.factor  <-  factor(data$etoh_use_abuse,levels <- c("1","2","3"))
data$physical_activity.factor  <-  factor(data$physical_activity,levels <- c("1","2","3","4","5","6"))
data$pad.factor  <-  factor(data$pad,levels <- c("1","0"))
data$pad_site___1.factor  <-  factor(data$pad_site___1,levels <- c("0","1"))
data$pad_site___2.factor  <-  factor(data$pad_site___2,levels <- c("0","1"))
data$pad_site___3.factor  <-  factor(data$pad_site___3,levels <- c("0","1"))
data$pad_site___4.factor  <-  factor(data$pad_site___4,levels <- c("0","1"))
data$pad_site___5.factor  <-  factor(data$pad_site___5,levels <- c("0","1"))
data$pad_site___6.factor  <-  factor(data$pad_site___6,levels <- c("0","1"))
data$ckd.factor  <-  factor(data$ckd,levels <- c("1","0"))
data$thyroid_disfunction.factor  <-  factor(data$thyroid_disfunction,levels <- c("1","2","3"))
data$previous_bleeding.factor  <-  factor(data$previous_bleeding,levels <- c("1","0"))
data$copd.factor  <-  factor(data$copd,levels <- c("1","0"))
data$atrial_fibrillation.factor  <-  factor(data$atrial_fibrillation,levels <- c("1","2","3"))
data$pm.factor  <-  factor(data$pm,levels <- c("1","0"))
data$crt.factor  <-  factor(data$crt,levels <- c("1","0"))
data$icd.factor  <-  factor(data$icd,levels <- c("1","0"))
data$history_of_vte.factor  <-  factor(data$history_of_vte,levels <- c("1","0"))
data$history_of_cancer.factor  <-  factor(data$history_of_cancer,levels <- c("1","0"))
data$autoimmune_diseases.factor  <-  factor(data$autoimmune_diseases,levels <- c("1","0"))
data$depression.factor  <-  factor(data$depression,levels <- c("1","0"))
data$anxiety.factor  <-  factor(data$anxiety,levels <- c("1","0"))
data$baseline_complete.factor  <-  factor(data$baseline_complete,levels <- c("0","1","2"))
data$death.factor  <-  factor(data$death,levels <- c("1","0"))
data$cause_of_death.factor  <-  factor(data$cause_of_death,levels <- c("1","2","3","4"))
data$rejection.factor  <-  factor(data$rejection,levels <- c("1","0"))
data$ishlt_grade_1.factor  <-  factor(data$ishlt_grade_1,levels <- c("1","2","3","4"))
data$amr_grade_1.factor  <-  factor(data$amr_grade_1,levels <- c("1","2","3","4","5"))
data$ishlt_grade_2.factor  <-  factor(data$ishlt_grade_2,levels <- c("1","2","3","4"))
data$amr_grade_2.factor  <-  factor(data$amr_grade_2,levels <- c("1","2","3","4","5"))
data$ishlt_grade_3.factor  <-  factor(data$ishlt_grade_3,levels <- c("1","2","3","4"))
data$amr_grade_3.factor  <-  factor(data$amr_grade_3,levels <- c("1","2","3","4","5"))
data$ishlt_grade_4.factor  <-  factor(data$ishlt_grade_4,levels <- c("1","2","3","4"))
data$amr_grade_4.factor  <-  factor(data$amr_grade_4,levels <- c("1","2","3","4","5"))
data$ishlt_grade_5.factor  <-  factor(data$ishlt_grade_5,levels <- c("1","2","3","4"))
data$amr_grade_5.factor  <-  factor(data$amr_grade_5,levels <- c("1","2","3","4","5"))
data$ishlt_grade_6.factor  <-  factor(data$ishlt_grade_6,levels <- c("1","2","3","4"))
data$amr_grade_6.factor  <-  factor(data$amr_grade_6,levels <- c("1","2","3","4","5"))
data$ishlt_grade_7.factor  <-  factor(data$ishlt_grade_7,levels <- c("1","2","3","4"))
data$amr_grade_7.factor  <-  factor(data$amr_grade_7,levels <- c("1","2","3","4","5"))
data$ishlt_grade_8.factor  <-  factor(data$ishlt_grade_8,levels <- c("1","2","3","4"))
data$amr_grade_8.factor  <-  factor(data$amr_grade_8,levels <- c("1","2","3","4","5"))
data$angio_available.factor  <-  factor(data$angio_available,levels <- c("1","0"))
data$cav_angio_grade.factor  <-  factor(data$cav_angio_grade,levels <- c("1","2","3","4"))
data$cav_angio_site___1.factor  <-  factor(data$cav_angio_site___1,levels <- c("0","1"))
data$cav_angio_site___2.factor  <-  factor(data$cav_angio_site___2,levels <- c("0","1"))
data$cav_angio_site___3.factor  <-  factor(data$cav_angio_site___3,levels <- c("0","1"))
data$cav_angio_site___4.factor  <-  factor(data$cav_angio_site___4,levels <- c("0","1"))
data$pci_performed.factor  <-  factor(data$pci_performed,levels <- c("1","0"))
data$ctca_available.factor  <-  factor(data$ctca_available,levels <- c("1","0"))
data$cav_ctca_grade.factor  <-  factor(data$cav_ctca_grade,levels <- c("1","2","3","4"))
data$cav_ctca_site___1.factor  <-  factor(data$cav_ctca_site___1,levels <- c("0","1"))
data$cav_ctca_site___2.factor  <-  factor(data$cav_ctca_site___2,levels <- c("0","1"))
data$cav_ctca_site___3.factor  <-  factor(data$cav_ctca_site___3,levels <- c("0","1"))
data$cav_ctca_site___4.factor  <-  factor(data$cav_ctca_site___4,levels <- c("0","1"))
data$new_admission_post_cmr.factor  <-  factor(data$new_admission_post_cmr,levels <- c("1","0"))
data$hf_diagnosis.factor  <-  factor(data$hf_diagnosis,levels <- c("1","0"))
data$mi_diagnosis.factor  <-  factor(data$mi_diagnosis,levels <- c("1","0"))
data$stroke_diagnosis.factor  <-  factor(data$stroke_diagnosis,levels <- c("1","0"))
data$endocarditis_diagnosis.factor  <-  factor(data$endocarditis_diagnosis,levels <- c("1","0"))
data$events_complete.factor  <-  factor(data$events_complete,levels <- c("0","1","2"))
data$hla_ab_index.factor  <-  factor(data$hla_ab_index,levels <- c("1","0"))
data$dsa_index.factor  <-  factor(data$dsa_index,levels <- c("1","0"))
data$hla_ab_latest.factor  <-  factor(data$hla_ab_latest,levels <- c("1","0"))
data$dsa_latest.factor  <-  factor(data$dsa_latest,levels <- c("1","0"))
data$lab_complete.factor  <-  factor(data$lab_complete,levels <- c("0","1","2"))

levels(data$gender.factor) <- c("Male","Female")
levels(data$patient_data_complete.factor) <- c("Incomplete","Unverified","Complete")
levels(data$stressor.factor) <- c("adenosine","regadenoson")
levels(data$adenosine_dose.factor) <- c("140","180","210")
levels(data$stress_symptoms___1.factor) <- c("Unchecked","Checked")
levels(data$stress_symptoms___2.factor) <- c("Unchecked","Checked")
levels(data$stress_symptoms___3.factor) <- c("Unchecked","Checked")
levels(data$stress_symptoms___4.factor) <- c("Unchecked","Checked")
levels(data$stress_symptoms___5.factor) <- c("Unchecked","Checked")
levels(data$qualitative_perfusion_defect_stress_cmr.factor) <- c("Yes","No")
levels(data$perfusion_defect_segments_stress_cmr___1.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___2.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___3.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___4.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___5.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___6.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___7.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___8.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___9.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___10.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___11.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___12.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___13.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___14.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___15.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___16.factor) <- c("Unchecked","Checked")
levels(data$perfusion_defect_segments_stress_cmr___17.factor) <- c("Unchecked","Checked")
levels(data$death_stress_cmr.factor) <- c("Yes","No")
levels(data$asystole_stress_cmr.factor) <- c("Yes","No")
levels(data$sinus_pause_arrest_stress_car.factor) <- c("Yes","No")
levels(data$high_grade_av_block_stress_cmr.factor) <- c("Yes","No")
levels(data$vt_vf_stress_cmr.factor) <- c("Yes","No")
levels(data$af_stress_cmr.factor) <- c("Yes","No")
levels(data$chest_pain_stress_cmr.factor) <- c("Yes","No")
levels(data$mi_stress_cmr.factor) <- c("Yes","No")
levels(data$symptomatic_hypotension_stress_cmr.factor) <- c("Yes","No")
levels(data$dyspnea_stress_cmr.factor) <- c("Yes","No")
levels(data$nausea_stress_cmr.factor) <- c("Yes","No")
levels(data$headache_stress_cmr.factor) <- c("Yes","No")
levels(data$allergic_reaction_stress_cmr.factor) <- c("Yes","No")
levels(data$contrast_extravasation_stress_cmr.factor) <- c("Yes","No")
levels(data$thrombophlebitis_stress_cmr.factor) <- c("Yes","No")
levels(data$hospitalization_stress_cmr.factor) <- c("Yes","No")
levels(data$any_adverse_effect_stress.factor) <- c("Yes","No")
levels(data$stress_cmr_complete.factor) <- c("Incomplete","Unverified","Complete")
levels(data$second_cmr.factor) <- c("Yes","No")
levels(data$third_cmr.factor) <- c("Yes","No")
levels(data$akinesia_cmr.factor) <- c("Yes","No")
levels(data$akinesia_seg_cmr___1.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___2.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___3.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___4.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___5.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___6.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___7.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___8.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___9.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___10.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___11.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___12.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___13.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___14.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___15.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___16.factor) <- c("Unchecked","Checked")
levels(data$akinesia_seg_cmr___17.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_cmr.factor) <- c("Yes","No")
levels(data$hypokinesia_seg_cmr___1.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___2.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___3.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___4.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___5.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___6.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___7.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___8.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___9.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___10.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___11.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___12.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___13.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___14.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___15.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___16.factor) <- c("Unchecked","Checked")
levels(data$hypokinesia_seg_cmr___17.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_cmr.factor) <- c("Yes","No")
levels(data$dyskinesia_seg_cmr___1.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___2.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___3.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___4.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___5.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___6.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___7.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___8.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___9.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___10.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___11.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___12.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___13.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___14.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___15.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___16.factor) <- c("Unchecked","Checked")
levels(data$dyskinesia_seg_cmr___17.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_cmr.factor) <- c("Yes","No")
levels(data$aneurysm_seg_cmr___1.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___2.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___3.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___4.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___5.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___6.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___7.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___8.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___9.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___10.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___11.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___12.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___13.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___14.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___15.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___16.factor) <- c("Unchecked","Checked")
levels(data$aneurysm_seg_cmr___17.factor) <- c("Unchecked","Checked")
levels(data$thrombus_cmr.factor) <- c("Yes","No")
levels(data$rvwma_cmr.factor) <- c("Yes","No")
levels(data$rvwma1___2.factor) <- c("Unchecked","Checked")
levels(data$rvwma1___3.factor) <- c("Unchecked","Checked")
levels(data$rvwma1___4.factor) <- c("Unchecked","Checked")
levels(data$rvwma2___2.factor) <- c("Unchecked","Checked")
levels(data$rvwma2___3.factor) <- c("Unchecked","Checked")
levels(data$rvwma2___4.factor) <- c("Unchecked","Checked")
levels(data$rvwma3___2.factor) <- c("Unchecked","Checked")
levels(data$rvwma3___3.factor) <- c("Unchecked","Checked")
levels(data$rvwma3___4.factor) <- c("Unchecked","Checked")
levels(data$rvwma4___2.factor) <- c("Unchecked","Checked")
levels(data$rvwma4___3.factor) <- c("Unchecked","Checked")
levels(data$rvwma4___4.factor) <- c("Unchecked","Checked")
levels(data$rvwma5___2.factor) <- c("Unchecked","Checked")
levels(data$rvwma5___3.factor) <- c("Unchecked","Checked")
levels(data$rvwma5___4.factor) <- c("Unchecked","Checked")
levels(data$rvwma6___2.factor) <- c("Unchecked","Checked")
levels(data$rvwma6___3.factor) <- c("Unchecked","Checked")
levels(data$rvwma6___4.factor) <- c("Unchecked","Checked")
levels(data$rvwma7___2.factor) <- c("Unchecked","Checked")
levels(data$rvwma7___3.factor) <- c("Unchecked","Checked")
levels(data$rvwma7___4.factor) <- c("Unchecked","Checked")
levels(data$rvwma8___2.factor) <- c("Unchecked","Checked")
levels(data$rvwma8___3.factor) <- c("Unchecked","Checked")
levels(data$rvwma8___4.factor) <- c("Unchecked","Checked")
levels(data$lge_cmr.factor) <- c("Yes","No")
levels(data$lge1___1.factor) <- c("Unchecked","Checked")
levels(data$lge1___2.factor) <- c("Unchecked","Checked")
levels(data$lge1___3.factor) <- c("Unchecked","Checked")
levels(data$lge1___4.factor) <- c("Unchecked","Checked")
levels(data$lge1___5.factor) <- c("Unchecked","Checked")
levels(data$lge2___1.factor) <- c("Unchecked","Checked")
levels(data$lge2___2.factor) <- c("Unchecked","Checked")
levels(data$lge2___3.factor) <- c("Unchecked","Checked")
levels(data$lge2___4.factor) <- c("Unchecked","Checked")
levels(data$lge2___5.factor) <- c("Unchecked","Checked")
levels(data$lge3___1.factor) <- c("Unchecked","Checked")
levels(data$lge3___2.factor) <- c("Unchecked","Checked")
levels(data$lge3___3.factor) <- c("Unchecked","Checked")
levels(data$lge3___4.factor) <- c("Unchecked","Checked")
levels(data$lge3___5.factor) <- c("Unchecked","Checked")
levels(data$lge4___1.factor) <- c("Unchecked","Checked")
levels(data$lge4___2.factor) <- c("Unchecked","Checked")
levels(data$lge4___3.factor) <- c("Unchecked","Checked")
levels(data$lge4___4.factor) <- c("Unchecked","Checked")
levels(data$lge4___5.factor) <- c("Unchecked","Checked")
levels(data$lge5___1.factor) <- c("Unchecked","Checked")
levels(data$lge5___2.factor) <- c("Unchecked","Checked")
levels(data$lge5___3.factor) <- c("Unchecked","Checked")
levels(data$lge5___4.factor) <- c("Unchecked","Checked")
levels(data$lge5___5.factor) <- c("Unchecked","Checked")
levels(data$lge6___1.factor) <- c("Unchecked","Checked")
levels(data$lge6___2.factor) <- c("Unchecked","Checked")
levels(data$lge6___3.factor) <- c("Unchecked","Checked")
levels(data$lge6___4.factor) <- c("Unchecked","Checked")
levels(data$lge6___5.factor) <- c("Unchecked","Checked")
levels(data$lge7___1.factor) <- c("Unchecked","Checked")
levels(data$lge7___2.factor) <- c("Unchecked","Checked")
levels(data$lge7___3.factor) <- c("Unchecked","Checked")
levels(data$lge7___4.factor) <- c("Unchecked","Checked")
levels(data$lge7___5.factor) <- c("Unchecked","Checked")
levels(data$lge8___1.factor) <- c("Unchecked","Checked")
levels(data$lge8___2.factor) <- c("Unchecked","Checked")
levels(data$lge8___3.factor) <- c("Unchecked","Checked")
levels(data$lge8___4.factor) <- c("Unchecked","Checked")
levels(data$lge8___5.factor) <- c("Unchecked","Checked")
levels(data$lge9___1.factor) <- c("Unchecked","Checked")
levels(data$lge9___2.factor) <- c("Unchecked","Checked")
levels(data$lge9___3.factor) <- c("Unchecked","Checked")
levels(data$lge9___4.factor) <- c("Unchecked","Checked")
levels(data$lge9___5.factor) <- c("Unchecked","Checked")
levels(data$lge10___1.factor) <- c("Unchecked","Checked")
levels(data$lge10___2.factor) <- c("Unchecked","Checked")
levels(data$lge10___3.factor) <- c("Unchecked","Checked")
levels(data$lge10___4.factor) <- c("Unchecked","Checked")
levels(data$lge10___5.factor) <- c("Unchecked","Checked")
levels(data$lge11___1.factor) <- c("Unchecked","Checked")
levels(data$lge11___2.factor) <- c("Unchecked","Checked")
levels(data$lge11___3.factor) <- c("Unchecked","Checked")
levels(data$lge11___4.factor) <- c("Unchecked","Checked")
levels(data$lge11___5.factor) <- c("Unchecked","Checked")
levels(data$lge12___1.factor) <- c("Unchecked","Checked")
levels(data$lge12___2.factor) <- c("Unchecked","Checked")
levels(data$lge12___3.factor) <- c("Unchecked","Checked")
levels(data$lge12___4.factor) <- c("Unchecked","Checked")
levels(data$lge12___5.factor) <- c("Unchecked","Checked")
levels(data$lge13___1.factor) <- c("Unchecked","Checked")
levels(data$lge13___2.factor) <- c("Unchecked","Checked")
levels(data$lge13___3.factor) <- c("Unchecked","Checked")
levels(data$lge13___4.factor) <- c("Unchecked","Checked")
levels(data$lge13___5.factor) <- c("Unchecked","Checked")
levels(data$lge14___1.factor) <- c("Unchecked","Checked")
levels(data$lge14___2.factor) <- c("Unchecked","Checked")
levels(data$lge14___3.factor) <- c("Unchecked","Checked")
levels(data$lge14___4.factor) <- c("Unchecked","Checked")
levels(data$lge14___5.factor) <- c("Unchecked","Checked")
levels(data$lge15___1.factor) <- c("Unchecked","Checked")
levels(data$lge15___2.factor) <- c("Unchecked","Checked")
levels(data$lge15___3.factor) <- c("Unchecked","Checked")
levels(data$lge15___4.factor) <- c("Unchecked","Checked")
levels(data$lge15___5.factor) <- c("Unchecked","Checked")
levels(data$lge16___1.factor) <- c("Unchecked","Checked")
levels(data$lge16___2.factor) <- c("Unchecked","Checked")
levels(data$lge16___3.factor) <- c("Unchecked","Checked")
levels(data$lge16___4.factor) <- c("Unchecked","Checked")
levels(data$lge16___5.factor) <- c("Unchecked","Checked")
levels(data$lge17___1.factor) <- c("Unchecked","Checked")
levels(data$lge17___2.factor) <- c("Unchecked","Checked")
levels(data$lge17___3.factor) <- c("Unchecked","Checked")
levels(data$lge17___4.factor) <- c("Unchecked","Checked")
levels(data$lge17___5.factor) <- c("Unchecked","Checked")
levels(data$rvlge_cmr.factor) <- c("Yes","No")
levels(data$rvlge_location_cmr___1.factor) <- c("Unchecked","Checked")
levels(data$rvlge_location_cmr___2.factor) <- c("Unchecked","Checked")
levels(data$rvlge_location_cmr___3.factor) <- c("Unchecked","Checked")
levels(data$rvlge_location_cmr___4.factor) <- c("Unchecked","Checked")
levels(data$rvlge_location_cmr___5.factor) <- c("Unchecked","Checked")
levels(data$rvlge_location_cmr___6.factor) <- c("Unchecked","Checked")
levels(data$rvlge_location_cmr___7.factor) <- c("Unchecked","Checked")
levels(data$rvlge_location_cmr___8.factor) <- c("Unchecked","Checked")
levels(data$t1_mapping_elevated_cmr.factor) <- c("Yes","No")
levels(data$high_t1_location_cmr___1.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___2.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___3.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___4.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___5.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___6.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___7.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___8.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___9.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___10.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___11.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___12.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___13.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___14.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___15.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___16.factor) <- c("Unchecked","Checked")
levels(data$high_t1_location_cmr___17.factor) <- c("Unchecked","Checked")
levels(data$stir_oedema_presence_cmr.factor) <- c("Yes","No")
levels(data$oedema1___1.factor) <- c("Unchecked","Checked")
levels(data$oedema1___2.factor) <- c("Unchecked","Checked")
levels(data$oedema1___3.factor) <- c("Unchecked","Checked")
levels(data$oedema1___4.factor) <- c("Unchecked","Checked")
levels(data$oedema2___1.factor) <- c("Unchecked","Checked")
levels(data$oedema2___2.factor) <- c("Unchecked","Checked")
levels(data$oedema2___3.factor) <- c("Unchecked","Checked")
levels(data$oedema2___4.factor) <- c("Unchecked","Checked")
levels(data$oedema3___1.factor) <- c("Unchecked","Checked")
levels(data$oedema3___2.factor) <- c("Unchecked","Checked")
levels(data$oedema3___3.factor) <- c("Unchecked","Checked")
levels(data$oedema3___4.factor) <- c("Unchecked","Checked")
levels(data$oedema4___1.factor) <- c("Unchecked","Checked")
levels(data$oedema4___2.factor) <- c("Unchecked","Checked")
levels(data$oedema4___3.factor) <- c("Unchecked","Checked")
levels(data$oedema4___4.factor) <- c("Unchecked","Checked")
levels(data$oedema5___1.factor) <- c("Unchecked","Checked")
levels(data$oedema5___2.factor) <- c("Unchecked","Checked")
levels(data$oedema5___3.factor) <- c("Unchecked","Checked")
levels(data$oedema5___4.factor) <- c("Unchecked","Checked")
levels(data$oedema6___1.factor) <- c("Unchecked","Checked")
levels(data$oedema6___2.factor) <- c("Unchecked","Checked")
levels(data$oedema6___3.factor) <- c("Unchecked","Checked")
levels(data$oedema6___4.factor) <- c("Unchecked","Checked")
levels(data$oedema7___1.factor) <- c("Unchecked","Checked")
levels(data$oedema7___2.factor) <- c("Unchecked","Checked")
levels(data$oedema7___3.factor) <- c("Unchecked","Checked")
levels(data$oedema7___4.factor) <- c("Unchecked","Checked")
levels(data$oedema8___1.factor) <- c("Unchecked","Checked")
levels(data$oedema8___2.factor) <- c("Unchecked","Checked")
levels(data$oedema8___3.factor) <- c("Unchecked","Checked")
levels(data$oedema8___4.factor) <- c("Unchecked","Checked")
levels(data$oedema9___1.factor) <- c("Unchecked","Checked")
levels(data$oedema9___2.factor) <- c("Unchecked","Checked")
levels(data$oedema9___3.factor) <- c("Unchecked","Checked")
levels(data$oedema9___4.factor) <- c("Unchecked","Checked")
levels(data$oedema10___1.factor) <- c("Unchecked","Checked")
levels(data$oedema10___2.factor) <- c("Unchecked","Checked")
levels(data$oedema10___3.factor) <- c("Unchecked","Checked")
levels(data$oedema10___4.factor) <- c("Unchecked","Checked")
levels(data$oedema11___1.factor) <- c("Unchecked","Checked")
levels(data$oedema11___2.factor) <- c("Unchecked","Checked")
levels(data$oedema11___3.factor) <- c("Unchecked","Checked")
levels(data$oedema11___4.factor) <- c("Unchecked","Checked")
levels(data$oedema12___1.factor) <- c("Unchecked","Checked")
levels(data$oedema12___2.factor) <- c("Unchecked","Checked")
levels(data$oedema12___3.factor) <- c("Unchecked","Checked")
levels(data$oedema12___4.factor) <- c("Unchecked","Checked")
levels(data$oedema13___1.factor) <- c("Unchecked","Checked")
levels(data$oedema13___2.factor) <- c("Unchecked","Checked")
levels(data$oedema13___3.factor) <- c("Unchecked","Checked")
levels(data$oedema13___4.factor) <- c("Unchecked","Checked")
levels(data$oedema14___1.factor) <- c("Unchecked","Checked")
levels(data$oedema14___2.factor) <- c("Unchecked","Checked")
levels(data$oedema14___3.factor) <- c("Unchecked","Checked")
levels(data$oedema14___4.factor) <- c("Unchecked","Checked")
levels(data$oedema15___1.factor) <- c("Unchecked","Checked")
levels(data$oedema15___2.factor) <- c("Unchecked","Checked")
levels(data$oedema15___3.factor) <- c("Unchecked","Checked")
levels(data$oedema15___4.factor) <- c("Unchecked","Checked")
levels(data$oedema16___1.factor) <- c("Unchecked","Checked")
levels(data$oedema16___2.factor) <- c("Unchecked","Checked")
levels(data$oedema16___3.factor) <- c("Unchecked","Checked")
levels(data$oedema16___4.factor) <- c("Unchecked","Checked")
levels(data$oedema17___1.factor) <- c("Unchecked","Checked")
levels(data$oedema17___2.factor) <- c("Unchecked","Checked")
levels(data$oedema17___3.factor) <- c("Unchecked","Checked")
levels(data$oedema17___4.factor) <- c("Unchecked","Checked")
levels(data$t2_mapping_elevated_cmr.factor) <- c("Yes","No")
levels(data$high_t2_location_cmr___1.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___2.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___3.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___4.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___5.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___6.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___7.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___8.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___9.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___10.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___11.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___12.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___13.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___14.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___15.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___16.factor) <- c("Unchecked","Checked")
levels(data$high_t2_location_cmr___17.factor) <- c("Unchecked","Checked")
levels(data$pericardial_oedema_cmr.factor) <- c("Yes","No")
levels(data$pericardial_lge_cmr.factor) <- c("Yes","No")
levels(data$vers_peri_cmr.factor) <- c("Yes","No")
levels(data$mr_cmr.factor) <- c("Yes","No")
levels(data$tr_cmr.factor) <- c("Yes","No")
levels(data$cmr_complete.factor) <- c("Incomplete","Unverified","Complete")
levels(data$cause_2.factor) <- c("Congenital heart disease","Myocarditis","Familial Dilated CMP","Hypertrophic CMP","ACM","Ischemic heart disease","Amyloidosis","Other Infiltrative CMP","Post-partum CMP","Arteritis","Other","Not specified")
levels(data$type_transplant.factor) <- c("Orthotopic","Heterotopic","Heart-lung")
levels(data$diabetes_mellitus.factor) <- c("Yes","No")
levels(data$hypertension.factor) <- c("Yes","No")
levels(data$dyslipidemia.factor) <- c("Yes","No")
levels(data$smoking.factor) <- c("no","current smoker","former smoker")
levels(data$drug_use_abuse.factor) <- c("yes current","no never","previous")
levels(data$etoh_use_abuse.factor) <- c("yes current","no never","previous")
levels(data$physical_activity.factor) <- c("no physical activity","light activity 1-3 days week (e.g. walking >15 minutes)","light activity 4-7 days week","normal training 1-2 days week","normal training 3 days or more week","athletic training")
levels(data$pad.factor) <- c("Yes","No")
levels(data$pad_site___1.factor) <- c("Unchecked","Checked")
levels(data$pad_site___2.factor) <- c("Unchecked","Checked")
levels(data$pad_site___3.factor) <- c("Unchecked","Checked")
levels(data$pad_site___4.factor) <- c("Unchecked","Checked")
levels(data$pad_site___5.factor) <- c("Unchecked","Checked")
levels(data$pad_site___6.factor) <- c("Unchecked","Checked")
levels(data$ckd.factor) <- c("Yes","No")
levels(data$thyroid_disfunction.factor) <- c("no","hypo","hyper")
levels(data$previous_bleeding.factor) <- c("Yes","No")
levels(data$copd.factor) <- c("Yes","No")
levels(data$atrial_fibrillation.factor) <- c("no","paroxysmal","persistent/permanent")
levels(data$pm.factor) <- c("Yes","No")
levels(data$crt.factor) <- c("Yes","No")
levels(data$icd.factor) <- c("Yes","No")
levels(data$history_of_vte.factor) <- c("Yes","No")
levels(data$history_of_cancer.factor) <- c("Yes","No")
levels(data$autoimmune_diseases.factor) <- c("Yes","No")
levels(data$depression.factor) <- c("Yes","No")
levels(data$anxiety.factor) <- c("Yes","No")
levels(data$baseline_complete.factor) <- c("Incomplete","Unverified","Complete")
levels(data$death.factor) <- c("Yes","No")
levels(data$cause_of_death.factor) <- c("cardiac","vascular-non cardiac","non cardiovascular","unclear")
levels(data$rejection.factor) <- c("Yes","No")
levels(data$ishlt_grade_1.factor) <- c("Grade 0","Grade 1R (mild)","Grade 2R (moderate)","Grade 3R (severe)")
levels(data$amr_grade_1.factor) <- c("pAMR 0","pAMR1 (H+)","pAMR1 (I+)","pAMR2","pAMR3")
levels(data$ishlt_grade_2.factor) <- c("Grade 0","Grade 1R (mild)","Grade 2R (moderate)","Grade 3R (severe)")
levels(data$amr_grade_2.factor) <- c("pAMR 0","pAMR1 (H+)","pAMR1 (I+)","pAMR2","pAMR3")
levels(data$ishlt_grade_3.factor) <- c("Grade 0","Grade 1R (mild)","Grade 2R (moderate)","Grade 3R (severe)")
levels(data$amr_grade_3.factor) <- c("pAMR 0","pAMR1 (H+)","pAMR1 (I+)","pAMR2","pAMR3")
levels(data$ishlt_grade_4.factor) <- c("Grade 0","Grade 1R (mild)","Grade 2R (moderate)","Grade 3R (severe)")
levels(data$amr_grade_4.factor) <- c("pAMR 0","pAMR1 (H+)","pAMR1 (I+)","pAMR2","pAMR3")
levels(data$ishlt_grade_5.factor) <- c("Grade 0","Grade 1R (mild)","Grade 2R (moderate)","Grade 3R (severe)")
levels(data$amr_grade_5.factor) <- c("pAMR 0","pAMR1 (H+)","pAMR1 (I+)","pAMR2","pAMR3")
levels(data$ishlt_grade_6.factor) <- c("Grade 0","Grade 1R (mild)","Grade 2R (moderate)","Grade 3R (severe)")
levels(data$amr_grade_6.factor) <- c("pAMR 0","pAMR1 (H+)","pAMR1 (I+)","pAMR2","pAMR3")
levels(data$ishlt_grade_7.factor) <- c("Grade 0","Grade 1R (mild)","Grade 2R (moderate)","Grade 3R (severe)")
levels(data$amr_grade_7.factor) <- c("pAMR 0","pAMR1 (H+)","pAMR1 (I+)","pAMR2","pAMR3")
levels(data$ishlt_grade_8.factor) <- c("Grade 0","Grade 1R (mild)","Grade 2R (moderate)","Grade 3R (severe)")
levels(data$amr_grade_8.factor) <- c("pAMR 0","pAMR1 (H+)","pAMR1 (I+)","pAMR2","pAMR3")
levels(data$angio_available.factor) <- c("Yes","No")
levels(data$cav_angio_grade.factor) <- c("CAV0 (not significant)","CAV1 (mild)","CAV2 (moderate)","CAV3 (severe)")
levels(data$cav_angio_site___1.factor) <- c("Unchecked","Checked")
levels(data$cav_angio_site___2.factor) <- c("Unchecked","Checked")
levels(data$cav_angio_site___3.factor) <- c("Unchecked","Checked")
levels(data$cav_angio_site___4.factor) <- c("Unchecked","Checked")
levels(data$pci_performed.factor) <- c("Yes","No")
levels(data$ctca_available.factor) <- c("Yes","No")
levels(data$cav_ctca_grade.factor) <- c("CAV0 (not significant)","CAV1 (mild)","CAV2 (moderate)","CAV3 (severe)")
levels(data$cav_ctca_site___1.factor) <- c("Unchecked","Checked")
levels(data$cav_ctca_site___2.factor) <- c("Unchecked","Checked")
levels(data$cav_ctca_site___3.factor) <- c("Unchecked","Checked")
levels(data$cav_ctca_site___4.factor) <- c("Unchecked","Checked")
levels(data$new_admission_post_cmr.factor) <- c("Yes","No")
levels(data$hf_diagnosis.factor) <- c("Yes","No")
levels(data$mi_diagnosis.factor) <- c("Yes","No")
levels(data$stroke_diagnosis.factor) <- c("Yes","No")
levels(data$endocarditis_diagnosis.factor) <- c("Yes","No")
levels(data$events_complete.factor) <- c("Incomplete","Unverified","Complete")
levels(data$hla_ab_index.factor) <- c("Yes","No")
levels(data$dsa_index.factor) <- c("Yes","No")
levels(data$hla_ab_latest.factor) <- c("Yes","No")
levels(data$dsa_latest.factor) <- c("Yes","No")
levels(data$lab_complete.factor) <- c("Incomplete","Unverified","Complete")