```
ffmpeg -i assign_defaults.mov -vf scale=800:-1 -r 10 -f image2pipe -vcodec ppm - |    convert -delay 10 -layers Optimize -loop 0 - assign_defaults.gif
```

``` r
foo <- function(x, y = "a",
                ...,
                d = NULL, # comment
                k = c(2, 3),
                z = TRUE, r = as.character(z)) {
  ## something incredibly long and probably broken
  invisible()
}
```
