#' Replace NA valies  
#'
#' Replaces \code{NA}s by \code{value} 
#'
#' @param x vector of values to have the NA replaced with \code{value}
#' @param value to replace \code{NA}s
#' 
#' @details Replaces \code{NA} values in the supplied vector with 
#' a default, \code{value}.
#' 
#' @return \code{x} with \code{NA}s replaced by \code{value}.
#' 
#' @rdname na_replace
#' @export

na_replace <- function(x, value=0) {
  x[ is.na( x ) ] <- value
  return(x)
}

#' @rdname na_replace
#' @export
na_replace <- function(x, value = 0 ) {
  # warning( "na_replace has been renamed to na_replace. Please change your code.")
  na_replace( x, value)
}