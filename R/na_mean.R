#' na_mean
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
#'   \code{\link{na_replace}}, \code{na_median} 
#' @export

na_mean <- function( x, ... ) {
  
  if( ! is.numeric(x) ) stop( "na_mean only works on numeric vectors" ) 
  
  x[ is.na(x) ] <- mean( x, na_rm = TRUE, ... )
  return(x)
  
}
