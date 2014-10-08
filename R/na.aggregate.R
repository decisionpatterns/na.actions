#' Replace NA by Aggregation
#' 
#' Generic function for replacing each \code{NA} with aggregated values. This
#' allows imputing by the overall mean, by monthly means, etc.
#' 
#' 
#' @aliases na.aggregate na.aggregate.default
#' @param object an object.
#' @param by a grouping variable corresponding to \code{object}, or a function
#' to be applied to \code{time(object)} to generate the groups.
#' @param \dots further arguments passed to \code{by} if \code{by} is a
#' function.
#' @param FUN function to apply to the non-missing values in each group defined
#' by \code{by}.
#' @param na.rm logical. Should any remaining \code{NA}s be removed?
#' @param maxgap maximum number of consecutive \code{NA}s to fill. Any longer
#' gaps will be left unchanged.
#' @return An object in which each \code{NA} in the input object is replaced by
#' the mean (or other function) of its group, defined by \code{by}. This is
#' done for each series in a multi-column object. Common choices for the
#' aggregation group are a year, a month, all calendar months, etc.
#' 
#' If a group has no non-missing values, the default aggregation function
#' \code{mean} will return \code{NaN}. Specify \code{na.rm = TRUE} to omit such
#' remaining missing values.
#' @seealso \code{\link{zoo}}
#' @keywords ts
#' @examples
#' 
#' z <- zoo(c(1, NA, 3:9),
#'          c(as.Date("2010-01-01") + 0:2,
#'            as.Date("2010-02-01") + 0:2,
#'            as.Date("2011-01-01") + 0:2))
#' ## overall mean
#' na.aggregate(z)
#' ## group by months
#' na.aggregate(z, as.yearmon)
#' ## group by calendar months
#' na.aggregate(z, months)
#' ## group by years
#' na.aggregate(z, format, "%Y")
#' 
#' @export na.aggregate
na.aggregate <- function(object, ...) UseMethod("na.aggregate")

## fills NA values with some aggregated function of the data.
## generalises imputing by the overall mean, by calendar month, etc.
na.aggregate.default <- function(object, by = 1, ..., FUN = mean, na.rm = FALSE, maxgap = Inf)
{
    if (is.function(by)) by <- by(time(object), ...)
    ## applied to each aggregated group in each series:
    f <- function(x)
        replace(x, is.na(x), FUN(x[!is.na(x)]))
    na.aggregate.0 <- function(y) {
        yf <- ave(y, by, FUN = f)
        .fill_short_gaps(y, yf, maxgap = maxgap)
    }
    object[] <- if (length(dim(object)) == 0) na.aggregate.0(object)
                else apply(object, 2, na.aggregate.0)
    if (na.rm) na.trim(object, is.na = "all") else object
}
