#' na_roughfix.POXIXct - replace a date/time field 
#' 
#' @param object to replace \code{NA}s with
#' 
#' @export

na_roughfix.POSIXct <- function(object) { 

  dts <- classes( object ) == 'POSIXct'
  wh <- dts[dts]
  for( w in names(wh) ) {
    x <- object[[w]]
    if( any_na(x) ) 
      object[[w]] <- na_replace( x, median(x, na_rm=TRUE ))
    
  }

  return(object)
  
}
