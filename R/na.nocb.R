#' na.nocb (_N_ext _O_bservation _C_arried _B_ack )
#' 
#' @param object an object
#' @param ... arguments passed to `na.locf`
#' 
#' `na.nocb` uses `zoo::``na.locf`.
#' 
#' @return a object with NA's replaced by the next occuring value in the sequence
#' @seealso
#'   [zoo:na.locf()] 
#'   
#' @examples 
#' 
#'   na.nocb( c(NA,1:3))
#' 
#' @rdname na.locf
#' @export  
    
na.nocb <- function( object , ... ) {
  na.locf( object, fromLast=TRUE, ...)
}
