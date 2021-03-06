% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/to_json.R
\name{to_ndjson}
\alias{to_ndjson}
\title{To ndjson}
\usage{
to_ndjson(x, unbox = FALSE, digits = NULL, numeric_dates = TRUE,
  factors_as_string = TRUE, by = "row")
}
\arguments{
\item{x}{object to convert to JSON}

\item{unbox}{logical indicating if single-value arrays should be 'unboxed', 
that is, not contained inside an array.}

\item{digits}{integer specifying the number of decimal places to round numerics.
Default is \code{NULL} - no rounding}

\item{numeric_dates}{logical indicating if dates should be treated as numerics. 
Defaults to TRUE for speed. If FALSE, the dates will be coerced to character in UTC time zone}

\item{factors_as_string}{logical indicating if factors should be treated as strings. Defaults to TRUE.}

\item{by}{either "row" or "column" indicating if data.frames and matrices should be processed
row-wise or column-wise. Defaults to "row"}
}
\description{
Converts R objects to ndjson
}
\details{
Lists are converted to ndjson non-recursively. That is, each of the objects
in the list at the top level are converted to a new-line JSON object. Any nested
sub-elements are then contained within that JSON object. See examples
}
\examples{

to_ndjson( 1:5 )
to_ndjson( letters )

mat <- matrix(1:6, ncol = 2)

to_ndjson( x = mat )
to_ndjson( x = mat, by = "col" )

df <- data.frame(
  x = 1:5
  , y = letters[1:5]
  , z = as.Date(seq(18262, 18262 + 4, by = 1 ), origin = "1970-01-01" )
  )

to_ndjson( x = df )
to_ndjson( x = df, numeric_dates = FALSE )
to_ndjson( x = df, factors_as_string = FALSE )
to_ndjson( x = df, by = "column" )

## Lists are non-recurisve; only elements `x` and `y` are converted to ndjson
lst <- list(
  x = 1:5
  , y = list(
    a = letters[1:5]
    , b = data.frame(i = 10:15, j = 20:25)
  )
)
 
to_ndjson( x = lst )
to_ndjson( x = lst, by = "column")


}
