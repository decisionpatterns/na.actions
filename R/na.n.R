#' Counts how many values are NA
#' 
#' Returns the number of values that are NA
#' 
#' @param x object to count how many values are `NA`
#' 
#' @details 
#' 
#' `na.n` counts the number of missing values. `n_na` is an alias in the dplyr
#' style.
#' 
#' `na.pct` gives the percentage of values that are `NA`
#' 
#' @return 
#' 
#' `na.n` returns an integer. `na.pct` returns a numeric value 0-1. 
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
n_na <- na.n



#' @rdname na.n
#' @export
na.pct <- function(x) 
  na.n(x) / length(x)

#' @rdname na.n
#' @export

pct_na <- na.pct
