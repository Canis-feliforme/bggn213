ggplot2 demo
================
Amy Prichard
January 30, 2019

Setup
=====

``` r
# install.packages("ggplot2")
library(ggplot2)
ggplot(diamonds)  # if only the dataset is known.
```

![](ggplot2_stuff_files/figure-markdown_github/unnamed-chunk-1-1.png)

``` r
ggplot(diamonds, aes(x=carat))  # if only X-axis is known. The Y-axis can be specified in respective geoms.
```

![](ggplot2_stuff_files/figure-markdown_github/unnamed-chunk-1-2.png)

``` r
ggplot(diamonds, aes(x=carat, y=price))  # if both X and Y axes are fixed for all layers.
```

![](ggplot2_stuff_files/figure-markdown_github/unnamed-chunk-1-3.png)

``` r
ggplot(diamonds, aes(x=carat, color=cut))  # Each category of the 'cut' variable will now have a distinct  color, once a geom is added.
```

![](ggplot2_stuff_files/figure-markdown_github/unnamed-chunk-1-4.png)

``` r
ggplot(diamonds, aes(x=carat), color="steelblue")
```

![](ggplot2_stuff_files/figure-markdown_github/unnamed-chunk-1-5.png)

``` r
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + geom_smooth() # Adding scatterplot geom (layer1) and smoothing geom (layer2).
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

![](ggplot2_stuff_files/figure-markdown_github/unnamed-chunk-1-6.png)

``` r
ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=cut)) + geom_smooth(aes(x=carat, y=price, color=cut)) # Same as above but specifying the aesthetics inside the geoms.
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

![](ggplot2_stuff_files/figure-markdown_github/unnamed-chunk-1-7.png)

``` r
library(ggplot2)
ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=cut)) + geom_smooth(aes(x=carat, y=price)) # Remove color from geom_smooth
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

![](ggplot2_stuff_files/figure-markdown_github/unnamed-chunk-2-1.png)

``` r
ggplot(diamonds, aes(x=carat, y=price)) + geom_point(aes(color=cut)) + geom_smooth()  # same but simpler
```

    ## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

![](ggplot2_stuff_files/figure-markdown_github/unnamed-chunk-2-2.png)
