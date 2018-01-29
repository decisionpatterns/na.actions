#' Replace missing values by most frequently value
#'
#' Replace missing value with the most-frequently, non-missing value
#' 
#' @param x
#' @param ... arguments passed to functions
#' 
#' @details 
#' 
#' In the event of ties, the values listed first is used.
#' 
#' @examples 
#' 
#'   c(1,1,NA,4) %>% na.most_freq()
#'   c(1,1,4,4,NA) %>% na.most_freq() 
#'
#' @md
#' @export

na.most_freq <- function(x, .na, ... ) 
  na.replace(x, most_freq(x, na.omit), ... )

