#' which.na - Identify missing values
#' 
#' Return the indexes of those values that are missing 
#' 
#' @param x vector to search for missing values
#' 
#' @details 
#' 
#' `which.na` is implemented as `which( is.na(x) )` and 
#' 
#' @return 
#' 
#' `integer` of indexes of `x` that are `NA`.  The
#' `names` of the returned vector are set to the names of `x`.
#' 
#' @seealso 
#' 
#'  * [base::is.na()] - for the variant returning logical 
#' 
#' @examples
#' 
#'   x <- c( 1, NA, NA, 4:6 )
#'   which.na(x)
#'   
#'   names(x) <- letters[1:6]
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
 message("'which.na' is preferred for vectors.") 
 which.na(x) 
}
