#' @export
na_spline <- function(object, ...) UseMethod("na_spline")

#' @export
na_spline.zoo <- function(object, x = index(object), xout, ..., na_rm = TRUE, along) {

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
    result[] <- na_spline.default(object, x = x, xout = xout, na_rm = FALSE, ...)
    if ((!missing(order.by) && !is.null(order.by)) || !missing.xout) {
        index(result) <- order.by
    }

    if (na_rm) {
        result <- na_trim(result, is.na = "all")
    }

    result

}

#' @export
na_spline.zooreg <- function(object, ...) {
    object. <- structure(object, class = setdiff(class(object), "zooreg"))
    as.zooreg(na_spline(object., ...))
}


#' @export
na_spline.default <- function(object, x = index(object), xout = x, ..., na_rm = TRUE, maxgap = Inf, along) {

    if (!missing(along)) {
        warning("along to be deprecated - use x instead")
        if (missing(x)) x <- along
    }

    na_spline.vec <- function(x, y, xout = x, ...) {
        na <- is.na(y)
        yf <- splinefun(x[!na], y[!na], ...)(xout)
        if (maxgap < length(y)) {
            ## construct version of y with only gaps > maxgap
            ygap <- .fill_short_gaps(y, seq_along(y), maxgap = maxgap)
            ## construct y values at 'x', keeping NAs from ygap
            ## (spline() does not allow NAs to be propagated)
            ix <- splinefun(x, seq_along(y), ...)(xout)
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
        na_spline.vec(x., coredata(object.), xout = xout., ...)
    } else {
        apply(coredata(object.), 2, na_spline.vec, x = x., xout = xout., ...)
    }

    if (na_rm) {
        result <- na_trim(result, is.na = "all")
    }

    result

}

#' @export
na_spline.ts <- function(object, ...) {
    as.ts(na_spline(as.zoo(object), ...))
}

