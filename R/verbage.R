#' verbage
#' 
#' Make dplyr verbs simply 
#' 
#' Make table/recursive versions of vector replacement functions
#' 
#' @param fun vector imputation method.
#' 
#' @details 
#' 
#' Meta function that creates a table ready version of an vector replacement 
#' method.
#' 
#' @export  

mk_recursive <- function( fun ) { 
  
  function( .tbl, ... )  {
  
    # If .tbl is not a recursive object fall-back to treating as a vector.
    if( ! is.recursive( .tbl ) ) { 
      return( fun( x=.tbl, ...) )
    }
    
    ll <- list(...)

    if( length(ll) == 0  )
      for( i in length(.tbl) )
        .tbl[[i]] <- fun( )

      
    # First handle the name=values pairs
    #  - use kv function
    #  - if value is function apply it to x[[ key ]]
    for( kv in kv( ll ) ) 
      .tbl[[kv$k]] <- fun( .tbl[[kv$k]], .na=kv$v, ... )
    
    .tbl
 }
  
}

#' 
#' @rdname na-tables
#' @export
na_constant <- mk_recursive(na.constant)

#' @rdname na-tables 
#' @export
na_zero <- mk_recursive(na.zero)
