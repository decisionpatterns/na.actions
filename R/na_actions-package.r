#' na_actions
#'
#' na_actions is a packages for dealing with \code{NA} values. The goal is 
#' to create a collection for the \code{na_*} family of functions that extends
#' the native functions from the stats package. The curent list of functions is:
#' 
#'  * na,inf / na_neginf - replance na with Inf/-Inf
#'  * na_loess - use loess smoother for replacement
#'  * na_max 
#'  * na_min 
#'  * na_mean
#'  * na_median
#'  * na_nocb - next observation carried backwards
#'  * na_predict - use a model 
#'  * na_replace - replace with a constant \code{value}
#'  * na_roughfix.POSIXct - use with datetime values
#'  * na_trim - remove NA from the margins of a vector
#'  * na_zero - replace with 0 
#' 
#' na_actions suggests the usage of zoo for the collections of na_* function it 
#' contains. These will probably be incorporated in this package.
#' 
#' @examples
#'   na_replace( c(1,NA,3), 2)
#'   
#' @name na_actions
#' @docType package

NULL
