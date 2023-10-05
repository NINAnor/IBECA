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


#### dNDVI map ####

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

skogdndvi <- read_csv('data/NDVI/skog/dNDVI skog_all_years_regions.csv') #%>%
#  mutate(ndviDeviation = mean) %>%
#  dplyr::select(ID, year, ndvi) %>%
#  # drop NA values
#  drop_na(ndvi) %>%
#  # exclude points with missing years
#  group_by(ID) %>%
#  mutate(n = n()) %>%
#  filter(n == 20) %>%
#  ungroup() %>% dplyr::select(-n)


skoglocations<- st_read('data/NDVI/skog/locations.shp')


# merge ndvi and region
skogdndvi2 <- skogdndvi

skogdndvi2 = left_join(skoglocations,skogdndvi2, left=TRUE, by = "ID")
skogdndvi2 <- skogdndvi2[!is.na(skogdndvi2$slope),]
# getting region info into skogdndvi2
skogdndvi2 <- st_intersection(skogdndvi2, regions)
skogdndvi2 <- skogdndvi2 %>%
  rename(pixel.id = ID, region.id = id) 