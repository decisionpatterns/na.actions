#' Replace NAs with Inf
#'
#' Replaces \code{NA}s by \code{Inf} 
#'
#' @param x vector of values to have the NA replaced with \code{value}
#' 
#' @details This is simply a wrapper aroung \code{\link{na.replace}} that 
#' replaces \code{NA} values in the supplied vector with \code{Inf} 
#' a default, \code{value}.
#' 
#' @return \code{x} with \code{NA}s replaced by \code{value}.
#' 
#' @seealso \code{\link{na.replace}}
#' @examples 
#'   na.inf( c( 1, 2, NA, 4) )
#'   na.neginf( c( 1, 2, NA, 4) ) 
#'   
#' @rdname na.inf
#' @export

na.inf <- function(x) na.replace(x, Inf)

#' @rdname na.inf
#' @export
na.neginf <- function(x) na.replace(x, -Inf)
