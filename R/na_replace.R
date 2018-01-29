#' Replace missing values in tbales and lists
#' 
#' Replace missing values (`NA`) in a table and lists
#' 
#' @param .data list-like or table-like structure.
#' @param .na scalar, vector or function as described in [na.replace()]
#' @param ... additional args; either a unnamed list of columns (quoted or not)
#'        or name=function pairs.  See Details.
#'
#' @details
#' 
#' `na_replace` is similar to other *dplyr* verbs especially [dplyr::mutate()] 
#' except it always operates on a subset of vector elements, i.e. those with `NA` 
#' values. 
#' 
#' The behavior depends on the values of `.na` and `...`. (See Usage.) 
#' 
#' @usage 
#'
#' `na_replace` can be used for three replacement operatations: 
#'  
#'  1. `na_replace( .data, .na )` : ( missing `...` ) Replace missing values 
#'      in **ALL COLS** by `.na`
#'  2. `na_replace( .data, .na, ... )` : ( `...` is an unnamed list) Replace 
#'      column(s) specified in `...` by `.na`.  Columns are specified as an 
#'      unnamed list of quoted or unquoted column names.
#'  3. `na_replace( .data. col1=na.*, col2=na.* )` : ( missing `.na` ) : 
#'     Replace by column-specific `.na` 
#'  
#' Use Additional arguments are to `.na` are not used; Use na_replace_at for 
#' or create your own lambda functions.
#' 
#' @return 
#' 
#' Returns a object as the same type as `.data`. Columns are mutated to replace
#' missing values (`NA`) with value specied by `.na` and `...`
#' 
#' @examples
#' 
#' mtcars %>% na_replace(0, mpg, cyl)
#' mtcars %>% na_replace(1:6, mpg, cyl)
#'
#' mtcars %>% na_replace( na.mean )
#' mtcars %>% na_replace( mean )       # unsafe
#' mtcars %>% na_replace( length, mpg, disp )
#' mtcars %>% na_replace( mean, mpg, disp )
#' mtcars %>% na_replace( mpg=na.mean, cyl=na.max )
#' 
#' @md
#' @export


na_replace <- function (.data, .na, ...)
{
  
  # if( missing(.na) && missing(...) )
  #  stop( "At least one of .na or ... must be provided.")
  
  # USAGE 1: missing(...) all columns mutated by .na
  if ( missing(...) ) { 
    for( j in 1:length(.data) )
      .data[[j]] <- na.replace( .data[[j]], .na )
    return( .data )
  }
    
  
  # vars: key-value list ...
  
  # TEST whether unknown columns were specified   
  unknown <- setdiff( names(vars), names(.data))
  if( length(unknown) > 0 )
    stop( paste( "Unknown columns:", paste(unknown, collapse=", ")))
  
  
  # USAGE 2: ... is column names
  # IF names were provided as part of columns list, we take
  if( ! missing(.na) && is_unnamed.quosure( quos(...) ) ) { 
    vars <- select_vars( names(.data), ... )  
    for( j in vars )
      .data[[j]] <- na.replace( .data[[j]], .na ) 
    return(.data)
  }   
  
  # USAGE 3: ... is col=na.fun pairs
  if( missing(.na) && is_named( quos(...)) ) {
    for ( . in kv( quos(...) ) )  {   
      .na = rlang::eval_tidy( .$v )
      .data[[.$k ]] <- na.replace( .data[[.$k]], .na=.na )
    }
    return(.data)
  } 
  
  if( ! missing(.na) && is_named( quos )) 
    stop( "Specifying .na and col=.na is not allowed")
  
}


# f <- function(.data, ...)
#   quos(..., .named=FALSE )
# 
# f( mtcars, mpg, cyl)


#' @note 
#' `...` behaves differently in `na_replace` as it denotes a list or column 
#' names instead of name-value pairs. The values are provided by `.na`
#'  

na_replace_at <- function(.tbl, .na, .vars, ... ) { 

  for( i in .vars )
    .tbl[[i]] <- na.replace( .tbl[[i]], .na, ... )
  .tbl
  
}  


na_replace_all <- function(.tbl, .na, ... ) { 

  for( i in 1:length(.tbl) )
    .tbl[[i]] <- na.replace( .tbl[[i]], .na, ... )
  .tbl
    
}


na_replace_if <- function( .tbl, .na, .predicate, ... ) { 

  for( i in 1:length(.tbl) ) 
    if( .predicate(.tbl[[i]] ) ) 
      .tbl[[i]] <- na.replace( .tbl[[i]],  )
    
  .tbl
}
  

# na_replace <- function(.data, .na,  ...) { 
# 
#    
#  # USAGE 1:  na_replace( .data, .na ) -> impute all variables
#  if( ! missing(.na) && missing(...) ) { 
#    for( j in 1:length(.na) )
#      # .data <- set( .data, j=.na( .data[[j]] )  
#      .data[[j]] <- .na( .data[[j]] )
#      return(.data)
#  }
#    
# 
#  # USAGE 2:  na_replace( .data, .na, ... )   
#  if( ! missing(.na) && ! missing(...) ) {
#    vars <- select_vars( names(.data), ... )
#    for( v in vars )
#      .data[[v]] <- na.replace( .data[[v]], .na )
#    return(.data)
#  }
#    
#   
#  # USAGE 3: na_replace( .data. col1=na.*, col2=na.* )
#  if( missing(.na) && length( list(...) ) > 0 ) 
#    vars <- names(.data) else 
#    vars <- select_vars( names(.data), ... )
#    
#    
#  for( v in vars )
#    .data[[v]] <- na.replace( .data[[v]], .na )
#  .data
#  
#  
#  
# }
