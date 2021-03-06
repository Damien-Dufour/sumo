% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Comp3Moy.R
\name{Comp3Moy}
\alias{Comp3Moy}
\title{Comp3Moy}
\usage{
Comp3Moy(Condition, Measure, n = 3)
}
\arguments{
\item{Condition}{the different conditions named in the same column
library}

\item{Measure}{the values measured for every sample}

\item{n}{is the number or replicates per condition}
}
\description{
Compare 3 or more datasets using the right test according to normality and variances

@import rstatix
@import dplyr
@importFrom methods show

@examples

Comp3Moy(Dataset$sex, Dataset$size)
}
