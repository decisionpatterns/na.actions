#' na.constant 
#'
#' Replaces `NA`s by a constant 
#'
#' @param x vector; of values to have the NA replaced with `.na`
#' @param .na scalar .na to use as replacement.
#' 
#' @details 
#' 
#' **This function is deprecated. Use [na.replace()] instead.
#' 
#' Replaces `NA` values in the supplied vector with a default, `.na`. 
#' 
#' @return 
#'   A vector with the type and length of `x` with all missing values replaces 
#'   by `.na`.
#' 
#' @seealso
#'   [na_replace()] 
#'   [na_zero()]  - a special case.
#' 
#' @examples 
#'   na.constant( c(1,NA,2), -1 )
#' 
#'   na_constant <- mk_recursive(na.constant)
#'  
#'   mtcars %>%  na_constant( mpg=5, cyl=3 )
#' @md
#' @rdname na.constant
#' @export

na.constant<- function(x, .na) {
  
  warning( call.=FALSE, "na.constant is deprecated. Instead use: na.replace(x, .na)" )
  na.replace(x, .na)
  
}


#' #' @export
#' #' @rdname table
#' 
#' na_constant <- function( tbl, ... )  {
#'   
#'   if( ! is.recursive( .tbl ) ) { 
#'     return( na.constant( x=.tbl, ...) )
#'   }
#'   
#'   # First handle the name=values pairs
#'   #  - use kv function
#'   #  - if value is function apply it to x[[ key ]]
#'   for( kv in kv( list(...) ) ) 
#'     .tbl[[kv$k]] <- na.constant( .tbl[[kv$k]], .na=kv$v )
#'   
#'   .tbl
#' 
#' }

