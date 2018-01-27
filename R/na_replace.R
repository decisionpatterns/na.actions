#' Replace NAs with explicit values  
#'
#' Replaces `NA` values with explicit values.
#'
#' @param x vector in which `NA` values are to be replaced. 
#' @param .na scalar, length(x)-vector or function used to replace `NA`. 
#'   See #Details. 
#' 
#' @details 
#' 
#' `na_replace` replaces missing values in `x` by `.na`. 
#' 
#' Replacement is both class/type and length safe meaning the result 
#' is guaranteed to be the same class/type and length of `x` regardless of the 
#' value of `.na`. 
#' 
#' **Param: `x`** 
#' 
#' If `x` is **categorical** (e.g. character or factor), `.na` is optional. 
#' The default is "(NA)" and can be set with 
#' `options( NA_explicit_ = new_value )`. It can also be 
#' referenced directly with [NA_explicit_].
#'  
#' If `x` is a **factor**, unique values of `.na` not in already present in 
#' `levels(x)` will be added. They are appended silently unless 
#' `getOption('verbose')==TRUE` in which a message reports the added levels.
#' 
#' 
#' **Param: `.na`**
#' 
#' `.na` can be either a scalar, vector or function.
#' 
#' If a **scalar**, each missing value of `x` is replaced by `na`.
#' 
#' If a **vector**, `.na` must have length(x)`. Missing values of `x` are replaced 
#' by corresponding elements of `.na`.  Recycling values of `.na` is not 
#' performed. An error will be thrown in the event that `length(.na)` is not `1`
#' or `length(x)`.`  
#'    
#' If a **function**, `x` is transformed by .na` with:
#' ````
#'      .na( na.omit(x) )
#' ````    
#' then preceding with normal operations.          
#'    
#'    
#' `na.replace` is a alias for na_replace that is likely to be deprecated.  
#' 
#' @return 
#' A vector with the class and length of `x`.  
#' `NA`s in `x` will be replaced by `.na`. `.na` is coerced as necessary.
#' 
#' @seealso 
#' 
#'  - [na_explicit()] for a similar function that additionally handles recursive
#'  - and table-like objects 
#'  - [base::ifelse()], [base::replace()] 
#'  - `forcats::fct_explicit_na` - which only handles factors
#'   
#' @examples 
#' 
#'   # Integers and numerics
#'   na_replace( c(1,NA,3,NA), 2 )    # 1 2 3 2   
#'   na_replace( c(1,NA,3,NA), 1:4 )  # 1 2 3 4
#' 
#'   na_replace( c(1,NA,3,NA), letters[1:4] )  # "1" "b" "3" "d"
#' 
#'   # Characters 
#'   lets <- letters[1:5]
#'   lets[ c(2,4) ] <- NA
#'   lets %>% na_replace
#' 
#'   # Factors 
#'   fct <- as.factor( c( NA, letters[2:4], NA) )
#'   fct
#'   na_replace(fct, "z")  # z b c d z  -- level z added
#'   na_replace(fct, letters[1:5] )
#'   na_replace(fct)
#'      
#'      
#' @md
#' @rdname na_replace
#' @export


na_replace <- function(x, .na=NULL, ...) { 
  
 if( is.recursive(x) ) .na_replace.data.frame(x, ...)
  #  stop( call.=FALSE, "na_replace does not support recursive objects. See na_explicit.")
  
  # CHECK .na length == 1 or length(x)
  if( ! missing(.na) )
    if( ! length(.na) %in% c(1,length(x)) )  
      stop( "length(.na) is not 1 or length(x); recycling of .na is not allowed.")
  
  UseMethod("na_replace")
}


#' @export 
.na_replace.data.frame <- function(x, ...) { 
  message("inside")
  list(...)
}

#' @export
na_replace.default <- function(x, .na) {
  
  # When .na is a function, apply is
  if( is.function(.na) ) .na <- .na( na.omit(x) )
  
  # Ensure type safety
  .na <- coerce_to( .na, class(x) )

  # support for vector replacement  
  if( length(.na) == 1 )
    x[ is.na(x) ] <- .na else
    x[ is.na(x) ] <- .na[ is.na(x) ]

  x  
  
}



#' @export
# Replacement with factors requires managing new-levels  
na_replace.factor <- function( x, .na=getOption('NA_explicit_') ) { 

  # When .na is a function, apply is
  if( is.function(.na) ) .na <- .na( na.omit(x) )
    
  new_levels <- setdiff( unique(.na), levels(x) ) 
  
  if( length(new_levels) > 0 ) { 
    if( getOption('verbose') ) 
      warning( "Adding levels to factor: ", paste( new_levels, sep=", "))
    levels(x) <- c( levels(x), new_levels )
  }
    
  # While this is virtually identical to 
  if( length(.na) == 1 )
    x[ is.na(x) ] <- .na else
    x[ is.na(x) ] <- .na[ is.na(x) ]

  x  
    
}




#' @export 
na_replace.character <- function( x, .na=getOption('NA_explicit_') ) 
  na_replace.default(x, .na )


  
#' @rdname na_replace
#' @export

na.replace <- function(x, .na ) {
  warning( "na.replace has been renamed to na_replace. Please change your code.")
  na_replace(x, .na)
}



 