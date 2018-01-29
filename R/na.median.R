#' na.median
#' 
#' Replace `NA` values with the median
#' 
#' @param x numeric; vector to have `NA` values replaced.
#' 
#' @return 
#'   A vector of the same length as `x` with `NA` replaced by the 
#'   median  
#' 
#' @seealso 
#'   [na.replace()], [na.mean()] 

na.median <- function( x, ... ) 
  # if( ! is.numeric(x) ) stop( "na.media only works on numeric vectors" ) 
  na.replace( x, .na=median(x, na.rm=TRUE, ... ) )
