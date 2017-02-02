#' Drop cols of a table whose values are all NA
#' 
#' @param data data-like object
#' 
#' Remove all cols whose only values are NA.
#' 
#' @return 
#'   An object of the same class as \code{data} with cols containing all 
#'   \code{NA} values removed
#' 
#' @export

drop_na_cols <- function(data) {
  data[ , ! apply( data, 2, na_all ) ]
}
