#' Remove Leading/Trailing Missing Observations
#' 
#' Generic function for removing leading and trailing `NA`s.
#' 
#' @param object an object.
#' @param sides character specifying whether `NA`s are to be removed from
#' both sides, just from the left side or just from the right side.
#' @param is.na If "any" then a row will be regarded as `NA` if it has any
#' `NA`s.  If "all" then a row will be regarded as `NA` only if all
#' elements in the row are `NA`.  For one dimensional zoo objects this
#' argument has no effect.
#' @param \dots further arguments passed to methods.
#' 
#' @return An object in which leading and/or trailing `NA`s have been
#' removed.
#' 
#' @seealso
#'  
#'   [na_approx()], 
#'   [na_contiguous()],
#'   [na_locf()], 
#'   [na_omit()], 
#'   [na_spline()],
#'   [stinepack::stinterp()], 
#'   [zoo()]
#' 
#' @keywords ts
#' @examples
#' 
#' # examples of na.trim
#' x <- zoo(c(1, 4, 6), c(2, 4, 6))
#' xx <- zoo(matrix(c(1, 4, 6, NA, 5, 7), 3), c(2, 4, 6))
#' na.trim(x)
#' na.trim(xx)
#' 
#' # using na.trim for alignment
#' # cal defines the legal dates
#' # all dates within the date range of x should be present
#' cal <- zoo(,c(1, 2, 3, 6, 7))
#' x <- zoo(c(12, 16), c(2, 6))
#' na.trim(merge(x, cal))
#'  
#' @aliases na.trim na.trim.default na.trim.ts
#' @import zoo 
#' @export na.trim

na.trim <- function(object, ...) UseMethod("na.trim")

#' @export 

na.trim.default <- function (object, sides = c("both", "left", "right"), 
	is.na = c("any", "all"), ...)
{
   is.na <- match.arg(is.na)
   nisna <- if (is.na == "any" || length(dim(object)) < 2)  {
	complete.cases(object)
   } else rowSums(!is.na(object)) > 0
   idx <- switch(match.arg(sides), left = cumsum(nisna) > 0,
       right = rev(cumsum(rev(nisna) > 0)>0),
       both = (cumsum(nisna) > 0) & rev(cumsum(rev(nisna)) > 0))
   if (length(dim(object)) < 2)
       object[idx]
   else
       object[idx,, drop = FALSE]
}

## need a 'ts' method because indexing destroys ts attributes

#' @export
na.trim.ts <- function (object, ...)
{
    as.ts(na.trim(as.zoo(object), ...))
}
