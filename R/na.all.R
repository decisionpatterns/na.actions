#' na.all, all.na 
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
#' 
#' For **data.frames**: 
#' 
#'      `. %>% sapply( na.all ) %>% any`` 
#' 
#' That is, reports if any columns are have all na's. This may change. 
#' 
#' `all.na` is an alias of `na.all`.
#' 
#' 
#' @param x any object
#' 
#' @seealso 
#' 
#'  * [na.any()] 
#'  * [na.which()]
#'
#' @examples
#'   na.all( c( NA, NA, 1 ) ) # FALSE
#'   na.all( c( NA, NA, NA ) )   # TRUE
#'   
#'   df <- data.frame( char = rep(na.character_, 3), nums=1:3)
#'   na.all(df)  # FALSE
#'   
#'   df <- data.frame( char = rep(na.character_, 3), nums=rep(na.real_,3))
#'   na.all(df)  # TRUE
#'   
#' @export

na.all <- function(x) UseMethod("na.all")

#' @return `logical`
#' @rdname na.all
#' @method na.all default
#' @aliases na.all.default
#' @export

na.all.default <- function(x)
   all( is.na( x ) )


#' @return `logical`
#' @rdname na.all
#' @method na.all data.frame
#' @aliases na.all.data.frame
#' @export

na.all.data.frame <- function(x)
  all( sapply( x, na.all ) )


#' @rdname na.all 
#' @export

all.na <- na.all

