#' Drop rows of a table whose values are all NA
#' 
#' @param data data-like object
#' 
#' Remove all rows whose only values are NA.
#' 
#' @return 
#'   An object of the same class as \code{data} with rows containing all 
#'   \code{NA} values removed
#' 
#' @export

na_drop_rows <- function(data) {
  data[ ! apply( data, 1, na_all ), ]
}

#' @rdname na_drop_rows 
#' @export

drop_na_rows <- na_drop_rows
