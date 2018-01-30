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
#'  [na.replace()], [na.mean()] 
#'   
#' @examples 
#'  
#'   na.median( c(1,2,NA_real_,3) )
#'       
#' @export

na.median <- function( x, ... ) 
  # if( ! is.numeric(x) ) stop( "na.media only works on numeric vectors" ) 
  na.replace( x, .na=median(x, na.rm=TRUE, ... ) )


#' @param prob numeric scalar; probability values. (Default: 0.5, i.e. median)
#' 
#' @examples
#' 
#'   na.quantile( c(1,2,NA_real_,3), prob=0.4 )
#' 
#' @rdname na.median
#' @export

na.quantile <- function(x, prob=0.5, ... ) 
  na.replace( x, .na=quantile(x, probs=prob, na.rm=TRUE, ... ) )
