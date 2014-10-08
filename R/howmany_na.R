#' Counts how many values are NA
#' 
#' Returns the number of values that are NA
#' 
#' @param x object to count how many values are \code{NA}
#' @keywords manip
#' @export
#' @examples
#' x <- c( 1, NA, NA, 3:6 )
howmany_na <- function(x)
  sum( is.na(x) )
