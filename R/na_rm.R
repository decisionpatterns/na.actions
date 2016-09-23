#' na_rm 
#' 
#' Removes \code{NA} from objects
#' 
#' @param object to remove \code{NA}s from
#' 
#' @details 
#' 
#' For \strong{vectors} this is the same as \code{\link[stats]{na_omit}} and 
#' \code{\link[stats]{na_exclude}}.
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
#'   \code{\link[stats]{na_omit}} \cr
#'   \code{\link[stats]{na_exclude}} \cr
#'   \code{\link{all_na}}
#' @export

na_rm <- function(object) UseMethod('na_rm')

na_rm.data.table <- function(object) { 

  wh_nm <- object %>% sapply(all_na) %>% which %>% names
  
  if( length(wh_nm)>0 ) 
    # object[ , c(wh_nm) := NULL ]
    data.table::set(object, j=wh_nm, value=NULL )
  invisible(object)
  
}

na_rm.data.frame <- function(object) { 

  wh <- object %>% sapply(all_na) %>% which 

  if( length(wh)>0 ) 
    object <- object[ , -wh ]
    
  return(object)
  
}

#' @rdname na_rm
#' @export 
na_rm <- na_rm 

# na_rm <- function(object) { 
#   warning("na_rm is deprecated. Use na_rm instead.")
#   na_rm(object)
# }