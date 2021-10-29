library(sf)
library(raster) # kunne kanskje byttet til stars
library(dplyr)
library(tmap)
library(tmaptools)

getwd()
nor <- readRDS('data/norway_outline.RDS')%>%
  st_as_sf()


#plot(nor$geometry, axes=T, main = "Norge")


reg <- st_read("P:/41201042_okologisk_tilstand_fastlandsnorge_2020_dataanaly/FINAL/Raw_data/Geografisk_oppdeling/regioner_2010/regNorway_wgs84 - MERGED.shp")%>%
  st_transform(crs = crs(nor))


#plot(reg$geometry, axes=T, main = "Norge")


reg_clipped <- st_intersection(reg, nor)

#plot(reg_clipped$geometry, axes=T, main = "Norge")

reg_clipped$value <- c(0.42,
                       0.42,
                       0.42,
                       0.37,
                       0.42)

Breaks <- c(0, 0.2, 0.4, 0.6, 0.8, 1)
#tmaptools::palette_explorer()
tm_shape(reg_clipped) + 
  tm_layout(bg.color = "skyblue",
            legend.text.size = 1.7,
            legend.title.size = 1.7)+
  tm_polygons(col="value", 
              title = "Økologisk\ntilstand i skog",
              breaks = Breaks,
              border.col = "black",
              palette = get_brewer_pal("RdYlGn", n = 10, contrast = c(0, 1)))+
  tm_shape(nor)+
  tm_polygons(alpha = 0,border.col = "black")


png("figures/økologisk tilstand i skog kart.png", width = 1500, height = 1500, units = "px")
tm_shape(reg_clipped) + 
  tm_layout(bg.color = "skyblue",
            legend.text.size = 7,
            legend.title.size = 7)+
  tm_polygons(col="value", 
              title = "Økologisk\ntilstand i skog",
              breaks = Breaks,
              border.col = "black",
              palette = get_brewer_pal("RdYlGn", n = 10, contrast = c(0, 1)))+
  tm_shape(nor)+
  tm_polygons(alpha = 0,border.col = "black")
dev.off()

