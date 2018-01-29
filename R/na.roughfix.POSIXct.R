#' na.roughfix.POXIXct 
#' 
#' Replace a date/time field 
#' 
#' @param object to replace missing values with.
#' 
#' @details 
#' 
#' `na.roughfix.POSIXct` implements a POSIXct method for  
#' `na.roughfix`from the *randomForest* package. This violates the 
#' 
#' @rdname na.roughfix
#' @export

na.roughfix.POSIXct <- function(object) { 

  dts <- classes( object ) == 'POSIXct'
  wh <- dts[dts]
  for( w in names(wh) ) {
    x <- object[[w]]
    if( na_any(x) ) 
      object[[w]] <- na.replace( x, median(x, na_rm=TRUE ))
    
  }

  return(object)
  
}

