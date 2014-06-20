#' na.mean
#' 
#' Replace \code{NA} values with the mean
#' 
#' @param x numeric; vector to have \code{NA} values replaced.
#' @param ... additional arguments passed to \code{\link[base]{mean}} such as 
#' 
#' 
#' Replaces \code{NA} values with the mean of the series. Will return NA if 
#' all the values are \code{NA}
#' 
#' @return 
#'   A vector of the same length as \code{x} with \code{NA} replaced by the mean  
#' 
#' @seealso 
#'   \code{\link{na.replace}}, \code{na.median} 
#' @export

na.mean <- function( x, ... ) {
  
  if( ! is.numeric(x) ) stop( "na.mean only works on numeric vectors" ) 
  
  x[ is.na(x) ] <- mean( x, na.rm = TRUE, ... )
  return(x)
  
}
