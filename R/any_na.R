#' Determine if values are mission
#' 
#' Determines if any of the values in a data structure are missing  
#'
#' @name any_na
#' @param x any object
#' 
#' @details 
#' Implemented as: . %>% is.na %>% anyll
#' 
#' @seealso 
#'   \code{\link{all_na}} \cr
#'   \code{which_na}
#'   
#' @examples
#'   any_na( 1:10 )           # FALSE
#'   any_na( c( 1, NA, 3 ) )  # TRUE
#'   
#' @export

any_na <- function(x) UseMethod("any_na")

#' @return \code{logical}
#' @rdname any_na
#' @method any_na default
#' @aliases any_na.default
#' @export

any_na.default <- function(x)
   any( is.na( x ) )


#' @return \code{logical}
#' @rdname any_na
#' @method any_na data.frame
#' @aliases any_na.data.frame
#' @export
any_na.data.frame <- function(x)
  any( sapply( x, any_na ) )
