xvec <- c("foo <- function(x, y = \"a\",",
          "                d = \"something\", # comment",
          "                z = TRUE, r = as.character(z)) {")
daa <- c(y = "y = \"a\"",
         d = "d = \"something\"",
         z = "z = TRUE",
         r = "r = as.character(z)")

context("assign_defaults")

test_that("default arg selection is prepped sensibly",{

  ## select all the things
  x <- paste(xvec, collapse = "\n")
  expect_equivalent(prep_text(x), daa)

  ## select exactly one line
  expect_equivalent(prep_text(xvec[1]), daa["y"])
  expect_equivalent(prep_text(xvec[2]), daa["d"])
  expect_equivalent(prep_text(xvec[3]), daa[c("z", "r")])

  ## select exactly two lines
  x <- paste(xvec[1:2], collapse = "\n")
  expect_equivalent(prep_text(x), daa[c("y", "d")])
  x <- paste(xvec[2:3], collapse = "\n")
  expect_equivalent(prep_text(x), daa[c("d", "z", "r")])

  ## partial selection of first line
  xvec_sloppy <- c(substr(xvec[1], 10, 100), xvec[-1])
  x <- paste(xvec_sloppy, collapse = "\n")
  expect_equivalent(prep_text(x), daa)

  ## partial selection of last line
  xvec_sloppy <- c(xvec[1:2], substr(xvec[3], 1, 45))
  x <- paste(xvec_sloppy, collapse = "\n")
  expect_equivalent(prep_text(x), daa)

  xvec_sloppy <- c(xvec[1:2], substr(xvec[3], 1, 46))
  x <- paste(xvec_sloppy, collapse = "\n")
  expect_equivalent(prep_text(x), daa)

})

