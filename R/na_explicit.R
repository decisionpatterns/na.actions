#' na_explicit
#' 
#' Make NA explicit values
#' 
#' @param x object; either atomic or recursive.
#' @param values either a single element list or named vectors; See #Details.  
#' 
#' @details 
#' 
#' `na_explicit` transforms `NA` to values. It is like 
#' `na_replace` but provides an S3 interface that can provide specific 
#'  actions for various types/classes. It also works on recursive objects (i.e. 
#'  lists, data.frames, etc) by applying na_explicit to each element.
#'  
#'  It is also intended to be single argument function.
#' 
#' @seealso 
#' 
#'  - na.actions::na_replace 
#'  - na.actions::na_implicit
#'  - na.actions::na_replace
#'  - forcats::fct_explicit_na
#' 
#' @examples 
#' 
#'    na_explicit( c(1, NA, 3, 4), 0)
#'    na_explicit( c("A",NA,"c","D" ) ) 
#' 
#'    na_explicit( c("A",NA,"c","D") )
#' @export

na_explicit <- function(x, values ) 
  UseMethod("na_explicit")

#' @export
na_explicit.default <- function(x, values) 
  if( is.recursive(x) ) .na_explicit.recursive(x, values ) else
  .na_explicit.atomic( x, values )

.na_explicit.recursive <- function(x, values) {
  for( i in 1:length(x) ) 
  x[[i]] <- na_explicit( x[[i]], values)  
 
  x
}

.na_explicit.atomic <- function(x, values) 
  na_replace( x, values )


#' @export
na_explicit.character <- function(x, values = "NA") { 
  na_replace(x, values = values)  
}


#' @export
na_explicit.factor <- function(x, values = "NA") { 
  na_replace(x, values = values)  
}
