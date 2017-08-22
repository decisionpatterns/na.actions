#' na_implicit
#' 
#' Change values (explicit `NAs`) back to `NA`
#' 
#' @param x object
#' @param values values to be recognized as NA
#' 
#' @details 
#' 
#' `na_implicit` replaces `values` by `NA`. It is meant to be nearly inverse 
#'  operation to `na_explicit` (and `na_replace`). It can be used on both atomic 
#'  and recursive objects.  
#'  
#'  `na_implicit` is a S3 methods that can be used to defince additional 
#'  methods.
#' 
#' @seealso 
#' 
#'  - `na_explicit`
#'  - `na_replace`
#'  
#' @examples 
#' 
#'  na_implicit( c(1,2,3,4), 3 )
#'  na_implicit( c("A", "NA", "B", "C") )
#'  na_implicit( c("A", "(Missing)", "B", "C") )
#'  
#'  df <- data.frame( char=c('A', 'NA', 'C', "(Missing)"), num=1:4 ) 
#'  na_implicit(df)
#'  
#'  
#' @export 

na_implicit <- function( x, values ) 
  UseMethod('na_implicit')

#' @export
na_implicit.default <- function(x, values=NULL) 
  if( is.recursive(x) ) .na_implicit.recursive(x, values ) else
  .na_implicit.atomic( x, values )

.na_implicit.recursive <- function(x,values=NULL) {
  for( i in 1:length(x) ) 
    x[[i]] <- na_implicit( x[[i]], values )  
  x
}
  
.na_implicit.atomic <- function(x, values=NUll ) {
  x[ x %in% values ] <- NA
  x
}


#' @export
na_implicit.character <- function( x, values=c("NA", "(Missing)") ) {
  if( is.null(values) )
    values <- c("NA", "(Missing)") 
  
  x[ x %in% values ] <- NA
  x
}

#' @export
na_implicit.factor <- function( x, values=c("NA", "(Missing)") ) {
  if( is.null(values) )
    values <- c("NA", "(Missing)") 
  
  x[ x %in% values ] <- NA
  x
}