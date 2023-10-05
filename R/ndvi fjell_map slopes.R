# libraries
library(tidyverse)
library(dplyr)
library(broom)
library(sf)
library(RColorBrewer)
library("gridExtra") 
library(ggridges)
library(ggplot2)
library(tmap)
library(knitr)
library(raster)
library(stars)




# regionmasken
nor <- readRDS('data/norway_outline.RDS')%>%
  st_as_sf()
reg <- st_read("data/regioner_2010/regNorway_wgs84 - MERGED.shp")
reg <-   st_transform(reg, crs = crs(nor))
reg <- st_intersection(reg, nor)


# NDVI Data
theme_set(theme_bw()+ 
            theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+
            theme(strip.background =element_rect(fill="white")))

ndviTS <- read_csv('data/NDVI/NDVI_annual_randomSample.csv') %>%
  mutate(ndvi = mean) %>%
  dplyr::select(ID, year, ndvi) %>%
  # drop NA values
  drop_na(ndvi) %>%
  # exclude points with missing years
  group_by(ID) %>%
  mutate(n = n()) %>%
  filter(n == 20) %>%
  ungroup() %>% dplyr::select(-n)


locations<- st_read('data/NDVI/randomSample_locations.shp')

regions<- st_read('data/regioner_2010/regNorway_wgs84 - MERGED.shp')

# regressions
load('../data/NDVI/NDVI_regressions')


ndviTrends2 <- ndviTrends

ndviTrends2 = left_join(locations,ndviTrends2, left=TRUE, by = "ID")
ndviTrends2 <- ndviTrends2[!is.na(ndviTrends2$slope),]
# getting region info into ndviTrends2
ndviTrends2 <- st_intersection(ndviTrends2, regions)
ndviTrends2 <- ndviTrends2 %>%
  rename(pixel.id = ID, region.id = id) 




#### slopes map ####

plot(nor)



tm_shape(nor) +
  tm_fill('GID_0', labels="", title="") + #tm_borders() +
  tm_shape(ndviTrends2) +
  tm_dots('slope',midpoint=NA, palette=tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE), scale=1, ,legend.show = FALSE) + 
  tm_layout(main.title = "NDVI slopes, mountain",legend.position = c("right", "bottom")) + 
  tm_add_legend(type = "fill", 
                col = tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE),
                labels = c("-0.015 to -0.010", "-0.010 to -0.005", "-0.005 to 0.000", 
                           "0.000 to 0.005", "0.005 to 0.010", "0.010 to 0.015", "0.015 to 0.020"),
                title = "slope values")



#### the slopes histogram ####

# drop geometry
ndviTrends3 <- st_drop_geometry(ndviTrends2)
head(ndviTrends3)
summary(ndviTrends3)
ndviTrends3$region <- as.factor(ndviTrends3$region)
levels(ndviTrends3$region)
levels(ndviTrends3$region)[c(1,4)] <- c("Austlandet","Soerlandet")
levels(ndviTrends3$region)

ndviTrends3$region2 <- ndviTrends3$region
levels(ndviTrends3$region2) <- c("Eastern","Central","Northern","Southern","Western")
ndviTrends3$region2 <- factor(ndviTrends3$region2, levels = rev(c("Northern","Central","Western","Eastern","Southern")))

ggplot(ndviTrends3, aes(x = slope, y = region2, fill = region2)) +
  geom_density_ridges(alpha=1) +
  theme_ridges() + 
  theme(legend.position = "none") +
  xlim(-0.006, 0.008) +
  labs(x='Annual NDVI change',y='Region in Norway')


#### for scaled value map ####
# run after having run scaling in the Rmd
ndviTrends2 = left_join(locations,ndviTrends2, left=TRUE, by = "ID")
ndviTrends2 <- ndviTrends2[!is.na(ndviTrends2$slope),]
# getting region info into ndviTrends2
ndviTrends2 <- st_intersection(ndviTrends2, regions)
ndviTrends2 <- ndviTrends2 %>%
  rename(pixel.id = ID, region.id = id) 



tm_shape(nor) +
  tm_fill('GID_0', labels="", title="") + #tm_borders() +
  tm_shape(ndviTrends2) +
  tm_dots('ndvi.index.u',midpoint=NA, palette=tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE), scale=1, legend.show = FALSE) + # 
  tm_layout(main.title = "NDVI scaled (upper), mountain",legend.position = c("right", "bottom"), main.title.size=1.2) + 
  tm_add_legend(type = "fill", 
                col = c(tmaptools::get_brewer_pal("YlOrRd", 5, plot = FALSE),'grey'),
                labels = c("0.0 to 0.2", "0.2 to 0.4", "0.4 to 0.6", 
                           "0.6 to 0.8", "0.8 to 1.0", "NA"),
                title = "index values")


tm_shape(nor) +
  tm_fill('GID_0', labels="", title="") + #tm_borders() +
  tm_shape(ndviTrends2) +
  tm_dots('ndvi.index.l',midpoint=NA, palette=tmaptools::get_brewer_pal("YlOrRd", 7, plot = FALSE), scale=1, legend.show = FALSE) + # 
  tm_layout(main.title = "NDVI scaled (lower), mountain",legend.position = c("right", "bottom"), main.title.size=1.2) + 
  tm_add_legend(type = "fill", 
                col = c(tmaptools::get_brewer_pal("YlOrRd", 5, plot = FALSE),'grey'),
                labels = c("0.0 to 0.2", "0.2 to 0.4", "0.4 to 0.6", 
                           "0.6 to 0.8", "0.8 to 1.0", "NA"),
                title = "index values")

