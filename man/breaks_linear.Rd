% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scale_breaks.R
\name{breaks_linear}
\alias{breaks_linear}
\alias{linear_breaks}
\title{Breaks linear}
\usage{
breaks_linear(n = 10)
}
\arguments{
\item{n}{<\code{int}> the size of the output vector. Ouput size will be at least length-2
for finite input.}
}
\description{
Generate a breaks vector of size \code{n} with linearly spaced breaks.
}
\details{
If input range is non-finite, an empty vector is returned.
}
\examples{
breaks_linear(5)(-10:10)
breaks_linear()(-1:1)

}
\seealso{
Other breaks: 
\code{\link{breaks_log}()},
\code{\link{breaks_manual}()},
\code{\link{breaks_power}()},
\code{\link{breaks_symlog}()},
\code{\link{breaks_trans}()}
}
\concept{breaks}
