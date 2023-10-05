# make a map of the mountain result
# by region but with only the mountain polygons

library(sf)
library(stars)
library(terra)
library(raster) # kunne kanskje byttet til stars
library(dplyr)
library(lwgeom)
library(tmap)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(data.table)

### Kart over Norge

nor <- readRDS('data/norway_outline.RDS')%>%
  st_as_sf()
reg <- st_read("data/regioner_2010/regNorway_wgs84 - MERGED.shp")
reg <-   st_transform(reg, crs = crs(nor))
reg <- st_intersection(reg, nor)

myColours <- c("blue","red","green","yellow","brown")
reg$region[reg$region=="Ã\u0098stlandet"] <- "Østlandet"
reg$region[reg$region=="SÃ¸rlandet"] <- "Sørlandet"
regionNames <- reg$region

plot(nor$geometry, axes=T)
plot(reg$geometry, add=T, border = "black", 
     col = scales::alpha(myColours, .2))
legend("bottomright",   
       legend = regionNames, 
       fill = myColours)


# Samme kartet, bare med tmap
tmap_mode("plot")
tm_shape(reg) + 
  tm_polygons(col="region", 
              border.col = "white",
              title = "")+
  tm_layout(title="Regioner i Norge",
            legend.text.size = 1)+
  tm_shape(nor)+
  tm_polygons(alpha = 0,border.col = "black")


regionNames_en <- c("North","Central","East","West","South")

# fjellmasken
file <- "data/fjellmasken.tif"
fjell <- raster::raster(file, proxy=F)
fjell
plot(fjell)


plot(reg$geometry, add=T, border = "black", 
     col = scales::alpha(myColours, .1))
#legend("bottom",   
#       legend = regionNames_en, 
#       fill = myColours)



