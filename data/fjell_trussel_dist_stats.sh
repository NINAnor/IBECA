#!/bin/bash

# Lenk opp fjellmasken
r.external input=data/fjellmasken.tif output=fjellmasken --o --v

# Importer filen med fjell regionene
v.import input="data/regioner_2010/regNorway_wgs84 - MERGED.shp" \
    layer="regNorway_wgs84 - MERGED" output="regNorway_wgs84___MERGED" \
    encoding="UTF8" --o --v

# Definer griddet for analysen (følg fjellmasken)
eval `g.region -g raster=fjellmasken vector="regNorway_wgs84___MERGED" align=fjellmasken`

# Konverter relevante N50 geometrier til raster
# Skog + menneskelig innflytelse
gdal_rasterize -at -sql "SELECT geom FROM \"Topography\".\"Norway_N50_BygningsPunkt\"
UNION ALL
SELECT geom FROM \"Topography\".\"Norway_N50_JernbaneStasjon\"
UNION ALL
SELECT geom FROM \"Topography\".\"Norway_N50_Bane\"
UNION ALL
SELECT geom FROM \"Topography\".\"Norway_N50_VegSti\" WHERE \"OBJTYPE\" != 'Sti'
UNION ALL
SELECT geom FROM \"Topography\".\"Norway_N50_ArealdekkeFlate\" WHERE \"OBJTYPE\" IN (
'Alpinbakke'
,'BymessigBebyggelse'
,'DyrketMark'
,'Golfbane'
,'Gravplass'
,'Hyttefelt'
,'Industriområde'
,'Lufthavn'
,'Park'
,'Rullebane'
,'Skog'
,'SportIdrettPlass'
,'Steinbrudd'
,'Steintipp'
,'TettBebyggelse'
)" -burn 1 -of GTiff -a_srs EPSG:25833 -co COMPRESS=LZW -co PREDICTOR=2 \
    -a_nodata 0 -te $w $s $e $n -tr $ewres $nsres -ot Byte -optim AUTO \
    "PG:host=gisdata-db.nina.no dbname=gisdata user=$USER" \
    data/n50_fjell_trussler.tif

gdal_rasterize -at -sql "SELECT geom FROM \"Topography\".\"Norway_N50_ArealdekkeFlate\" WHERE \"OBJTYPE\" =  'Skog'" \
    -burn 1 -of GTiff -a_srs EPSG:25833 -co COMPRESS=LZW -co PREDICTOR=2 \
    -a_nodata 0 -te $w $s $e $n -tr $ewres $nsres -ot Byte -optim AUTO \
    "PG:host=gisdata-db.nina.no dbname=gisdata user=$USER" \
    data/n50_fjell_trussler_referanse.tif

# Lenke opp raster med menneskelig eller boreal innflytelse
r.external input=data/n50_fjell_trussler.tif output=n50_fjell_trussler --o --v
r.external input=data/n50_fjell_trussler_referanse.tif output=n50_fjell_trussler_referanse --o --v

# Beregn avstand til pikslene i innflytelses raster
r.grow.distance input=n50_fjell_trussler distance=n50_fjell_trussler_dist --o --v
r.grow.distance input=n50_fjell_trussler_referanse distance=n50_fjell_trussler_dist_referanse --o --v

# Konverter fjell regioner til raster
v.to.rast input=regNorway_wgs84___MERGED type=point,line,centroid,area \
    output=regNorway_wgs84___MERGED use=attr attribute_column=id memory=3000 --o --v

# Bruk fjellmasken som maske (MASK) for videre analysen
echo "0 = NULL
* = 1" | r.reclass input=fjellmasken output=MASK rules=- --o --v

# Lagre univariat raster statistikk i en CSV fil
r.univar -t map=n50_fjell_trussler_dist zones=regNorway_wgs84___MERGED \
    output=data/fjell_trussel_dist_stats.csv separator=comma --o --v
r.univar -t map=n50_fjell_trussler_dist_referanse zones=regNorway_wgs84___MERGED \
    output=data/fjell_trussel_dist_referanse_stats.csv separator=comma --o --v

# Rydde opp
rm data/n50_fjell_trussler.tif
rm data/n50_fjell_trussler_referanse.tif
