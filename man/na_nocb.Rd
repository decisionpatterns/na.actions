% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/na_nocb.R
\name{na_nocb}
\alias{na_nocb}
\title{na_nocb (_N_ext _O_bservation _C_arried _B_ack )}
\usage{
na_nocb(object, ...)
}
\arguments{
\item{object}{an object}

\item{...}{arguments passed to \code{na_locf}

\code{na_nocb} uses \code{zoo::}\code{na_locf}.}
}
\value{
a object with NA's replaced by the next occuring value in the sequence
}
\description{
na_nocb (_N_ext _O_bservation _C_arried _B_ack )
}
\examples{

  na_nocb( c(NA,1:3))

}
\seealso{
\code{\link[zoo]{na_locf}}
}
