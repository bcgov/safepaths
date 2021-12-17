# Copyright 2020 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.


#' Use a stored network path
#'
#' This will retrieve and use a stored network path in conjunction with a provided file or
#' folder path.
#'
#' @param ... path elements (character). Path to a network folder or file, relative to `get_network_path()`.
#'            Individual components will be combined with [file.path()]
#'
#' @return full path to a folder or file
#' @export
#'
#' @examples
#' \dontrun{
#' use_network_path("file.csv")
#' use_network_path("folder_name/file.csv")
#' # In a function call:
#' read.csv(use_network_path("folder_name/file.csv"))
#' }
use_network_path <- function(...) {
  x <- list(...)
  if (!all(vapply(x, is.character, FUN.VALUE = logical(1)))) {
    stop("x must be a character string denoting a
          path relative to the network path set with `set_network_path()`.")
  }
  x <- do.call(file.path, x)
  root <- get_network_path()
  if (!dir.exists(root)) {
    stop(root, " Does not exist. Are you connected to the network?")
  }

  if (length(x) == 0) {
    return(root)
  }

  file.path(root, gsub("^/", "", x))
}


#' Set a network path
#'
#' This will add an environment variable called `SAFEPATHS_NETWORK_PATH` to
#' your `.Renviron` file and set the variable to the provided network
#' path.
#'
#' @param x character. A path to a folder on a network drive.
#' For Mac users it will look something like `"/Volumes/server_name/folder_name"`.
#' For Windows users, you can use the mapped drive letter or the UNC path
#' (e.g., `"P:/folder_name"` or `"//UNC_path"`).
#'
#' @return logical (invisibly)
#' @export
#'
#' @examples
#' \dontrun{
#' # Mac
#' set_network_path("/Volumes/server_name/folder_name")
#' # Windows
#' set_network_path("P:/folder_name") OR
#' set_network_path("//UNC_path")
#' }
set_network_path <- function(x) {
#   if (.Platform$OS.type == "windows" && grepl("\\\\", x)) {
#     stop("It looks like you are trying to set your network path as a UNC path
# (path beginning with \\). Please use the mapped drive letter (e.g., P:/etc).",
#          call. = FALSE)
# }

  home_dir <- Sys.getenv("HOME")
  renviron_file <- file.path(home_dir, ".Renviron")
  renviron_lines <- readLines(renviron_file)
  path_env <- grepl(paste0("^", path_envvar_name()), renviron_lines)
  if (any(path_env)) {
    overwrite <- utils::askYesNo("Your network path has already been set. Overwrite?")
    if (!overwrite) return(invisible(FALSE))
    renviron_lines <- renviron_lines[!path_env]
  }
  renviron_lines <- c(renviron_lines, "", "## network path",
                      paste0(path_envvar_name(), "=", x), "")

  writeLines(renviron_lines, con = renviron_file)
  message("Restart your R session for changes to take effect")
  invisible(TRUE)
}


#' Get network path
#'
#' This will retrieve the environment variable `SAFEPATHS_NETWORK_PATH`, which is stored in
#' your `.Renviron` file using `set_network_path()`.
#'
#'
#' @return stored network path
#' @export
#'
#' @examples
#' \dontrun{
#' get_network_path()
#' }
get_network_path <- function() {
  network_path <- Sys.getenv(path_envvar_name())

  safepaths_sitrep()
  network_path
}


#' Check to see if a setpath is set and accessible
#'
#' This function can be helpful to detect instances where you might not have
#' the path set or are connected to VPN. If you are not connected or the path is
#' not set, the function will. Otherwise, the function will return `TRUE` invisibly.
#'
#' @export

safepaths_sitrep <- function() {
  check_if_set()
  check_if_available()
  message("safepath set and accessible")
  invisible(TRUE)
}

path_envvar_name <- function() "SAFEPATHS_NETWORK_PATH"



check_if_set <- function() {
  if (!nzchar(Sys.getenv(path_envvar_name()))) {
    stop("You need to set your network path. Use set_network_path()", call. = FALSE)
  }
}

check_if_available <- function() {
  if (!dir.exists(Sys.getenv(path_envvar_name()))) {
    stop("There has been a problem. Are you sure you are connected to the VPN?", call. = FALSE)
  }
}
