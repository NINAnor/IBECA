library(raster)
library(ggpattern)
library(ggplot2)
library(sf)
library(smoothr)


nor <- readRDS('data/norway_outline.RDS')


png("output/NorgePNG.png")
plot(nor)
dev.off()

plot(nor, col="grey")

nor2 <- st_as_sf(nor)

patternNor <- ggplot(nor2)+
  geom_sf_pattern(
    pattern = 'crosshatch',
    pattern_fill    = 'black',
    pattern_colour  = 'black',
    pattern_size = .5,
    pattern_density = .5
  )+
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank())

png("output/NorgePNG.png")
patternNor
dev.off()

dotsNor <- ggplot(nor2)+
  geom_sf_pattern(
    pattern = 'circle',
    pattern_fill    = 'black',
    pattern_colour  = 'black',
    pattern_size = .5,
    pattern_density = .2
  )+
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="none",
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank())

png("output/NorgeDotsPNG.png")
dotsNor
dev.off()


# Lage kart over norge fylt med NINAlogoen
# Glatte ut kurver
norS2 <- smooth(nor2, method = "chaikin", refinements = 4)



library(tmap)

tmap_mode("view")
tm_shape(norS2)+
  tm_polygons()
