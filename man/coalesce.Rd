% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coalesce.R
\name{coalesce}
\alias{coalesce}
\title{Coalesce}
\usage{
coalesce(series)
}
\arguments{
\item{series}{Vector of the time series to coalesce.}
}
\value{
List giving the coalesced time series and its base.
}
\description{
Coalesce a time series into as few contiguous states as possible. The magic
of information measures is that the actual values of a time series
are irrelevant. For example, \code{[0, 1, 0, 1, 1]} has the same entropy as
\code{[2, 9, 2, 9, 9} (possibly up to a rescaling). This give us the freedom
to shift around the values of a time series as long as we do not change the
relative number of states. This function thus provides a way of "compressing"
a time series into as small a base as possible. Many of the measures use the
base of the time series to determine how much memory to allocate; the larger
the base, the higher the memory usage. It also affects the overall
performance as the combinatorics climb exponentially with the base. The two
standard usage cases for this function are to reduce the base of a time
series or ensure that the states are non-negative. Notice that the encoding
that is used ensures that the ordering of the states stays the same.
}
\examples{
coalesce(c(0, 2, 0, 2, 0, 2))
coalesce(c(-8, 2, 6, -2, 4))
}
