Class 7: Functions and Packages
================
Amy Prichard
January 30, 2019

Functions revisited
-------------------

Load (i.e. **source**) our rescale() function from last day.

``` r
source("http://tinyurl.com/rescale-R")
# loads several functions and couple data frames into the global environment (df1, df2, df3, both_na, both_na2, both_na3, gene_intersect, gene_intersect2, gene_intersect3, gene_intersect4, rescale, rescale2)
```

Test this function

``` r
rescale(1:5)
```

    ## [1] 0.00 0.25 0.50 0.75 1.00

``` r
# rescale(c(1:5,"string"))  # this would throw an error!
```

We want to make this function more robust to these types of errors

warning() \# Gives the user an error message without stopping the function. stop() \# Gives the user an error and stops running the function.

rescale2() starts with if(!is.numeric(x)) {stop("Input x should be numeric", call.=FALSE)} to stop the function if the input is not numeric.

``` r
# rescale2(c(1:5,"string"))  # this does not throw an error but stops the script
```

``` r
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3,  4)

is.na(x)
```

    ## [1] FALSE FALSE  TRUE FALSE  TRUE

``` r
is.na(y)
```

    ## [1]  TRUE FALSE  TRUE FALSE FALSE

``` r
is.na(x) & is.na(y)         # When are BOTH lists "NA"?
```

    ## [1] FALSE FALSE  TRUE FALSE FALSE

``` r
sum(is.na(x) & is.na(y))    # How many times does this happen?
```

    ## [1] 1

``` r
which(is.na(x) & is.na(y))  # Where does this happen?
```

    ## [1] 3

Now take our working snippet (sum(is.na(x) & is.na(y))) and make a function: "both\_na()" which tells you how many overlapping "NA" values there are

But... what if the two lists/vectors have different numbers of items?

``` r
x1 <- c(NA, NA, NA)
y1 <- c(1, NA, NA)

both_na(x1, y1)  # This is ok (as expected).
```

    ## [1] 2

``` r
y2 <- c(1, NA, NA, NA)
y3 <- c(1, NA, NA, NA, NA)

both_na(x1, y2)  # This doesn't work like we want it to.
```

    ## Warning in is.na(x) & is.na(y): longer object length is not a multiple of
    ## shorter object length

    ## [1] 3

Add a stop()

both\_na2() starts with if(length(x) != length(y)) {stop("Input x and y should be vectors of the same length", call.=FALSE)}

``` r
# both_na2(x1, y2)  # this stops the script!
```

Refine and polish: make our function more useful by returning more information *(see both\_na3)*

``` r
both_na3(x, y)
```

    ## Found 1 NA's at position(s):3

    ## $number
    ## [1] 1
    ## 
    ## $which
    ## [1] 3
