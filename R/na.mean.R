#' na.mean
#' 
#' Replace `NA` values with the mean
#' 
#' @param x numeric; vector to have `NA` values replaced.
#' @param ... additional arguments passed to [base:mean()] such as 
#' 
#' `na.mean` replaces `NA` values with the mean of `x`. Internally, 
#' `mean(x, na.rm=TRUE, ... )` is used. If mean cannot be calculated (e.g. x 
#'  isn't numeric) then `x` is returned with a warning.
#' 
#' @return 
#'   A vector of the same length as `x` with `NA` replaced by the `mean(x)`  
#' 
#' @seealso 
#'   [na.replace()] 
#'   [na.median()]` 
#'   
#' @import rlang
#' @export

na.mean <- function( x, ... ) {

  if( ! is.numeric(x) ) {
    warning("'x' is not numeric. Returning values unchanged.")
    return(x)
  }
    
  # if( ! is_quosure(x) ) x <- enquo(x)
  if( all.na(x)  ) return( alert_all_na(x) ) 
  
  na.replace(x, .na=mean(x, na.rm=TRUE, ... ) )
  
}
