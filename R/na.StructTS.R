#' Fill NA or specified positions.
#' 
#' Generic function for filling `NA` values using seasonal Kalman filter.
#' 
#' Interpolate with seasonal Kalman filter.  The input object should have a
#' frequency. It is assumed the cycle length is 1.
#' 
#' @param object an object.
#' @param \dots other arguments passed to methods.
#' @param na.rm logical.  Whether to remove end portions or fill them with NA.
#' @param maxgap Runs of more than `maxgap` `NA`s are retained, other
#' `NA`s are removed and the last occurrence in the resulting series prior
#' to each time point in `xout` is used as that time point's output value.
#' 
#' 
#' @seealso 
#'   [na.approx()]
#' 
#' @examples
#' 
#'   z <- zooreg(rep(10 * seq(4), each = 4) + rep(c(3, 1, 2, 4), times = 4), 
#' 	 start = as.yearqtr(2000), freq = 4)
#'   z[10] <- NA
#' 
#'   zout <- na.StructTS(z)
#' 
#'   plot(cbind(z, zout), screen = 1, col = 1:2, type = c("l", "p"), pch = 20)
#'   
#' @keywords ts
#' @aliases na.StructTS na.StructTS.zoo na.StructTS.ts
#' @export na.StructTS

na.StructTS <- function(object, ...) UseMethod("na.StructTS")

#' @export
na.StructTS.ts <- function(object, ..., na.rm = FALSE, maxgap = Inf)
{
	print("entering ts method")
    na.StructTS.0 <- function(y) {
        yf <- y
		isna <- is.na(y)
		yf[isna] <- rowSums(tsSmooth(StructTS(y))[,-2])[isna]
        .fill_short_gaps(y, yf, maxgap = maxgap)
    }
    object[] <- if (length(dim(object)) == 0) na.StructTS.0(object)
                else apply(object, 2, na.StructTS.0)
    if (na.rm) na.trim(object, is.na = "all") else object
}

#' @export
na.StructTS.zoo <- function(object, ..., na.rm = FALSE, maxgap = Inf) {
	print("entering zoo method")
	z <- na.StructTS(as.ts(object), ..., na.rm = FALSE, maxgap = maxgap)
	z <- as.zoo(z)
	time(z) <- time(object)
    if (na.rm) na.trim(z, is.na = "all") else z
}

