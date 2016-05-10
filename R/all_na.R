#' Determine if all values are mission
#' 
#' Determines if any of the values in a data structure are missing  
#'
#' @details 
#' Implemented as: . %>% is.na %>% all
#' 
#' @name all_na
#' @param x any object
#' 
#' @seealso 
#'   \code{\link{all_na}} \cr
#'   \code{\link{which_na}}
#'
#' @examples
#'   all_na( c( NA, NA, 1 ) ) # FALSE
#'   all_na( c( NA, NA, NA ) )   # TRUE
#'   
#' @export

all_na <- function(x) UseMethod("all_na")

#' @return \code{logical}
#' @rdname all_na
#' @method all_na default
#' @aliases all_na.default
#' @export

all_na.default <- function(x)
   all( is.na( x ) )


#' @return \code{logical}
#' @rdname all_na
#' @method all_na data.frame
#' @aliases all_na.data.frame
#' @export
all_na.data.frame <- function(x)
  any( sapply( x, all_na ) )
