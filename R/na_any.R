#' Determine if ANY value is NA
#' 
#' Determines if any of the values of an object is missing  
#'
#' @param x object
#' 
#' @details 
#' 
#' Implemented as: . %>% anyNA
#' 
#' For data.tables: . %>% is.na %>% any %>% any 
#' 
#' Reports if any column has an \code{NA},
#' 
#' @seealso 
#'   \code{\link[base]{anyNA}} \cr
#'   \code{\link{na_all}} \cr
#'   \code{which_na} \cr
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
   anyNA(x)


#' @return \code{logical}
#' @rdname na_any
#' @method na_any data.frame
#' @aliases na_any.data.frame
#' @export
na_any.data.frame <- function(x)
  any( sapply( x, na_any ) )


#' @rdname na_any
#' @export 

any_na <- na_any
