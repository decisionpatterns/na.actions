#' Determine if ANY value is NA
#' 
#' Determines if any of the values of an object is missing  
#'
#' @param x object
#' 
#' @details 
#' 
#' Implemented as: . %>% is.na %>% any
#' 
#' @seealso 
#'   \code{\link{na_all}} \cr
#'   \code{which_na}
#'   
#' @examples
#'   na_any( 1:10 )           # FALSE
#'   na_any( c( 1, NA, 3 ) )  # TRUE
#'   
#' @export

na_any <- function(x) UseMethod("na_any")

#' @return \code{logical}
#' @rdname na_any
#' @method na_any default
#' @aliases na_any.default
#' @export

na_any.default <- function(x)
   any( is.na( x ) )


#' @return \code{logical}
#' @rdname na_any
#' @method na_any data.frame
#' @aliases na_any.data.frame
#' @export
na_any.data.frame <- function(x)
  any( sapply( x, na_any ) )
