#' Replace NAs with Inf
#'
#' Replaces \code{NA}s by \code{Inf} 
#'
#' @param x vector of values to have the NA replaced with \code{value}
#' 
#' @details This is simply a wrapper aroung \code{\link{na_replace}} that 
#' replaces \code{NA} values in the supplied vector with \code{Inf} 
#' a default, \code{value}.
#' 
#' @return \code{x} with \code{NA}s replaced by \code{value}.
#' 
#' @seealso \code{\link{na_replace}}
#' @examples 
#'   na_inf( c( 1, 2, NA, 4) )
#'   na_neginf( c( 1, 2, NA, 4) ) 
#'   
#' @rdname na_inf
#' @export

na_inf <- function(x) na_replace(x, Inf)

#' @rdname na_inf
#' @export
na_neginf <- function(x) na_replace(x, -Inf)
