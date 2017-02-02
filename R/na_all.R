#' Determine if all values are mission
#' 
#' Determines if any of the values in a data structure are missing  
#'
#' @details 
#' Implemented as: . %>% is.na %>% all
#' 
#' @name na_all
#' @param x any object
#' 
#' @seealso 
#'   \code{\link{na_all}} \cr
#'   \code{\link{which_na}}
#'
#' @examples
#'   na_all( c( NA, NA, 1 ) ) # FALSE
#'   na_all( c( NA, NA, NA ) )   # TRUE
#'   
#' @export

na_all <- function(x) UseMethod("na_all")

#' @return \code{logical}
#' @rdname na_all
#' @method na_all default
#' @aliases na_all.default
#' @export

na_all.default <- function(x)
   all( is.na( x ) )


#' @return \code{logical}
#' @rdname na_all
#' @method na_all data.frame
#' @aliases na_all.data.frame
#' @export
na_all.data.frame <- function(x)
  any( sapply( x, na_all ) )