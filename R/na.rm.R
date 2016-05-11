#' na.rm 
#' 
#' Removes \code{NA} from objects
#' 
#' @param object to remove \code{NA}s from
#' 
#' @details 
#' 
#' For \strong{vectors} this is the same as \code{\link[stats]{na.omit}} and 
#' \code{\link[stats]{na.exclude}}.
#' 
#' For \strong{data.frames} and \strong{data.tables} columns that are entirely
#' \code{NA} are removed.
#' 
#' @return
#'   An object of the same class with all \code{NA} values removed. For 
#'   data.frame and data.table objects entire columns are removed if they 
#'   contain solely \code{NA} values.
#' 
#' @seealso 
#'   \code{\link[stats]{na.omit}} \cr
#'   \code{\link[stats]{na.exclude}} \cr
#'   \code{\link{all_na}}
#' @export

na.rm <- function(object) UseMethod('na.rm')

na.rm.data.table <- function(object) { 

  wh_nm <- object %>% sapply(all_na) %>% which %>% names
  
  if( length(wh_nm)>0 ) 
    object[ , `:=`(wh_nm,NULL)]
    
  invisible(object)
  
}

na.rm.data.frame <- function(object) { 

  wh <- object %>% sapply(all_na) %>% which 

  if( length(wh)>0 ) 
    object <- object[ , -wh ]
    
  return(object)
  
}

