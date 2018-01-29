#' Counts how many values are NA
#' 
#' Returns the number of values that are NA
#' 
#' @param x object to count how many values are `NA`
#' 
#' @examples
#'   x <- c( 1, NA, NA, 4:5 )
#'   na.n(x)
#'   na.pct(x)
#' 
#' @export
 
na.n <- function(x) 
  sum( is.na(x) )  

#' @rdname na.n
#' @export

na.howmany <- na.n 


#' @rdname na.n
#' @export
na.pct <- function(x) 
  na.n(x) / length(x)
