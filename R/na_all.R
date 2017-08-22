#' Determine if all values are missing
#' 
#' Determines if any of the values in a data structure are missing  
#'
#' @details 
#' Implemented as: . %>% is.na %>% all
#' 
#' For data.frames: 
#' 
#'      . %>% sapply( na_all ) %>% any 
#'      
#' That is, reports if any columns are have all na's. This may change. 
#' 
#' \code{all_na} is a copy of \code{na_all}.
#' 
#' \code{all}
#' 
#' @param x any object
#' 
#' @seealso 
#'   \code{\link{na_any}} \cr
#'   \code{\link{na_which}}
#'
#' @examples
#'   na_all( c( NA, NA, 1 ) ) # FALSE
#'   na_all( c( NA, NA, NA ) )   # TRUE
#'   
#'   df <- data.frame( char = rep(NA_character_, 3), nums=1:3)
#'   na_all(df)  # FALSE
#'   
#'   df <- data.frame( char = rep(NA_character_, 3), nums=rep(NA_real_,3))
#'   na_all(df)  # TRUE
#'   
#' @export

na_all <- function(x) UseMethod("na_all")

#' @return \code{logical}
#' @rdname na_all
#' @method na_all default
#' @aliases na_all.default
#' @export

na_all.default <- function(x)
   all( is.na( x ) )


#' @return \code{logical}
#' @rdname na_all
#' @method na_all data.frame
#' @aliases na_all.data.frame
#' @export

na_all.data.frame <- function(x)
  all( sapply( x, na_all ) )


#' @rdname na_all 
#' @export

all_na <- na_all

