angio <- data_stress %>% select(angio_available,  cav_angio_grade, 
                         cav_angio_site___1, cav_angio_site___2, cav_angio_site___3, cav_angio_site___4,
                         pci_performed, 
                         ctca_available, cav_ctca_grade, 
                         cav_ctca_site___1, cav_ctca_site___2, cav_ctca_site___3, cav_ctca_site___4,) 

angio$angio_available <- ifelse(
  is.na(angio$angio_available),0,angio$angio_available
)

angio$ctca_available <- ifelse(
  is.na(angio$ctca_available),0,angio$ctca_available
)

angio$pci_performed <- ifelse(
  is.na(angio$pci_performed),0,angio$pci_performed
)

angio <- angio %>% mutate(study=case_when(
  angio_available==1 & ctca_available==1 ~ "ICA",
  angio_available==1 & ctca_available==0 ~ "ICA",
  angio_available==0 & ctca_available==1 ~ "CTCA",
))

angio <- angio %>% mutate(RCA=case_when(
  cav_angio_site___1==1 | cav_ctca_site___1==1 ~ 1,
  cav_angio_site___1==0 | cav_ctca_site___1==0 ~ 0,
))

angio <- angio %>% mutate(LM=case_when(
  cav_angio_site___2==1 | cav_ctca_site___2==1 ~ 1,
  cav_angio_site___2==0 | cav_ctca_site___2==0 ~ 0,
))
angio <- angio %>% mutate(LAD=case_when(
  cav_angio_site___3==1 | cav_ctca_site___3==1 ~ 1,
  cav_angio_site___3==0 | cav_ctca_site___3==0 ~ 0,
))
angio <- angio %>% mutate(LCX=case_when(
  cav_angio_site___4==1 | cav_ctca_site___4==1 ~ 1,
  cav_angio_site___4==0 | cav_ctca_site___4==0 ~ 0,
))

angio <- angio %>%
  mutate(
    cav_grade = case_when(
      angio_available == 1 & ctca_available == 1 ~ as.character(cav_angio_grade),
      angio_available == 1 & ctca_available == 0 ~ as.character(cav_angio_grade),
      angio_available == 0 & ctca_available == 1 ~ as.character(cav_ctca_grade)
    )
  )

angio <- angio %>% mutate(cav_grade=case_when(
  cav_grade==1 | is.na(cav_grade) ~ "No CAV",
  cav_grade==2 ~ "Mild",
  cav_grade==3 ~ "Moderate",
  cav_grade==4 ~ "Severe",
))

angio <- angio %>%  mutate(vessel=case_when(
  LM+RCA+LCX+LAD>1 ~ "Multi-vessel", 
  LM+RCA+LCX+LAD==1 ~ "Single-vessel",
  LM+RCA+LCX+LAD==0 ~ NA
))

label(angio$study) <- "Index angiography study"
label(angio$vessel) <- "Disease"
label(angio$cav_grade) <- "CAV grade (ISHLT)"
angio$vessel <- as.factor(angio$vessel)

vsl <- cbind(stress,angio)

#vsl %>% select(rmbfi, mbf, mpri, vessel) %>% tbl_summary(by = vessel) %>% add_p()

vsl <- vsl[vsl$vessel=="Single-vessel",]
vsl$art <- as.factor(case_when(
 vsl$RCA==1 ~ "RCA", 
 vsl$LCX==1 ~ "LCX",
 vsl$LAD==1 ~ "LAD"
))

#vsl %>% select(rmbfi, mbf, mpri, art) %>% tbl_summary(by=art)%>% add_p()
angio <- angio %>% select(-c(cav_angio_grade))
