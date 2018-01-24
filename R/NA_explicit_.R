options( NA_explicit_ = ".NA")

#' NA_explicit_
#'
#' Constant for categorical/character/factor variables
#' 
#' @details 
#' 
#' `NA_explicit_` is an active binding to `getOptions('NA_explicit_`)` and 
#' allows for a consistent, explicit `NA` values.
#' 
#' @seealso 
#' 
#'  - [na_explicit()]
#'  - [na_replace()]
#' 
#' @md
#' @export

NA_explicit_  <-
  makeActiveBinding("NA_explicit_",
                function(x) getOption("NA_explicit_"),
                sys.frame(0)
  )
