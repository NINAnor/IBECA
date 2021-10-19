library(raster)
library(ggpattern)
library(ggplot2)
library(sf)
library(smoothr)


nor <- readRDS('data/norway_outline.RDS')
nor2 <- st_as_sf(nor)


png("output/NorgePNG.png")
plot(nor)
dev.off()

plot(nor, col="grey")

# Skravert Norgeskart
patternNor <- ggplot(nor2)+
  geom_sf_pattern(
    fill = "white",
    pattern_alpha = .8,
    pattern = 'crosshatch',
    pattern_fill    = 'grey',
    pattern_colour  = 'black',
    pattern_size = .1,
    pattern_density = .3
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

png("output/NorgeSkravertPNG.png")
patternNor
dev.off()



# Prikkete Norgeskart
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

# fjern øyer

area_thresh <- units::set_units(10, km^2)
p_dropped <- drop_crumbs(norS2, threshold = area_thresh)

getwd()
ninalogo <- "figures/NINAlogo1.png"


patternNor <- ggplot(nor2)+
  geom_sf_pattern(
    pattern          = 'image',
    pattern_filename = ninalogo,
    pattern_type     = 'tile',
    colour           = 'black',
    pattern_scale    = .1
  )+
  theme(
    #axis.line=element_blank(),
    #axis.text.x=element_blank(),
        #axis.text.y=element_blank(),
        #axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        legend.position="none",
        #panel.background=element_blank(),
        #panel.border=element_blank(),
        #panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank())

png("unifiedNINA.png")
patternNor
dev.off()
getwd()
