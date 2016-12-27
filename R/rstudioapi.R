#' Inspect information available via rstudioapi
#'
#' Prints the output of these calls to the rstudioapi package:
#' \itemize{
#' \item getActiveProject()
#' \item getActiveDocumentContext()
#' \item getSourceEditorContext()
#' \item getConsoleEditorContext()
#' \item primary_selection(getSourceEditorContext()
#' }
#'
#' @export
rstudioapi_addin <- function() {

  bx <- function(txt) c(strrep("*", 60), txt, strrep("*", 60))

  curious_minds <- list(
    quote(rstudioapi::getActiveProject()),
    quote(rstudioapi::getActiveDocumentContext()),
    quote(rstudioapi::getSourceEditorContext()),
    quote(rstudioapi::getConsoleEditorContext()),
    quote(rstudioapi::primary_selection(rstudioapi::getSourceEditorContext()))
  )
  lapply(curious_minds, function(f) {
    writeLines(bx(deparse(f)))
    print(eval(f))
    print(str(eval(f)))
  })
}
