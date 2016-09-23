#' na_median
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
#'   \code{\link{na_replace}}, \code{\link{na_mean}} 

na_median <- function(x) {
  
  if( ! is.numeric(x) ) stop( "na_media only works on numeric vectors" ) 
  
  x[ is.na(x) ] <- median( x, na_rm = TRUE )
  return(x)
  
}
