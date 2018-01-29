#' na.min
#' 
#' Replace `NA` values with the min
#' 
#' @param x numeric; vector to have `NA` values replaced.
#' 
#' 
#' Replaces `NA` values with the min of the series. Will return NA if 
#' all the values are `NA`
#' 
#' @return 
#'   A vector of the same length as `x` with `NA` replaced by the min  
#' 
#' @seealso 
#'   [na.replace()]
#'   [na.max()] 
#'   
#' @export

na.min <- function( x, ... ) 
  # if( ! is.numeric(x) ) stop( "na.min only works on numeric vectors" ) 
  na.replace(x, .na=min(x, na.rm=TRUE, ... ))
