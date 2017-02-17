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

na_drop_cols <- function(data) {
  data[ , ! apply( data, 2, na_all ) ]
}

#' @rdname na_drop_cols 
#' @export 

drop_na_cols <- na_drop_cols
