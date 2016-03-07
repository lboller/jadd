#' Set function arguments to defaults
#'
#' Set arguments for a function to their default values in the global
#' environment. The addin takes \code{fun} from current text selection.
#'
#' The goal is to make it easier to walk through the function body as top-level
#' code for development and debugging. Arguments with no defaults and \code{...}
#' are silently ignored. In order for this to work, the function needs to be
#' defined through one of these methods:
#' \itemize{
#' \item \strong{RStudio: Run the current function definition}: With cursor in
#' the function, do Ctrl+Alt+F (Windows/Linux) or Command+Option+F (Mac).
#' \item \strong{Source the file with function definition}: Visit file in
#' RStudio editor and do Ctrl+Shift+S (Windows/Linux) or Command+Shift+S (Mac).
#' Or use \code{\link{source}()}.
#' \item \strong{\code{devtools::load_all()}}: Sensible if function is part of a
#' package and you're developing with \code{devtools}.
#' \item \strong{\code{library(...)}}: Sensible if function is an exported
#' function in an installed package.
#' }
#'
#' @param fun A function object or a character string naming the function. See
#' \code{\link{formals}} for details.
#' @name assign_defaults
NULL

#' @rdname assign_defaults
#' @export
assign_defaults_addin <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  text <- context$selection[[1]]$text
  assign_defaults(text)
}

#' @rdname assign_defaults
#' @export
assign_defaults <- function(fun) {
  fmls <- formals(fun)
  is_naked_name <- vapply(fmls, is.name, logical(1)) # fyi: this catches `...`
  fmls <- fmls[!is_naked_name]
  for (i in seq_along(fmls)) {
    if (is.language(fmls[[i]])) {
      thing <- eval(fmls[[i]], envir = globalenv())
    } else {
      thing <- fmls[[i]]
    }
    assign(names(fmls)[[i]], thing, envir = globalenv())
  }
}
