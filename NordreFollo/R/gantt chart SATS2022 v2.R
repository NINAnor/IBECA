library(ggplot2)
library("ganttrify")
library(readxl)

#https://pythonawesome.com/create-beautiful-gantt-charts-with-ggplot2/?ref=morioh.com&utm_source=morioh.com

file <- "C:/Users/anders.kolstad/OneDrive - NINA/Økologisk tilstand/SATS/gantt data ROSES.xlsx"

dat <- read_excel(file)
spots <- read_excel(file, sheet = "spots")

brk <- seq(from=as.Date("2022-01-15"),
           to=as.Date("2024-05-15"),
           by="quarter")
labs <- format(brk, "%b %Y")
gantt <- ganttrify(project = dat,
                   project_start_date = "2022-01",
                   size_text_relative = 2, 
                   month_number = F,
                   font_family = "Roboto Condensed",
                   x_axis_position = "bottom",
                   hide_wp = F,
                   spots=spots
)+
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+
  scale_x_date(breaks = brk, labels = labs)+
  xlab("")
  
png("NordreFollo/output/ganttV2.png",width = 1000, height = 480, units = "px")     
gantt
dev.off()
