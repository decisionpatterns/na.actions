#' na.which - Identify missing values
#' 
#' Return the indexes of those values that are missing 
#' 
#' @param x vector to search for missing values
#' 
#' @details 
#' 
#' Implemented as `which( is.na(x) )`
#' 
#' @return `integer` of indexes of `x` that are `NA`.  The
#' `names` of the returned vector are set to the names of `x`.
#' that are `NA`.
#' 
#' @examples
#'   x <- c( 1, NA, NA, 3:6 )
#'   na.which(x)
#'   
#' @export 

na.which <- function(x) UseMethod('na.which') 


#' @rdname na.which
#' @export
na.which.default <- function(x)
  which( is.na(x) )


#' @rdname na.which
#' @export

na.which.data.frame <- function(x)
  names(x)[ sapply( x, anyNA ) ]


#' @rdname na.which
#' @alias which.na
#' @export

which.na <- function(x) {
 # message("'which_na' is deprecated. Instead, use: 'na.which'") 
 na.which(x) 
}
