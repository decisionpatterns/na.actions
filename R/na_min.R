#' na_min
#' 
#' Replace \code{NA} values with the min
#' 
#' @param x numeric; vector to have \code{NA} values replaced.
#' 
#' 
#' Replaces \code{NA} values with the min of the series. Will return NA if 
#' all the values are \code{NA}
#' 
#' @return 
#'   A vector of the same length as \code{x} with \code{NA} replaced by the min  
#' 
#' @seealso 
#'   \code{\link{na_replace}}, \code{\link{na_max}} 
#' @export

na_min <- function( x ) {
  
  if( ! is.numeric(x) ) stop( "na_min only works on numeric vectors" ) 
  
  x[ is.na(x) ] <- min( x, na.rm = TRUE )
  return(x)
  
}
