#' jadd
#'
#' Jenny's RStudio addins
#'
#' @name jadd
#' @docType package
NULL

#' Set function arguments to defaults
#'
#' Set function arguments in selection to their default values in the global
#' environment. Objective is to aid function development and debugging. Some
#' sloppiness in selection in tolerated. Arguments with no defaults are silently
#' ignored -- it is assumed the developer will set them to something sensible
#' "by hand". Also \code{...} is dropped.
#'
#' @export
assign_defaults_addin <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  text <- context$selection[[1]]$text
  prepped <- prep_text(text)
  eval_global(prepped)
}

prep_text <- function(x) {
  args <- trimws(unlist(strsplit(x, split = "[\n,]")))
  n_open <- vapply(args, count_char, integer(1), char = "\\(")
  n_close <- vapply(args, count_char, integer(1), char = "\\)")
  open_no_close <- n_open > n_close
  close_no_open <- n_open < n_close
  args[open_no_close] <- gsub("^.*\\(", "", args[open_no_close])
  args[close_no_open] <- gsub("\\)[^\\)]*$", "", args[close_no_open])
  is_not_ddd <- args != "..."
  has_default <- grepl("=", args)
  args[is_not_ddd & has_default]
}

count_char <- function(x, char) {
  pos <- unlist(gregexpr(pattern = char, text = x))
  sum(pos > 0)
}

eval_global <- function(x) {
  for (i in seq_along(x)) {
    eval(parse(text = x), envir = globalenv())
  }
}

