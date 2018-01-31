#' na.max, na.min
#' 
#' Replace `NA` values with the max/min in a safe, consitent way.
#' 
#' @param x vector to have mising values replaced.
#' @param ... does nothing  
#' 
#' `na.max` and `na.min` replace missing values (`NA`) with the maximum or 
#' minimum of non-missing values `x`. Internally [base::max()] and [base::min()]
#' with `na.rm=TRUE`.  
#' 
#' ` ...` passes additional arguments to [base::max()] and [base::min()] which 
#' do nothing.
#' 
#' @return 
#'   A vector of the same length as `x` with `NA` replaced by the maximum value
#'   of `x`; missing values are omitted.   
#' 
#' @seealso 
#'  * [na.replace()] - used internally by these functions
#'  * [base::max()] and [base::min()]
#'  * [na.inf()] / [na.neginf] 
#'   
#' @export

na.max <- function( x, ... ) {
  if( all.na(x) ) {
    warning("Cannot compute max since all elements of `x` are missing, returning `x` unchanged.")
    return(x)
  }
  # if( ! is.numeric(x) ) stop( "na.max only works on numeric type vectors" ) 
  na.replace(x, .na=max(x, na.rm=TRUE, ... ))
}
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
#'  
#'   
#' @export

na.min <- function( x, ... ) { 
  if( all.na(x) ) {
    warning("Cannot compute min since all elements of `x` are missing, returning `x` unchanged.")
    return(x)
  }
  na.replace(x, .na=min(x, na.rm=TRUE, ... ))
}