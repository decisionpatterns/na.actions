#' Replace NA by Interpolation
#' 
#' Generic functions for replacing each `NA` with interpolated values.
#' 
#' Missing values (`NA`s) are replaced by linear interpolation via
#' [approx()] or cubic spline interpolation via [spline()],
#' respectively.
#' 
#' It can also be used for series disaggregation by specifying `xout`.
#' 
#' By default the index associated with `object` is used for
#' interpolation. Note, that if this calls `index.default` this gives an
#' equidistant spacing `1:NROW(object)`. If `object` is a matrix or
#' data.frame, the interpolation is done separately for each column.
#' 
#' If `obj` is a plain vector then `na.approx(obj, x, y, xout, ...)`
#' returns `approx(x = x[!na], y = coredata(obj)[!na], xout = xout, ...)`
#' (where `na` indicates observations with `NA`) such that
#' `xout` defaults to `x`.
#' 
#' If `obj` is a `zoo`, `zooreg` or `ts` object its
#' `coredata` value is processed as described and its time index is
#' `xout` if specified and `index(obj)` otherwise. If `obj` is
#' two dimensional then the above is applied to each column separately. For
#' examples, see below.
#' 
#' If `obj` has more than one column, the above strategy is applied to
#' each column.
#' 
#' @aliases na.approx na.approx.zoo na.approx.zooreg na.approx.ts
#' na.approx.default na.spline na.spline.zoo na.spline.zooreg na.spline.ts
#' na.spline.default
#' @param object object in which `NA`s are to be replaced
#' @param x,xout Variables to be used for interpolation as in
#' [approx()].
#' @param na.rm logical. If the result of the (spline) interpolation still
#' results in `NA`s, should these be removed?
#' @param maxgap maximum number of consecutive `NA`s to fill. Any longer
#' gaps will be left unchanged. Note that all methods listed above can accept
#' `maxgap` as it is ultimately passed to the `default` method.
#' @param along deprecated.
#' @param \dots further arguments passed to methods. The `n` argument of
#' [approx()] is currently not supported.
#' @return An object of similar structure as `object` with (internal)
#' `NA`s replaced by interpolation. Leading or trailing `NA`s are
#' omitted if `na.rm = TRUE` or not replaced if `na.rm = FALSE`.
#' @seealso [zoo()], [approx()],
#' [na.contiguous()], [na.locf()], [na.omit()],
#' [na.trim()], [spline()],
#' [stinepack:stinterp()]
#' @keywords ts
#' @examples
#' 
#' 
#' z <- zoo(c(2, NA, 1, 4, 5, 2), c(1, 3, 4, 6, 7, 8))
#' 
#' ## use underlying time scale for interpolation
#' na.approx(z) 
#' ## use equidistant spacing
#' na.approx(z, 1:6)
#' 
#' # with and without na.rm = FALSE
#' zz <- c(NA, 9, 3, NA, 3, 2)
#' na.approx(zz, na.rm = FALSE)
#' na.approx(zz)
#' 
#' d0 <- as.Date("2000-01-01")
#' z <- zoo(c(11, NA, 13, NA, 15, NA), d0 + 1:6)
#' 
#' # NA fill, drop or keep leading/trailing NAs
#' na.approx(z)
#' na.approx(z, na.rm = FALSE)
#' 
#' # extrapolate to point outside of range of time points
#' # (a) drop NA, (b) keep NA, (c) extrapolate using rule = 2 from approx()
#' na.approx(z, xout = d0 + 7)
#' na.approx(z, xout = d0 + 7, na.rm = FALSE)
#' na.approx(z, xout = d0 + 7, rule = 2)
#' 
#' # use splines - extrapolation handled differently
#' z <- zoo(c(11, NA, 13, NA, 15, NA), d0 + 1:6)
#' na.spline(z)
#' na.spline(z, na.rm = FALSE)
#' na.spline(z, xout = d0 + 1:6)
#' na.spline(z, xout = d0 + 2:5)
#' na.spline(z, xout = d0 + 7)
#' na.spline(z, xout = d0 + 7, na.rm = FALSE)
#' 
#' ## using na.approx for disaggregation
#' zy <- zoo(1:3,  2000:2001)
#' 
#' # yearly to monthly series
#' zmo <- na.approx(zy, xout = as.yearmon(2000+0:13/12))
#' zmo
#' 
#' # monthly to daily series
#' sq <- seq(as.Date(start(zmo)), as.Date(end(zmo), frac = 1), by = "day")
#' zd <- na.approx(zmo, x = as.Date, xout = sq)
#' head(zd)
#' 
#' # weekly to daily series
#' zww <- zoo(1:3, as.Date("2001-01-01") + seq(0, length = 3, by = 7))
#' zww
#' zdd <- na.approx(zww, xout = seq(start(zww), end(zww), by = "day"))
#' zdd
#' 
#' # The lines do not show up because of the NAs
#' plot(cbind(z, z), type = "b", screen = 1)
#' # use na.approx to force lines to appear
#' plot(cbind(z, na.approx(z)), type = "b", screen = 1)
#' 
#' # Workaround where less than 2 NAs can appear in a column
#' za <- zoo(cbind(1:5, NA, c(1:3, NA, 5), NA)); za
#' 
#' ix <- colSums(!is.na(za)) > 0
#' za[, ix] <- na.approx(za[, ix]); za
#' 
#' # using na.approx to create regularly spaced series
#' # z has points at 10, 20 and 40 minutes while output also has a point at 30
#' if(require("chron")) {
#'   tt <- as.chron("2000-01-01 10:00:00") + c(1, 2, 4) * as.numeric(times("00:10:00"))
#'   z <- zoo(1:3, tt)
#'   tseq <- seq(start(z), end(z), by = times("00:10:00"))
#'   na.approx(z, xout = tseq)
#' }
#' 
#' @export na.approx
na.approx <- function(object, ...) UseMethod("na.approx")


#' @export 

na.approx.zoo <- function(object, x = index(object), xout, ..., na.rm = TRUE, along) {

    if (!missing(along)) {
        warning("along to be deprecated - use x instead")
        if (missing(x)) x <- along
    }

    missing.xout <- missing(xout) || is.null(xout)
    if (is.function(x)) x <- x(index(object))
    if (!missing.xout && is.function(xout)) xout <- xout(index(object))
    order.by <- if (missing.xout) index(object) else xout
    xout <- if (missing.xout) x else xout

    if (missing.xout || identical(xout, index(object))) {
        result <- object
    } else {
        object.x <- object
        if (!identical(class(x), class(xout))) {
            index(object.x) <- as.numeric(x)
            xout <- as.numeric(xout)
        } else {
            index(object.x) <- x
        }
        objectm <- merge(object.x, zoo(, xout))
        if (length(dim(objectm)) == 2) colnames(objectm) <- colnames(object)
        result <- window(objectm, index = xout)
    }
    result[] <- na.approx.default(object, x = x, xout = xout, na.rm = FALSE, ...)
    if ((!missing(order.by) && !is.null(order.by)) || !missing.xout) {
        index(result) <- order.by
    }

    if (na.rm) {
        result <- na.trim(result, is.na = "all")
    }

    result

}

#' @export 
na.approx.zooreg <- function(object, ...) {
    object. <- structure(object, class = setdiff(class(object), "zooreg"))
    as.zooreg(na.approx(object., ...))
}

#' @export 
na.approx.default <- function(object, x = index(object), xout = x, ..., na.rm = TRUE, maxgap = Inf, along) {

    if (!missing(along)) {
        warning("along to be deprecated - use x instead")
        if (missing(x)) x <- along
    }

    na.approx.vec <- function(x, y, xout = x, ...) {
        na <- is.na(y)
        yf <- approx(x[!na], y[!na], xout, ...)$y
        if (maxgap < length(y)) {
            ## construct a series like y but with only gaps > maxgap
            ## (actual values don't matter as we only use is.na(ygap) below)
            ygap <- .fill_short_gaps(y, seq_along(y), maxgap = maxgap)
            ## construct y values at 'xout', keeping NAs from ygap
            ## (using indexing, as approx() does not allow NAs to be propagated)
            ix <- approx(x, seq_along(y), xout, ...)$y
            yx <- ifelse(is.na(ygap[floor(ix)] + ygap[ceiling(ix)]),
                         NA, yf)
            yx
        } else {
            yf
        }
    }

    if (!identical(length(x), length(index(object)))) {
        stop("x and index must have the same length")
    }
    x. <- as.numeric(x)
    if (missing(xout) || is.null(xout)) xout <- x.
    xout. <- as.numeric(xout)
    object. <- coredata(object)

    result <- if (length(dim(object.)) < 2) {
        na.approx.vec(x., coredata(object.), xout = xout., ...)
    } else {
        apply(coredata(object.), 2, na.approx.vec, x = x., xout = xout., ...)
    }

    if (na.rm) {
        result <- na.trim(result, is.na = "all")
    }

    result

}

#' @export 
na.approx.ts <- function(object, ...) {
    as.ts(na.approx(as.zoo(object), ...))
}


## x = series with gaps
## fill = same series with filled gaps
.fill_short_gaps <- function(x, fill, maxgap) {
    if (maxgap <= 0)
        return(x)
    if (maxgap >= length(x))
        return(fill)
    naruns <- rle(is.na(x))
    naruns$values[naruns$lengths > maxgap] <- FALSE
    naok <- inverse.rle(naruns)
    ifelse(naok, fill, x)
}
