#' na.constant 
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
#'   \code{\link{na.replace}}  \cr
#'   \code{\link{na.zero}} - a special case \cr
#' 
#' @examples 
#'   na.constant( c(1,NA,2), -1 )
#' 
#' @rdname na.constant
#' @export

na.constant<- function(x, value) {
  
  if( ! is.numeric(x) ) stop( "na.constant : x must be numeric")
  
  x[ is.na( x ) ] <- value
  return(x)
  
}
