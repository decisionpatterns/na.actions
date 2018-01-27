#' na_max
#' 
#' Replace \code{NA} values with the max
#' 
#' @param x numeric; vector to have \code{NA} values replaced.
#' 
#' 
#' Replaces \code{NA} values with the max of the series. Will return NA if 
#' all the values are \code{NA}
#' 
#' @return 
#'   A vector of the same length as \code{x} with \code{NA} replaced by the max  
#' 
#' @seealso 
#'   \code{\link{na_replace}}, \code{\link{na_min}} 
#' @export

na_max <- function( x ) {
  
  if( ! is.numeric(x) ) stop( "na_max only works on numeric vectors" ) 
  
  x[ is.na(x) ] <- max( x, na.rm = TRUE )
  return(x)
  
}
