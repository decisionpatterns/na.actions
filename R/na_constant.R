#' na_constant 
#'
#' Replaces \code{NA}s by a constant 
#'
#' @param x vector; of values to have the NA replaced with \code{value}
#' @param value; single value to replace \code{NA}
#' 
#' @details 
#' 
#' Replaces \code{NA} values in the supplied vector with a default, 
#' \code{value}.
#' 
#' @return 
#'   \code{x} with \code{NA}s replaced by \code{value}.
#' 
#' @seealso
#'   \code{\link{na_replace}}  \cr
#'   \code{\link{na_zero}} - a special case \cr
#' 
#' @examples 
#'   na_constant( c(1,NA,2), -1 )
#' 
#' @rdname na_constant
#' @export

na_constant<- function(x, value) {
  
  if( ! is.numeric(x) ) stop( "na_constant : x must be numeric")
  
  x[ is.na( x ) ] <- value
  return(x)
  
}
