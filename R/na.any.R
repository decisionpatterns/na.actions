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
#'  - [na.all()] 
#'  - [which.na()] 
#'   
#' @examples
#'   na.any( 1:10 )           # FALSE
#'   na.any( c( 1, NA, 3 ) )  # TRUE
#'   
#' @export

na.any <- function(x) UseMethod("na.any")

#' @return `logical`
#' @rdname na.any
#' @method na.any default
#' @aliases na.any.default
#' @export

na.any.default <- function(x)
   anyNA(x)


#' @return `logical`
#' @rdname na.any
#' @method na.any data.frame
#' @aliases na.any.data.frame
#' @export
na.any.data.frame <- function(x)
  any( sapply( x, na.any ) )


#' @rdname na.any
#' @export 

any.na <- na.any
