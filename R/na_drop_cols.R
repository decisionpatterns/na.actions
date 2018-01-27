#' na_drop_cols
#' 
#' Drop cols of a table whose values are all NA
#' 
#' @param data data-like object
#' 
#' @details
#' `na_drop_cols` removes all cols whose only values are NA. It works on all 
#' table-like objects.
#' 
#' @return 
#'   An object of the same class as `data` with cols containing all 
#'   `NA` values removed
#' 
#' @md
#' @export

na_drop_cols <- function(data) {
  data[ , ! apply( data, 2, na_all ) ]
}

#' @rdname na_drop_cols 
#' @export 

drop_na_cols <- na_drop_cols
