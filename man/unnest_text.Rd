% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/unnest_text.R
\name{unnest_text}
\alias{unnest_text}
\title{Un-nest Nested Text Columns}
\usage{
unnest_text(dataframe, column, integer.rownames = TRUE, ...)
}
\arguments{
\item{dataframe}{A dataframe object.}

\item{column}{Column name to search for markers/terms.}

\item{integer.rownames}{logical.  If \code{TRUE} then the rownames are 
numbered 1 through number of rows, otherwise the original row number is 
retained followed by a period and the element number from the list.}

\item{\ldots}{ignored.}
}
\value{
Returns an un-nested data.frame.
}
\description{
Un-nest nested text columns in a data.frame.   Attempts to locate the nested 
text column without specifying.
}
\examples{
dat <- DATA

## Add a nested/list text column
dat$split <- lapply(dat$state, function(x) {
    unlist(strsplit(x, '(?<=[?!.])\\\\s+', perl = TRUE))
})

unnest_text(dat)
unnest_text(dat, integer.rownames = FALSE)

## Add a second nested integer column
dat$d <- lapply(dat$split, nchar)
\dontrun{
unnest_text(dat) # causes error, must supply column explicitly
}
unnest_text(dat, 'split')

## As a data.table
library(data.table)
dt_dat <- data.table::as.data.table(data.table::copy(dat))
unnest_text(dt_dat, 'split')
\dontrun{
unnest_text(dt_dat, 'd')
}

\dontrun{
## As a tibble
library(tibble)
t_dat <- tibble:::as_tibble(dat)
unnest_text(t_dat, 'split')
}
}
