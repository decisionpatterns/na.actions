#' Determine if ANY value is NA
#' 
#' Determines if any of the values of an object is missing  
#'
#' @param x object
#' 
#' @details 
#' 
#' For **vectors**:
#' ```` 
#'      . %>% anyNA
#' ```
#' 
#' For **tables**: 
#' ````
#'      . %>% is.na %>% any %>% any 
#' ```
#' `
#' Reports if any column has an `NA`,
#' 
#' @seealso 
#'  - [base:anyNA()]
#'  - [all.na()] 
#'  - [which.na()] 
#'   
#' @examples
#'   any.na( 1:10 )           # FALSE
#'   any.na( c( 1, NA, 3 ) )  # TRUE
#'   
#' @export

any.na <- function(x) UseMethod("any.na")

#' @return `logical`
#' @rdname any.na
#' @method any.na default
#' @aliases any.na.default
#' @export

any.na.default <- function(x)
   anyNA(x)


#' @return `logical`
#' @rdname any.na
#' @method any.na data.frame
#' @aliases any.na.data.frame
#' @export
any.na.data.frame <- function(x)
  any( sapply( x, any.na ) )


#' @rdname any.na
#' @export 

na.any <- any.na
