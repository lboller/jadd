```
ffmpeg -i assign_defaults.mov -vf scale=800:-1 -r 10 -f image2pipe -vcodec ppm - |    convert -delay 10 -layers Optimize -loop 0 - assign_defaults.gif
```

``` r
foo <- function(x, y = "a",
                d = "something", # comment
                z = TRUE, r = as.character(z)) {
  invisible()
}
```
