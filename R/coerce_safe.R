#' coerce_safe
#' 
#' Coerce values in a safe, reversible and consistent way.
#'
#' @param object to be coerced
#' @param class character; class to which `object` should be coerced.
#' @param alert function to use to raise exceptions: (Default: [base::stop()])
#' @param ... unused
#' @param alert.irrevisible function to raise when coercion is not reversible. 
#'        See Details.
#' @param alert.na function to raise when `NAs` are produced.
#' 
#' `coerce_safe` coerces the class/types of `object` in a safe, consistent, 
#' non-destructible way. 
#' 
#' This means that safe coercion:
#'  1. is reversible, `x == inv_f( f(x))`: no data should be lost in the coercion.
#'  2. does not introduce (additional) missing values (`NA`) 
#'  
#' By default, `corece_safe` raises an error when the coercion is violates these
#' constraints.  The `alert` (or `alert.irreversible` or `alert.na`) can be used
#' to change the response.  These can be set to [base::warning()] or 
#' [base::message()] for a less severve behavior.
#'
#' @note
#' 
#' There must be a `as` method to the reverse coercion for this function to work.
#' 
#' @return 
#' 
#' @seealso
#'   [methods::as] 
#'   [coercion::try_as()]
#'   
#' @examples 
#' 
#' \dontrun{
#'   # Error
#'   1.01 %>% coerce_safe("integer")  # 1.01 != 1
#'   coerce_safe( c("1","2","a"), "integer" )
#' }
#' 
#' @md
#' @export 

coerce_safe <- function(object, class, alert=stop, ..., irreversible.alert=alert, na.alert=alert ) {
  
  if( is(object, class) ) {
    res <- object 
  } else { 
    suppressWarnings( res <- as(object, class) )  # Use coercion::try_as 
    # Test Reversible
    if( any(res != object, na.rm=TRUE ) ) stop( paste0( "Coercion to '", class, "' altered value(s)." ) )  
    
    # Test NAs introduced
    if( any( is.na(object) != is.na(res) ) )
      stop( "Coercion to '", class, "' introduced ", na.n(res) - na.n(object), " additional missing value(s) (NA)." )
    
  }
  
  res
    
}
