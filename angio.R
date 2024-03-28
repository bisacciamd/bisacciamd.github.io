library(echarts4r)
cav_0 <- 31
cav_1 <- 28

feasibility <- data.frame(
    symp=c("Invasive\ncoronary angiography", "CT coronary\nangiography"),
    occ=c(cav_0, cav_1)
)

feasibility$symp <- paste0(feasibility$symp, " (", (round(feasibility$occ/sum(feasibility$occ)*100, digits = 1)), "%)")

feasibility[feasibility$occ>0,] %>% 
  e_charts(symp) %>% 
  e_pie(occ, radius = c("50%", "70%")) %>% 
  e_legend(FALSE) %>% e_theme("vintage") %>% e_text_style(fontSize=20)
  # |> e_title("Donut chart")