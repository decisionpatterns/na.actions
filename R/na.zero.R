#' na.zero 
#'
#' Replaces \code{NA}s by 0. 
#'
#' @param x vector of values to have the NA replaced with \code{value}
#' 
#' @details Replaces \code{NA} values in the supplied vector with 
#' a default, \code{0}.
#' 
#' @return 
#' \code{x} with \code{NA}s replaced by 0.
#' 
#' @seealso 
#'   \code{\link{na.replace}} \cr
#'   \code{\link{na.constant}} 
#'  
#' @rdname na.zero
#' @export

na.zero<- function(x) {
  
  if( ! is.numeric(x) ) stop( "na.zero : x must be numeric")
  
  x[ is.na( x ) ] <- 0
  return(x)
  
}
