#' na_nocb (_N_ext _O_bservation _C_arried _B_ack )
#' 
#' @param object an object
#' @param ... arguments passed to \code{na_locf}
#' 
#' \code{na_nocb} uses \code{zoo::}\code{na_locf}.
#' 
#' @return a object with NA's replaced by the next occuring value in the sequence
#' @seealso
#'   \code{\link[zoo]{na_locf}} 
#'   
#' @examples 
#' 
#'   na_nocb( c(NA,1:3))
#' 
#' @import zoo
#' @export  
    
na_nocb <- function( object , ... ) {
  zoo::na.locf( object, fromLast=TRUE, ...)
}
