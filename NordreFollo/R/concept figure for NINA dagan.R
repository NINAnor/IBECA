library(ggplot2)
library("ganttrify")
library(readxl)


dat <- read_excel("NordreFollo/data/conceptFigureDataNinaDagan.xlsx")

datRev <- apply(dat, 2, rev)
datRev <- as.data.frame(datRev)
brk <- seq(from=as.Date("2021-01-15"),
           to=as.Date("2021-03-15"),
           by="month")

# Modifications for an extended figure
datRev$activity[datRev$activity=="5"] <- "Naturtyper?"
datRev$activity[datRev$activity=="6"] <- "Blågrønn faktor?"
datRev$start_date[datRev$wp=="h"]     <- 3


gantt <- ganttrify(project = datRev,
                   project_start_date = "2021-01",
                   size_text_relative = 6, 
                   month_number = FALSE,
                   font_family = "Roboto Condensed",
                   x_axis_position = "bottom",
                   hide_wp = TRUE,
                   size_activity = 8
)+
 
  theme(
    plot.margin = margin(0.5, 0.8, .5, 0.5, "cm")
  )+
  scale_x_date(breaks = brk,
               labels = NULL,
               name=NULL)
  


gantt



#tiff("NordreFollo/output/conseptFigureNINAdagan.tif", 
#    width = 1600, height = 600)     
#gantt
#dev.off()

tiff("NordreFollo/output/conseptFigureCIENS.tif", 
     width = 1600, height = 600)     
gantt
dev.off()
