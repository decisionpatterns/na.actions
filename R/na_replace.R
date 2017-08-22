#' Replace NA valies  
#'
#' Replaces \code{NA}s by \code{value} 
#'
#' @param x vector of values to have the NA replaced with \code{value}
#' @param values to replace \code{NA}s
#' 
#' @details 
#' \code{na_replace} replaces \code{NA} values in \code{x} with 
#' \code{values}. \code{values} can either be a length-1 scalar or a 
#' vector of \code{length(x)}. Recycling is not allowed.  If \code{values} is 
#' a scalar, all NA values are replaced by \code{values}.  If a vector, only 
#' \code{NA} of \code{x} are replaced by corresponding elements of \code{values}.
#' 
#' As with It is mainly provided as a cleaner, pipe-able replacement for ifelse.
#' 
#' @return 
#' A vector with the class of \code{values} and the length of \code{x}. 
#' \code{NA}s in \code{x} will be replaced by \code{values}.
#' 
#' @seealso 
#'   \code{\link[base]{ifelse}}, \code{\link[base]{replace}}
#'   
#' @examples 
#' 
#' na_replace( c(1,NA,3,NA), 2 )    # 1 2 3 2   
#' na_replace( c(1,NA,3,NA), 1:4 )  # 1 2 3 4
#' 
#' na_replace( c(1,NA,3,NA), letters[1:4] )  # "1" "b" "3" "d"
#' 
#' @rdname na_replace
#' @export

na_replace <- function(x, values) {

  if( ! length(values) %in% c(1,length(x)) ) 
    stop( "length(values) is not 1 or length(x)")
    
  if( length(values) == 1 )
    x[ is.na(x) ] <- values else
    x[ is.na(x) ] <- values[ is.na(x) ]

  x  
}


#' @rdname na_replace
#' @export
na.replace <- function(x, values ) {
  warning( "na.replace has been renamed to na_replace. Please change your code.")
  na_replace(x, values)
}
