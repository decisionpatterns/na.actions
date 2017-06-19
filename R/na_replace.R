#' Replace NA valies  
#'
#' Replaces \code{NA}s by \code{value} 
#'
#' @param x vector of values to have the NA replaced with \code{value}
#' @param value to replace \code{NA}s
#' 
#' @details 
#' 
#' \code{na_replace} is an alias of: 
#' 
#'      ifelse( is.na(x), value, x )
#' 
#' It replaces \code{NA} values in the input vector with 
#' a default, \code{value}. \code{value} can either be a length-1 scalar or a 
#' vector of \code{length(x)}.  Recycling is not allowed.  If \code{value} is 
#' a scalar, all NA values are replaced by \code{value}.  If a vector, only 
#' \code{NA} of \code{x} are replaced by the corresponding items of \code{value}.
#' 
#' It is mainly provided as a cleaner, pipe-able replacement for ifelse.
#' 
#' @return 
#' \code{x} with \code{NA}s replaced by \code{value}.
#' 
#' @seealso 
#'   \code{\link[base]{ifelse}}
#'   
#' @examples 
#' 
#' na_replace( c(1,NA,3,NA), 2 )    # 1 2 3 2   
#' na_replace( c(1,NA,3,NA), 1:4 )  # 1 2 3 4
#' 
#' @rdname na_replace
#' @export

na_replace <- function(x, value) {

  if( ! length(value) %in% c(1,length(x)) ) 
    warning( "length(value) is not 1 or length(x)")
     
  # if( length(value) == 1 )
  #   x[ is.na( x ) ] <- value else 
  #   x[ is.na( x ) ] <- value[ is.na(x) ]
  # return(x)
  
  ifelse( is.na(x), value, x )  
    
}


#' @rdname na_replace
#' @export
na.replace <- function(x, value = 0 ) {
  warning( "na.replace has been renamed to na_replace. Please change your code.")
  na_replace(x, value)
}
