#' na.actions
#'
#' na.actions is a packages for dealing with \code{NA} values. The goal is 
#' to create a collection for the \code{na.*} family of functions that extends
#' the native functions from the stats package. The curent list of functions is:
#' 
#'  * na,inf / na.neginf - replance na with Inf/-Inf
#'  * na.loess - use loess smoother for replacement
#'  * na.max 
#'  * na.min 
#'  * na.mean
#'  * na.median
#'  * na.nocb - next observation carried backwards
#'  * na.predict - use a model 
#'  * na.replace - replace with a constant \code{value}
#'  * na.roughfix.POSIXct - use with datetime values
#'  * na.trim - remove NA from the margins of a vector
#'  * na.zero - replace with 0 
#' 
#' na.actions suggests the usage of zoo for the collections of na.* function it 
#' contains. These will probably be incorporated in this package.
#' 
#' @examples
#'   na.replace( c(1,NA,3), 2)
#'   
#' @name na.actions
#' @docType package

NULL
