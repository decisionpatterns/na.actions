#' Last Observation Carried Forward
#' 
#' Generic function for replacing each \code{NA} with the most recent
#' non-\code{NA} prior to it.
#' 
#' 
#' @aliases na_locf na_locf.data.frame na_locf.list na_locf.default
#' 
#' @param object an object.
#' @param na_rm logical. Should leading \code{NA}s be removed?
#' @param fromLast logical. Causes observations to be carried backward rather
#' than forward.  Default is \code{FALSE}.  With a value of \code{TRUE} this
#' corresponds to NOCB (next observation carried backward).  It is not
#' supported if \code{x} or \code{xout} is specified.
#' @param rev Use \code{fromLast} instead.  This argument will be eliminated in
#' the future in favor of \code{fromLast}.
#' @param maxgap Runs of more than \code{maxgap} \code{NA}s are retained, other
#' \code{NA}s are removed and the last occurrence in the resulting series prior
#' to each time point in \code{xout} is used as that time point's output value.
#' (If \code{xout} is not specified this reduces to retaining runs of more than
#' \code{maxgap} \code{NA}s while filling other \code{NA}s with the last
#' occurrence of a non-\code{NA}.)
#' @param rule See \code{\link{approx}}.
#' @param \dots further arguments passed to methods.
#' @return An object in which each \code{NA} in the input object is replaced by
#' the most recent non-\code{NA} prior to it.  If there are no earlier
#' non-\code{NA}s then the \code{NA} is omitted (if \code{na_rm = TRUE}) or it
#' is not replaced (if \code{na_rm = FALSE}).
#' 
#' The arguments \code{x} and \code{xout} can be used in which case they have
#' the same meaning as in \code{\link{approx}}.
#' 
#' Note that if a multi-column zoo object has a column entirely composed of
#' \code{NA} then with \code{na_rm = TRUE}, the default, the above implies that
#' the resulting object will have zero rows. Use \code{na_rm = FALSE} to
#' preserve the \code{NA} values instead.
#' @seealso \code{\link{zoo}}
#' @keywords ts
#' @examples
#' 
#' az <- zoo(1:6)
#' 
#' bz <- zoo(c(2,NA,1,4,5,2))
#' na_locf(bz)
#' na_locf(bz, fromLast = TRUE)
#' 
#' cz <- zoo(c(NA,9,3,2,3,2))
#' na_locf(cz)
#' 
#' # generate and fill in missing dates
#' z <- zoo(c(0.007306621, 0.007659046, 0.007681013,
#' 	0.007817548, 0.007847579, 0.007867313),
#' 	as.Date(c("1993-01-01", "1993-01-09", "1993-01-16",
#' 	"1993-01-23", "1993-01-30", "1993-02-06")))
#' g <- seq(start(z), end(z), "day")
#' na_locf(z, xout = g)
#' 
#' # similar but use a 2 second grid
#' 
#' z <- zoo(1:9, as.POSIXct(c("2010-01-04 09:30:02", "2010-01-04 09:30:06",
#'  "2010-01-04 09:30:07", "2010-01-04 09:30:08", "2010-01-04 09:30:09", 
#'  "2010-01-04 09:30:10", "2010-01-04 09:30:11", "2010-01-04 09:30:13",
#'  "2010-01-04 09:30:14")))
#' 
#' g <- seq(start(z), end(z), by = "2 sec")
#' na_locf(z, xout = g)
#' 
#' ## get 5th of every month or most recent date prior to 5th if 5th missing.
#' ## Result has index of the date actually used.
#' 
#' z <- zoo(c(1311.56, 1309.04, 1295.5, 1296.6, 1286.57, 1288.12, 
#' 1289.12, 1289.12, 1285.33, 1307.65, 1309.93, 1311.46, 1311.28, 
#' 1308.11, 1301.74, 1305.41, 1309.72, 1310.61, 1305.19, 1313.21, 
#' 1307.85, 1312.25, 1325.76), as.Date(c(13242, 13244, 
#' 13245, 13248, 13249, 13250, 13251, 13252, 13255, 13256, 13257, 
#' 13258, 13259, 13262, 13263, 13264, 13265, 13266, 13269, 13270, 
#' 13271, 13272, 13274)))
#' 
#' # z.na is same as z but with missing days added (with NAs)
#' # It is formed by merging z with a zero with series having all the dates.
#' 
#' rng <- range(time(z))
#' z.na <- merge(z, zoo(, seq(rng[1], rng[2], by = "day")))
#' 
#' # use na_locf to bring values forward picking off 5th of month
#' na_locf(z.na)[as.POSIXlt(time(z.na))$mday == 5]
#' 
#' ## this is the same as the last one except instead of always using the
#' ## 5th of month in the result we show the date actually used
#' 
#' # idx has NAs wherever z.na does but has 1, 2, 3, ... instead of
#' # z.na's data values (so idx can be used for indexing)
#' 
#' idx <- coredata(na_locf(seq_along(z.na) + (0 * z.na)))
#' 
#' # pick off those elements of z.na that correspond to 5th
#' 
#' z.na[idx[as.POSIXlt(time(z.na))$mday == 5]]
#' 
#' ## only fill single-day gaps
#' 
#' merge(z.na, filled1 = na_locf(z.na, maxgap = 1))
#' 
#' ## fill NAs in first column by inflating the most recent non-NA
#' ## by the growth in second column.  Note that elements of x-x
#' ## are NA if the corresponding element of x is NA and zero else
#' 
#' m <- zoo(cbind(c(1, 2, NA, NA, 5, NA, NA), seq(7)^2), as.Date(1:7))
#' 
#' r <- na_locf(m[,1]) * m[,2] / na_locf(m[,2] + (m[,1]-m[,1]))
#' cbind(V1 = r, V2 = m[,2])
#' 
#' ## repeat a quarterly value every month
#' ## preserving NAs
#' zq <- zoo(c(1, NA, 3, 4), as.yearqtr(2000) + 0:3/4)
#' tt <- as.yearmon(start(zq)) + seq(0, len = 3 * length(zq))/12
#' na_locf(zq, xout = tt, maxgap = 0)
#' 
#' 
#' 
#' @export 

na_locf <- function(object, na_rm = TRUE, ...) UseMethod("na_locf")

#' @rdname na_locf
#' @export 

na_locf.default <-
  function(object,
           na_rm = TRUE,
           fromLast,
           rev,
           maxgap = Inf,
           rule = 2,
           ...
  ) {
    L <- list(...)
    if ("x" %in% names(L) || "xout" %in% names(L)) {
      if (!missing(fromLast)) {
        stop("fromLast not supported if x or xout is specified")
      }
      return(
        na_approx(
          object,
          na_rm = na_rm,
          maxgap = maxgap,
          method = "constant",
          rule = rule,
          ...
        )
      )
    }
    
    na_locf.0 <- function(x) {
      L <- !is.na(x)
      idx <- if (fromLast)
        rev(c(NA, rev(which(L)))[cumsum(rev(L)) + 1])
      else
        c(NA, which(L))[cumsum(L) + 1]
      # na_index(x,i) returns x[i] except if i[j] is NA then
      # x[i[j]] is NA too
      na_index <- function(x, i) {
        L <- !is.na(i)
        x[!L] <- NA
        x[L] <- coredata(x)[i[L]]
        x
      }
      xf <- na_index(x, idx)
      .fill_short_gaps(x, xf, maxgap = maxgap)
    }
    if (!missing(rev)) {
      warning("na_locf.default: rev= deprecated. Use fromLast= instead.")
      if (missing(fromLast))
        fromLast <- rev
    } else if (missing(fromLast))
      fromLast <- FALSE
    rev <- base::rev
    object[] <- if (length(dim(object)) == 0)
      na_locf.0(object)
    else
      apply(object, length(dim(object)), na_locf.0)
    if (na_rm)
      na_trim(object, is.na = "all")
    else
      object
  }

#' @rdname na_locf
#' @export 
na_contiguous.data.frame <-
  
#' @rdname na_locf
#' @export   
na_contiguous.zoo <- function(object, ...) 
{
    if (length(dim(object)) == 2) 
        good <- apply(!is.na(object), 1, all)
    else good <- !is.na(object)
    if (!sum(good)) 
        stop("all times contain an NA")
    tt <- cumsum(!good)
    ln <- sapply(0:max(tt), function(i) sum(tt == i))
    seg <- (seq_along(ln)[ln == max(ln)])[1] - 1
    keep <- (tt == seg)
    st <- min(which(keep))
    if (!good[st]) 
        st <- st + 1
    en <- max(which(keep))
    omit <- integer(0)
    n <- NROW(object)
    if (st > 1) 
        omit <- c(omit, 1:(st - 1))
    if (en < n) 
        omit <- c(omit, (en + 1):n)
    cl <- class(object)
    if (length(omit)) {
        object <- if (length(dim(object))) 
            object[st:en, ]
        else object[st:en]
        attr(omit, "class") <- "omit"
        attr(object, "na_action") <- omit
        if (!is.null(cl)) 
            class(object) <- cl
    }
    object
}

#' @rdname na_locf
#' @export 


na_contiguous.list <- function(object, ...)
	lapply(object, na_contiguous)
