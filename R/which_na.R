#' na_which: Identify missing values
#' 
#' Return the indexes of those values that are missing 
#' 
#' @param x Vector to search for missing values
#' 
#' @details 
#' 
#' Implemented as . %>% is.na %>% which 
#' 
#' For data.frames: 
#' 
#' @return \code{integer} of indexes of \code{x} that are \code{NA}.  The
#' \code{names} of the returned vector are set to the names of \code{x}.
#' that are \code{NA}.
#' 
#' @examples
#'   x <- c( 1, NA, NA, 3:6 )
#'   na_which(x)
#' @rdname na_which
#' @export na_which

na_which <- function(x) UseMethod('na_which') 


#' @rdname na_which
#' @export
na_which_default <- function(x)
  which( is.na(x) )


#' @rdname na_which
#' @export
na_which_data.frame <- function(x)
  names(x)[ sapply( x, anyNA ) ]

#' @rdname na_which
#' @export

which_na <- na_which 
