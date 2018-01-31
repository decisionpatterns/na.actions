#' na.rm 
#' 
#' Removes `NA` values from objects
#' 
#' @param object to remove `NA`s from
#' 
#' @details 
#' 
#' For **vectors** this is the same as [stats::na.omit()] or 
#' [stats::na.exclude()].
#' 
#' For removing columns or rows that are have only missing values use 
#' [na.drop_col()] or [na.drop_row()] 
#' 
#' @return
#'   An object of the same class with all `NA` values removed. For 
#'   data.frame and data.table objects entire columns are removed if they 
#'   contain solely `NA` values.
#' 
#' @seealso 
#'   * [stats::na.omit()], [stats::na.exclude()]
#'   * [drop_cols_all_na()] 
#'   * [all.na()]
#'   
#' @md   
#' @export

na.rm <- function(object) {
  UseMethod('na.rm')
}

#' @export
na.rm.default <- na.omit

#' @export

na.rm.data.table <- function(object) { 
  
  wh_nm <- object %>% sapply(all.na) %>% which %>% names
  
  if( length(wh_nm)>0 ) 
    # object[ , c(wh_nm) := NULL ]
    data.table::set(object, j=wh_nm, value=NULL )
  invisible(object)
  
}

#' @export
na.rm.data.frame <- function(object) { 

  wh <- object %>% sapply(all.na) %>% which 

  if( length(wh)>0 ) 
    object <- object[ , -wh ]
    
  return(object)
  
}

#' @rdname na.rm
#' @export 
na.rm <- na.rm 


#' @rdname na.rm
#' @export 
na_rm <- na.rm

# na.rm <- function(object) { 
#   warning("na.rm is deprecated. Use na.rm instead.")
#   na.rm(object)
# }