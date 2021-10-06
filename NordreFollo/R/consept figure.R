library(ggplot2)

library("ganttrify")
library(readxl)

#https://pythonawesome.com/create-beautiful-gantt-charts-with-ggplot2/?ref=morioh.com&utm_source=morioh.com


dummyData <- read_excel("NordreFollo/data/dummyData.xlsx")
labs <- c("Sub-local", 
          "Local",
          "Regional",
          "National",
          "Global")
brk <- seq(from=as.Date("2021-01-15"),
           to=as.Date("2021-05-15"),
           by="month")
length(brk)
length(labs)

gantt <- ganttrify(project = dummyData,
          project_start_date = "2021-01",
          size_text_relative = 1.2, 
          month_number = FALSE,
          font_family = "Roboto Condensed",
          x_axis_position = "bottom"
          )

gantt <- gantt + coord_flip()+
  scale_y_discrete(position = "right") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        axis.title.x = element_blank(),
        axis.title.y = element_blank())+
  scale_x_date(breaks = brk,
               labels = labs)
               
tiff("NordreFollo/output/conseptFigure.tif")     
  gantt
  dev.off()
