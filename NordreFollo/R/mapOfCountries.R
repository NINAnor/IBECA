library("ggplot2")
theme_set(theme_bw())
library("sf")
library("rnaturalearth")
library("rnaturalearthdata")
world <- ne_countries(scale = "small", returnclass = "sf")

myMap <- ggplot(data = world) +
  geom_sf(aes(fill = mapcolor7))+
  scale_fill_gradient(low = "#64b850",
                      high = "#ec4747")+
  guides(fill="none")+
  coord_sf(xlim = c(-50, 100), ylim = c(-20, 80))


png("output/countriesHeatMap.png")
myMap
dev.off()