#' na.loess
#' 
#' Replace `NA` with loess model
#' 
#' @param object  Object to have `NA`'s replaced
#' @param ...     Additional arguments passed to loess
#' 
#' Replaces `NA` with a loess smoothed fit.  Cannot handle points at the 
#' begginning or end of the series.
#' 
#' @return 
#'   Object of the same type with NAs replaced by a loess smoothed line
#'   
#' @examples
#'   
#'   x <- 1:101 
#'   x[ seq(20,80,5)] <- NA
#'   na.loess(x)
#' 
#' @note
#'   This does not follow function naming conventions in order to more closely 
#'   resembling existing `na.*` functions
#'      
#' @export

na.loess <- function( object , ... ) {
  
  df <- data.frame(y=object, x=1:length(object) )
  fit <- loess( y ~ x, df, ...  )

  object[ is.na(object) ] <- predict( fit, df[ is.na(object), ] )
  return(object)
  
}
  