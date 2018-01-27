#' na_rm 
#' 
#' Removes `NA` values from objects
#' 
#' @param object to remove `NA`s from
#' 
#' @details 
#' 
#' For \strong{vectors} this is the same as [stats::na_omit()] and 
#' [stats::na_exclude()].
#' 
#' For removing columns or rows that are have only missing values use 
#' [na_drop_col()] or [na_drop_row()] 
#' 
#' @return
#'   An object of the same class with all `NA` values removed. For 
#'   data.frame and data.table objects entire columns are removed if they 
#'   contain solely `NA` values.
#' 
#' @seealso 
#'   [stats::na_omit()] 
#'   [stats::na_exclude()] \cr
#'   [na_all()]
#'   
#' @md   
#' @export

na_rm <- function(object) UseMethod('na_rm')

#' @export

na_rm.data.table <- function(object) { 

  wh_nm <- object %>% sapply(na_all) %>% which %>% names
  
  if( length(wh_nm)>0 ) 
    # object[ , c(wh_nm) := NULL ]
    data.table::set(object, j=wh_nm, value=NULL )
  invisible(object)
  
}

#' @export
na_rm.data.frame <- function(object) { 

  wh <- object %>% sapply(na_all) %>% which 

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