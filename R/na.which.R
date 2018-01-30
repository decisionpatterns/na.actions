#' which.na - Identify missing values
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
#'   which.na(x)
#'   
#' @export 

which.na <- function(x) UseMethod('which.na') 


#' @rdname which.na
#' @export
which.na.default <- function(x)
  which( is.na(x) )


#' @rdname which.na
#' @export

which.na.data.frame <- function(x)
  names(x)[ sapply( x, any.na ) ]


#' @rdname which.na
#' @alias na.which
#' @export

na.which <- function(x) {
 # message("'which_na' is deprecated. Instead, use: 'which.na'") 
 which.na(x) 
}
