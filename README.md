## RStudio addins

RStudio addins let you execute a bit of R code or a Shiny app through the 
RStudio IDE, either via the Addins dropdown menu or with a keyboard shortcut. 
Coupled with functions from the [`rstudioapi`](https://cran.r-project.org/web/packages/rstudioapi/index.html) package, this means you can operate
on your own R code, which is awesome.

RStudio docs on addins (with examples): 
<https://rstudio.github.io/rstudioaddins/>

To use addins:

  * Run RStudio v0.99.878 or later
    - <https://www.rstudio.com/products/rstudio/download/preview/>
  * Run `rstudioapi` package v0.5 or later
    - `install.packages("rstudioapi", type = "source")`
  * Populate your *Addins* dropdown menus with some examples
    - `devtools::install_github("rstudio/addinexamples", type = "source")`

I was inspired to try my hand at this by TJ Mahr's recent [WrapRmd 
addin](https://github.com/tjmahr/WrapRmd) which wraps R Markdown text w/o 
mangling inline R code.

### `assign_defaults_addin`

The `assign_defaults_addin` helps you develop and debug a function. Scenario: 
you're working on a function and want to walk through the body as if 
it were top-level code. But it is a PITA to set all the arguments to their
default values. Select the argument section of your function definition and
*Addins > Assign default values* will make assignments to the global 
environment. Arguments that have a default will be set to that value. Arguments 
with no default are ignored -- you must set those to something sensible 
yourself. And `...` must be dropped, so have fun with that too! I tried to allow
for some sloppiness with the selection, but I'm sure there's room for 
improvement.

To use this addin:

  * Run very recent RStudio IDE and `rstudioapi` package (see above)
  * `devtools::install_github("jennybc/jadd", type = "source")`
  * look for it in the *Addins* menu

![An animation of the above](internal/assign_defaults.gif)
