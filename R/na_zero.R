#' na_zero 
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
#'   \code{\link{na_replace}} \cr
#'   \code{\link{na_constant}} 
#'  
#' @rdname na_zero
#' @export

na_zero<- function(x) {
  
  if( ! is.numeric(x) ) stop( "na_zero : x must be numeric")
  
  x[ is.na( x ) ] <- 0
  return(x)
  
}
