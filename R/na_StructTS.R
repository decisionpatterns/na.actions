#' Fill NA or specified positions.
#' 
#' Generic function for filling \code{NA} values using seasonal Kalman filter.
#' 
#' Interpolate with seasonal Kalman filter.  The input object should have a
#' frequency. It is assumed the cycle length is 1.
#' 
#' @aliases na_StructTS na_StructTS.zoo na_StructTS.ts
#' @param object an object.
#' @param \dots other arguments passed to methods.
#' @param na_rm logical.  Whether to remove end portions or fill them with NA.
#' @param maxgap Runs of more than \code{maxgap} \code{NA}s are retained, other
#' \code{NA}s are removed and the last occurrence in the resulting series prior
#' to each time point in \code{xout} is used as that time point's output value.
#' @seealso \code{\link{na_approx}}
#' @keywords ts
#' @examples
#' 
#' 
#' z <- zooreg(rep(10 * seq(4), each = 4) + rep(c(3, 1, 2, 4), times = 4), 
#' 	start = as.yearqtr(2000), freq = 4)
#' z[10] <- NA
#' 
#' zout <- na_StructTS(z)
#' 
#' plot(cbind(z, zout), screen = 1, col = 1:2, type = c("l", "p"), pch = 20)
#' 
#' 
#' 
#' @export na_StructTS
na_StructTS <- function(object, ...) UseMethod("na_StructTS")

#' @export
na_StructTS.ts <- function(object, ..., na_rm = FALSE, maxgap = Inf)
{
	print("entering ts method")
    na_StructTS.0 <- function(y) {
        yf <- y
		isna <- is.na(y)
		yf[isna] <- rowSums(tsSmooth(StructTS(y))[,-2])[isna]
        .fill_short_gaps(y, yf, maxgap = maxgap)
    }
    object[] <- if (length(dim(object)) == 0) na_StructTS.0(object)
                else apply(object, 2, na_StructTS.0)
    if (na_rm) na_trim(object, is.na = "all") else object
}

#' @export
na_StructTS.zoo <- function(object, ..., na_rm = FALSE, maxgap = Inf) {
	print("entering zoo method")
	z <- na_StructTS(as.ts(object), ..., na_rm = FALSE, maxgap = maxgap)
	z <- as.zoo(z)
	time(z) <- time(object)
    if (na_rm) na_trim(z, is.na = "all") else z
}

