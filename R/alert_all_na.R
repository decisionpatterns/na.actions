#' all_na_warning
#' 
#' Produce a warning message that all values are missing and returns it's 
#' argument invisibly. This does not actual test the argument, but is useful in 
#' a test for missing values: 
#' 
#' ```
#'  if( all.na(x) ) return( all_na_warning(x) ) 
#' ````
#'
#' @param x argument 
#' @param alert function such as [base::worn()] or [base::message()] that gets
#'        passed a character message. 
#' 
#' @md
#' @export

alert_all_na <- function(x, alert=base::warning ) { 
  if( is_quosure(x) )
    # alert( "All values are missing in :", rlang::f_name(x) ) else 
    alert( "All values are missing." )
  return(x)
}

