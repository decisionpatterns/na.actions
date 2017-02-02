#' Counts how many values are NA
#' 
#' Returns the number of values that are NA
#' 
#' @param x object to count how many values are \code{NA}
#' 
#' @examples
#'   x <- c( 1, NA, NA, 3:6 )
#' 
#' @export
 
na_n <- function(x)
  sum( is.na(x) )

#' @rdname na_n
#' @export

na_howmany <- na_n 
