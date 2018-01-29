#' na.implicit
#' 
#' Change certain values to NAs, ie make explicit `NAs` back to `NA`
#' 
#' @param x object
#' @param values values to be recognized as NA
#' 
#' @details 
#' 
#' `na.implicit` replaces `values` by `NA`. It is meant to be nearly inverse 
#'  operation to `na_explicit` (and `na_replace`). It can be used on both atomic 
#'  and recursive objects.  
#'  
#'  `na.implicit` is a S3 methods that can be used to defince additional 
#'  methods.
#' 
#' @seealso 
#' 
#'  - `na_explicit`
#'  - `na_replace`
#'  
#' @examples 
#' 
#'  na.implicit( c(1,2,3,4), 3 )
#'  na.implicit( c("A", "NA", "B", "C") )
#'  na.implicit( c("A", "(Missing)", "B", "C") )
#'  
#'  df <- data.frame( char=c('A', 'NA', 'C', "(Missing)"), num=1:4 ) 
#'  na.implicit(df)
#'  
#'  
#' @export 

na.implicit <- function( x, values ) 
  UseMethod('na.implicit')

#' @export
na.implicit.default <- function(x, values=NULL) 
  if( is.recursive(x) ) .na.implicit.recursive(x, values ) else
  .na.implicit.atomic( x, values )

.na.implicit.recursive <- function(x,values=NULL) {
  for( i in 1:length(x) ) 
    x[[i]] <- na.implicit( x[[i]], values )  
  x
}
  
.na.implicit.atomic <- function(x, values=NUll ) {
  x[ x %in% values ] <- NA
  x
}


#' @export
na.implicit.character <- function( x, values=c("NA", "(Missing)") ) {
  if( is.null(values) )
    values <- c("NA", "(Missing)") 
  
  x[ x %in% values ] <- NA
  x
}

#' @export
na.implicit.factor <- function( x, values=c("NA", "(Missing)") ) {
  if( is.null(values) )
    values <- c("NA", "(Missing)") 
  
  x[ x %in% values ] <- NA
  x
}