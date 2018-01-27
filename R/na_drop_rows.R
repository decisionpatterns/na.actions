#' na_drop_rows
#' 
#' Drop rows of a table whose values are all NA
#' 
#' @param tbl data-like object
#' 
#' @details 
#' `na_drop_rows` removes all rows whose only values are NA. It works for all 
#' table-like objects.
#' 
#' @return 
#'   An object of the same class as `tbl` with rows containing all 
#'   `NA` values removed
#' 
#' @examples 
#' 
#'   data(iris)
#'   
#'   tbl <- iris[1:5,]
#'   tbl[1:3,] <- NA
#'   tbl
#'   
#'   na_drop_rows(tbl) 
#' 
#' @md
#' @export

na_drop_rows <- function(tbl) {
  tbl[ ! apply( tbl, 1, na_all ), ]
}

#' @rdname na_drop_rows 
#' @export

drop_na_rows <- na_drop_rows
