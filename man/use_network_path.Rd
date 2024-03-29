% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{use_network_path}
\alias{use_network_path}
\title{Use a stored network path}
\usage{
use_network_path(...)
}
\arguments{
\item{...}{path elements (character). Path to a network folder or file, relative to \code{get_network_path()}.
Individual components will be combined with \code{\link[=file.path]{file.path()}}}
}
\value{
full path to a folder or file
}
\description{
This will retrieve and use a stored network path in conjunction with a provided file or
folder path.
}
\examples{
\dontrun{
use_network_path("file.csv")
use_network_path("folder_name/file.csv")
# In a function call:
read.csv(use_network_path("folder_name/file.csv"))
}
}
