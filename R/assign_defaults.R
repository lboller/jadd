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
#' @param fun The name of a function.
#' @name assign_defaults
NULL

#' @rdname assign_defaults
#' @export
assign_defaults_addin <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  text <- rstudioapi::primary_selection(context)$text
  assign_defaults(text)
}

#' @rdname assign_defaults
#' @export
assign_defaults <- function(fun) {
  fun_fmls <- formals(fun)

  #msg <- paste0(
  #  "Setting formal arguments of `", "()` to their default values\n"
  #)

  for (i in seq_along(fun_fmls)) {
    nm <- names(fun_fmls)[[i]]
    val <- fun_fmls[[i]]

    if (missing(val)) {
      fun_fmls[[i]] <- "<no assignment made>"
    } else {
      if (!is.null(val)) {
        fun_fmls[[i]] <- eval(val, envir = globalenv())
      }
      assign(nm, fun_fmls[[i]], envir = globalenv())
    }
  }

  msg <- c(
    msg,
    paste0(format(names(fun_fmls), justify = 'right'), ": ", fun_fmls, "\n")
  )
  #message(msg)
  invisible()
}
