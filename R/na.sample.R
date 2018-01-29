#' na.sample
#' 
#' Replace missing values with value randomly drawn from x
#' 
#' @param x vector with 
#' @param population ither a vector of one or more elements from which to choose, or a 
#'        positive integer. See [base::sample()]. (Default: `na.omit(x)`)
#' @param replace logical indicationg that sampling should be performed 
#'        with replacement? (Default: `TRUE``)
#' @param prob  vector of probability weights for obtaining the elements of 
#'        the vector being sampled. (Default: `NULL` equal weights)  
#' 
#' @details 
#' 
#' `na.random` replaces missing values by sampling the non-missing values 
#' **with replacement**. This relies on [base::sample()].
#' 
#' The default is to replace bv sampling a population defined by the 
#' non-missing values of `.x` **with replacement** 
#'  
#' `na.random` is an alias for `na.sample`vlu
#' `
#' @note `na.sample` is **non-deterministic**. Use 
#'       [base::set.seed()] to make it deterministic
#' 
#' @export

na.sample <- function(x, population=na.omit(x), replace=TRUE, prob=NULL )
  na.replace( x, .na=sample( population, size=length(x), replace, prob ) )

#' @rdname na.sample
#' @export
na.random <- function(x, ... )
  na.replace( x, .na=sample( na.omit(x), size=length(x), replace=TRUE, ... ) )
