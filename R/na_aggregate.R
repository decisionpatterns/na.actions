#' Replace NAs by aggregation
#' 
#' Generic function for replacing each `NA` with aggregated values. This
#' allows imputing by the overall mean, by monthly means, etc.
#' 
#' @param object an object.
#' @param by a grouping variable corresponding to `object`, or a function
#' to be applied to `time(object)` to generate the groups.
#' @param \dots further arguments passed to `by` if `by` is a
#' function.
#' @param FUN function to apply to the non-missing values in each group defined
#' by `by`.
#' @param na_rm logical. Should any remaining `NA`s be removed?
#' @param maxgap maximum number of consecutive `NA`s to fill. Any longer
#' gaps will be left unchanged.
#' @return An object in which each `NA` in the input object is replaced by
#' the mean (or other function) of its group, defined by `by`. This is
#' done for each series in a multi-column object. Common choices for the
#' aggregation group are a year, a month, all calendar months, etc.
#' 
#' If a group has no non-missing values, the default aggregation function
#' `mean` will return `NaN`. Specify \code{na_rm = TRUE} to omit such
#' remaining missing values.
#' 
#' @seealso 
#'   [na_mean()], [na_max()], [na_median()], etc. for similar
#'   
#' @examples
#' 
#'   z <- zoo(c(1, NA, 3:9),
#'          c(as.Date("2010-01-01") + 0:2,
#'            as.Date("2010-02-01") + 0:2,
#'            as.Date("2011-01-01") + 0:2)
#'          )
#'          
#'   ## overall mean
#'   na_aggregate(z)
#'   ## group by months
#'   na_aggregate(z, as.yearmon)
#'   ## group by calendar months
#'   na_aggregate(z, months)
#'   ## group by years
#'   na_aggregate(z, format, "%Y")
#' 
#' @md
#' @aliases na_aggregate na_aggregate.default
#' @export 

na_aggregate <- function(object, ...) UseMethod("na_aggregate")

## fills NA values with some aggregated function of the data.
## generalises imputing by the overall mean, by calendar month, etc.

#' @export

na_aggregate.default <- function(object, by = 1, ..., FUN = mean, na_rm = FALSE, maxgap = Inf)
{
    if (is.function(by)) by <- by(time(object), ...)
    ## applied to each aggregated group in each series:
    f <- function(x)
        replace(x, is.na(x), FUN(x[!is.na(x)]))
    na_aggregate.0 <- function(y) {
        yf <- ave(y, by, FUN = f)
        .fill_short_gaps(y, yf, maxgap = maxgap)
    }
    object[] <- if (length(dim(object)) == 0) na_aggregate.0(object)
                else apply(object, 2, na_aggregate.0)
    if (na_rm) na_trim(object, is.na = "all") else object
}
