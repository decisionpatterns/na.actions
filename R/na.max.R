#' na.max
#' 
#' Replace `NA` values with the max
#' 
#' @param x vector to have mising values of `NA` values replaced.
#' @param ... additional arguments passed to other functions  
#' 
#' `na.max` replaces missing values (`NA`) with the maximum of non-missing 
#' values `x` using `base::max(na.rm==TRUE)`. `x` has to be numeric. ...` 
#' passes additional arguments to [base::max()].
#' 
#' @return 
#'   A vector of the same length as `x` with `NA` replaced by the maximum value
#'   of `x`; missing values are omitted.   
#' 
#' @seealso 
#'   [na.replace()] - used internally by these function 
#'   [na.min()] - 
#'   [na.inf()] / [na.neginf] 
#'   
#' @export

na.max <- function( x, ... ) 
  # if( ! is.numeric(x) ) stop( "na.max only works on numeric type vectors" ) 
  na.replace(x, .na=max(x, na.rm=TRUE, ... ))
