library(ggplot2)
library("ganttrify")
library(readxl)

#https://pythonawesome.com/create-beautiful-gantt-charts-with-ggplot2/?ref=morioh.com&utm_source=morioh.com


dummyData <- read_excel("NordreFollo/data/dummyData.xlsx")
spots <- read_excel("NordreFollo/data/dummyData.xlsx", sheet = "spots")
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
          size_text_relative = 3, 
          month_number = FALSE,
          font_family = "Roboto Condensed",
          x_axis_position = "bottom",
          hide_wp = TRUE
          #spots=spots
          )+
  coord_flip()+
  scale_y_discrete(position = "right",
                   expand = expansion(mult=c(.1,.2))) +
  ylab("Ecosystem Condition Indicators")+
  xlab("Indicator validity")+
  theme(
    axis.title = element_text(size=30),
    plot.margin = margin(0.5, 0.8, .5, 0.5, "cm")
    )+
  scale_x_date(breaks = brk,
               labels = labs)+
  
  geom_segment(aes(x = as.Date("2021-01-15"), 
                   y = .5, xend = as.Date("2021-01-15"), yend = 9),
               lineend = 'round', linejoin = 'round',
               arrow = arrow(length = unit(0.5, "cm")),
               size=3,
               colour="chartreuse3")+
  geom_segment(aes(x = as.Date("2021-03-15"), 
                   y = .5, xend = as.Date("2021-03-15"), yend = 9),
               lineend = 'round', linejoin = 'round',
               arrow = arrow(length = unit(0.5, "cm")),
               size=3,
               colour="chartreuse3")+
  geom_segment(aes(x = as.Date("2021-05-15"), 
                   y = .5, xend = as.Date("2021-05-15"), yend = 9),
               lineend = 'round', linejoin = 'round',
               arrow = arrow(length = unit(0.5, "cm")),
               size=3,
               colour="chartreuse3")
     

gantt

tiff(width = 560, height = 480, units = "px", pointsize = 12,
     compression = "lzw", "NordreFollo/output/conseptFigure_3nov.tif")     
gantt
dev.off()
getwd()
