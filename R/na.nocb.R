#' na.nocb (_N_ext _O_bservation _C_arried _B_ack )
#' 
#' @param object an object
#' @param ... arguments passed to \code{na.locf}
#' 
#' \code{na.nocb} uses \code{zoo::}\code{na.locf}.
#' 
#' @return a object with NA's replaced by the next occuring value in the sequence
#' @seealso
#'   \code{\link[zoo]{na.locf}} 
#'
#' @export  
    
na.nocb <- function( object , ... ) {
  require(zoo)
  zoo::na.locf( object, fromLast=TRUE, ...)
}