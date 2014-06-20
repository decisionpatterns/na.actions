#' na.predict
#' 
#' replace \code{NA} values by predictions of a model
#' 
#' @param x data
#' @param object object with predict method
#' @param data data object
#' 
#' @export

na.predict <- function( x, object, data=x ) { 

  if( length(x)  != nrow(data) ) stop()
  

  return(x)
} 