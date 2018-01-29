#' na.mean
#' 
#' Replace `NA` values with the mean
#' 
#' @param x numeric; vector to have `NA` values replaced.
#' @param ... additional arguments passed to [base:mean()] such as 
#' 
#' 
#' Replaces `NA` values with the mean of the series. Will return NA if 
#' all the values are `NA`
#' 
#' @return 
#'   A vector of the same length as `x` with `NA` replaced by the mean  
#' 
#' @seealso 
#'   [na.replace()] 
#'   [na.median()]` 
#'   
#' @export

na.mean <- function( x, ... ) 
  na.replace(x, .na=mean(x, na.rm=TRUE, ... ) )
