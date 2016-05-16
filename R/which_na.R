#' which_na: Identify missing values
#' 
#' Return the indexes of those values that are missing 
#' 
#' @param x Vector to search for missing values
#' 
#' @return \code{integer} of indexes of \code{x} that are \code{NA}.  The
#' \code{names} of the returned vector are set to the names of \code{x}.
#' that are \code{NA}.
#' 
#' @examples
#'   x <- c( 1, NA, NA, 3:6 )
#'   which_na(x)
#' @rdname which_na
#' @export which_na

which_na <- function(x) UseMethod('which_na') 


#' @rdname which_na
#' @export
which_na.default <- function(x)
  which( is.na(x) )


#' @rdname which_na
#' @export
which_na.data.frame <- function(x)
  names(x)[ sapply( x, anyNA ) ]
