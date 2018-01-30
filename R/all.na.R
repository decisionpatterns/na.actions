#' all.na, na.all 
#' 
#' Test if all values are missing
#' 
#' @param x object to test.
#' 
#' @details 
#' Implemented as: 
#' 
#' For **vectors**: 
#' 
#'      `. %>% is.na %>% all``
#' 
#' For **data.frames**: 
#' 
#'      `. %>% sapply( all.na ) %>% all`` 
#' 
#' 
#' `na.all` is an alias of `all.na`. It is given as consistency with the other 
#' function. `all.na` is preferred since the `na.*` functions are typically used
#' for vector imputaion.`
#' 
#' 
#' @param x any object
#' 
#' @return 
#'   logical scalar indicating if all values are missing.
#'   
#' @seealso 
#' 
#'  * [any.na()] 
#'  * [which.na()]
#'
#' @examples
#' 
#'   all.na( c( NA, NA, 1 ) )    # FALSE
#'   all.na( c( NA, NA, NA ) )   # TRUE
#'   
#'   df <- data.frame( char = rep(NA_character_, 3), nums=1:3)
#'   all.na(df)  # FALSE
#'   
#'   df <- data.frame( char = rep(NA_character_, 3), nums=rep(NA_real_,3))
#'   all.na(df)  # TRUE
#'   
#' @export

all.na <- function(x) UseMethod("all.na")

#' @rdname all.na
#' @export

all.na.default <- function(x)
   all( is.na( x ) )

#' @rdname all.na
#' @export

all.na.data.frame <- function(x)
  all( sapply( x, all.na ) )



#' @rdname all.na 
#' @export

na.all <- function(x) {
  warning( "`na.all` is deprecated. Use `all.na` instead." )
  all.na(x)
}
