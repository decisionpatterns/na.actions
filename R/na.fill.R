# fill is a 3 component list or is coerced to one representing
# fill char to left of leftmost non-NA, fill character to interior NAs
#  and fill char to right of rightmost non-NA
# If component is "extend" then left or rightmost NA is extended or interior
#  NA is linearly interpolated
# If component is NULL then the corresponding NA is dropped.



#' Fill NA or specified positions.
#' 
#' Generic function for filling `NA` values or specified positions.
#' 
#' Fill `NA` or indicated values.
#' 
#' @aliases na.fill na.fill.ts na.fill.zoo na.fill.default
#' @param object an object.
#' @param fill a three component list or a vector that is coerced to a list.
#' Shorter objects are recycled.  The three components represent the fill value
#' to the left of the data, within the interior of the data and to the right of
#' the data, respectively.  The value of any component may be the keyword
#' `"extend"` to indicate repetition of the leftmost or rightmost non-NA
#' value or linear interpolation in the interior.  `NULL` means that items
#' are dropped rather than filled.
#' @param ix logical. Should be the same length as the number of time points.
#' Indicates which time points not to fill. This defaults to the non-NA values.
#' @param \dots further arguments passed to methods.
#' @seealso [na.approx()]
#' @keywords ts
#' @examples
#' 
#' 
#' z <- zoo(c(NA, 2, NA, 1, 4, 5, 2, NA))
#' na.fill(z, "extend")
#' na.fill(z, c("extend", NA))
#' na.fill(z, -(1:3))
#' na.fill(z, list(NA, NULL, NA))
#' 
#' 
#' @export na.fill

na.fill <- function(object, fill, ...) UseMethod("na.fill")


#' @export 
na.fill.zoo <- function(object, fill, ix, ...) {

	if (length(dim(object)) == 2 && NCOL(object) > 1) {
		ixmiss <- missing(ix)
		L <- lapply(1:NCOL(object), 
				function(i) {
					if (ixmiss) ix <- !is.na(object[,i])
					na.fill(object[,i], fill, ix, ...)
				})
		out <- do.call("merge", c(L, all = FALSE))
		colnames(out) <- colnames(object)
		return(out)
	}

	if (missing(ix)) ix <- !is.na(object)

	if ((is.logical(ix) && any(ix)) || (!is.logical(ix) && length(ix))) {

		n <- length(object)
		# integer indexes for output points which are present
		wix <- if (is.logical(ix)) which(ix) else ix
		# min and max integer index
		wx.min <- head(wix, 1) 
		wx.max <- tail(wix, 1)
		# similar to wrng <- wx.min:wx.max
		wrng <- seq(wx.min, length = wx.max - wx.min + 1)

		# recycle to length 3
		fill <- rep(as.list(fill), length = 3)
		# we will be coercing fill values to the class of coredata(data).
		# This allows fill=c("extend", NA) to work even though NA is coerced to
		#  a character NA.
		as.cls <- if (is.numeric(coredata(object))) as.numeric else as.logical
		fill <- lapply(fill, function(x) if (is.character(x) &&
			pmatch(x, "extend", nomatch = 0)) "extend" else as.cls(x))
		# fill points on left
		if (length(fill[[1]]) > 0) 
			if (!is.null(fill[[1]])) object[seq_len(wx.min - 1)] <- 
				if (is.character(fill[[1]]) && fill[[1]] == "extend")
						object[[wx.min]] else fill[[1]]
		# fill intermediate points
		# - this is for zoo method, for zooreg method it would be possible to
		#   perform linear interpolation in proportion to time rather than
		#   in proportion to the integer index
		if (length(fill[[2]]) > 0) {
			if (is.character(fill[[2]]) && fill[[2]] == "extend") object[wrng] <- 
					# as.list(approx(wix, unlist(object[wix]), xout = wrng)$y)
					approx(wix, unlist(object[wix]), xout = wrng)$y
			else object[intersect(which(!ix), wrng)] <- fill[[2]]
		}
		# fill points on right
		if (length(fill[[3]]) > 0) 
			object[seq(wx.max + 1, length = n - wx.max)] <- 
				if (is.character(fill[[3]]) && fill[[3]] == "extend")
						object[[wx.max]] else fill[[3]]

		keep <- seq_len(n)
		if (length(fill[[1]]) == 0) keep <- unique(pmax(wx.min, keep))
		if (length(fill[[2]]) == 0) {
			wrng <- seq(wx.min, length = wx.max - wx.min + 1)
			keep <- setdiff(keep, intersect(which(!ix), wrng))
		}
		if (length(fill[[3]]) == 0) keep <- unique(pmin(wx.max, keep)) 
		object[keep, , drop = is.null(dim(object))]
	}

}

#' @export
na.fill.default <- function(object, fill, ix, ...) {
	coredata(na.fill(zoo(object), fill, ix, ...))
}

#' @export
na.fill.ts <- function(object, fill, ix, ...) {
	as.ts(na.fill(as.zoo(object), fill, ix, ...))
}

