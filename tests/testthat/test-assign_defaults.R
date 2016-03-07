foo <- function(x, y = "a",
                ...,
                d = NULL, # comment
                k = c(2, 3),
                z = TRUE, r = as.character(z)) {
  invisible()
}

fav <- list(y = "a",
            d = NULL,
            k = c(2, 3),
            z = TRUE,
            r = "TRUE")

context("assign_defaults")

test_that("default args are assigned",{
  expect_false(any(names(fav) %in% ls(envir = globalenv())))
  assign_defaults(foo)
  expect_true(all(names(fav) %in% ls(envir = globalenv())))
  expect_identical(mget(names(fav), envir = globalenv()), fav)
})
