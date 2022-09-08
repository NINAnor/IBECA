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


# fjellmasken
file <- "data/fjellmasken.tif"
fjell <- raster::raster(file, proxy=F)
fjell
plot(fjell)

# redusere oppløsningen fra 50m til 1km
#fjell[fjell[]>0] <- 1
#fjell_low <- aggregate(fjell, fact=20)
#saveRDS(fjell_low, "../output/fjell_1km.rds")
# tar noen minutter...
#writeRaster(fjell_low, "../output/fjell_1km.tif")
fjell_low <- readRDS("output/fjell_1km.rds")

fjell_low_star <- st_as_stars(fjell_low)
fjell_low_star[fjell_low_star[]==0] <- NA # for plotting

fjell_low_poly = as.polygons(fjell_low)
fjell_low_poly_sf = st_as_sf(fjell_low_poly)

fjell_low <-   st_transform(fjell_low, crs = crs(reg))
reg.f <- st_intersection(reg, fjell_low)

st_as_sf(fjell)
