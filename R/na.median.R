#' na.median
#' 
#' Replace \code{NA} values with the median
#' 
#' @param x numeric; vector to have \code{NA} values replaced.
#' 
#' @return 
#'   A vector of the same length as \code{x} with \code{NA} replaced by the 
#'   median  
#' 
#' @seealso 
#'   \code{\link{na.replace}}, \code{\link{na.mean}} 

na.median <- function(x) {
  
  if( ! is.numeric(x) ) stop( "na.media only works on numeric vectors" ) 
  
  x[ is.na(x) ] <- median( x, na.rm = TRUE )
  return(x)
  
}
