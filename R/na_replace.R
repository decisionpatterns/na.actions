#' Replace NA valies  
#'
#' Replaces \code{NA}s by \code{value} 
#'
#' @param x vector of values to have the NA replaced with \code{value}
#' @param value to replace \code{NA}s
#' 
#' @details 
#' 
#' \code{na_replace} replaces \code{NA} values in the input vector with 
#' a default, \code{value}. \code{value} can either be a length-1 scalar or a 
#' vector of \code{length(x)}.  If a scalar, all NA values are replaced by the 
#' scalar value.  If a vector, only \code{NA} values in \code{x} are replaced.
#' 
#' @return 
#' \code{x} with \code{NA}s replaced by \code{value}.
#' 
#' @examples 
#' 
#' na_replace( c(1,NA,3), 2 )    # 1 2 3   
#' na_replace( c(1,NA,3), 1:3 )  # 1 2 3
#' 
#' 
#' 
#' @rdname na_replace
#' @export

na_replace <- function(x, value) {

  if( ! length(value) %in% c(1,length(x)) ) 
    warning( "length(value) is not 1 or length(x)")
    
  if( length(value) == 1 )
    x[ is.na( x ) ] <- value else 
    x[ is.na( x ) ] <- value[ is.na(x) ]
    
  return(x)
}


#' @rdname na_replace
#' @export
na.replace <- function(x, value = 0 ) {
  warning( "na.replace has been renamed to na_replace. Please change your code.")
  na_replace(x, value)
}
