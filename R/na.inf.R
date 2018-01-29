#' Replace NAs with +/-Inf
#'
#' Replaces `NA`s by `Inf` or `-Inf`
#'
#' @param x vector of values to have the NA replaced with `value`
#' 
#' @details This is simply a wrapper aroung [na,replace()] that 
#' replaces `NA` values in the supplied vector with `Inf` 
#' a default, `value`.
#' 
#' @return `x` with `NA`s replaced by `value`.
#' 
#' @seealso [na,replace()]
#' @examples 
#'   na.inf( c( 1, 2, NA, 4) )
#'   na,neginf( c( 1, 2, NA, 4) ) 
#'   
#' @rdname na.inf
#' @export

na.inf <- function(x) na.replace(x, Inf)

#' @rdname na.inf
#' @export
na.neginf <- function(x) na.replace(x, -Inf)
