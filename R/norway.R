#' Create an outline of Norway
#' 
#' \code{norway} returs the outline of Norway
#' 
#' Here comes the details...
#' 
#' @param lonlat Should the funtion return a raster in the lonlat coordinate system (defult) or not, in which case it return it as UTM32.
#' @return Returns a Large SpatialPolygonsDataFrame
#' @import raster
#' @import sp
#' @examples 
#' \dontrun{
#' norway() # for a lonlat polygon
#' norway(lonlat = F) # for a UTM32 polygon
#' }
#' @export


norway <- function(lonlat = TRUE){
  norway_lonlat <- raster::getData('GADM', country='NOR', level=0)
  norway_UTM32   <-sp::spTransform(norway_lonlat,"+proj=utm +zone=32")
  if(lonlat) return(norway_lonlat)
  if(!lonlat) return(norway_UTM32)
}