% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/na_trim.R
\name{na_trim}
\alias{na_trim}
\alias{na_trim.default}
\alias{na_trim.ts}
\title{Trim Leading/Trailing Missing Observations}
\usage{
na_trim(object, ...)
}
\arguments{
\item{object}{an object.}

\item{\dots}{further arguments passed to methods.}

\item{sides}{character specifying whether \code{NA}s are to be removed from
both sides, just from the left side or just from the right side.}

\item{is.na}{If "any" then a row will be regarded as \code{NA} if it has any
\code{NA}s.  If "all" then a row will be regarded as \code{NA} only if all
elements in the row are \code{NA}.  For one dimensional zoo objects this
argument has no effect.}
}
\value{
An object in which leading and/or trailing \code{NA}s have been
removed.
}
\description{
Generic function for removing leading and trailing \code{NA}s.
}
\examples{

# examples of na_trim
x <- zoo(c(1, 4, 6), c(2, 4, 6))
xx <- zoo(matrix(c(1, 4, 6, NA, 5, 7), 3), c(2, 4, 6))
na_trim(x)
na_trim(xx)

# using na_trim for alignment
# cal defines the legal dates
# all dates within the date range of x should be present
cal <- zoo(,c(1, 2, 3, 6, 7))
x <- zoo(c(12, 16), c(2, 6))
na_trim(merge(x, cal))
 
}
\seealso{
\code{\link{na_approx}}, \code{\link{na_contiguous}},
\code{\link{na_locf}}, \code{\link{na_omit}}, \code{\link{na_spline}},
\code{\link[stinepack]{stinterp}}, \code{\link{zoo}}
}
\keyword{ts}
