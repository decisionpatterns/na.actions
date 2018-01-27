
## na.actions: Comprehensive Library For Handling Missing Values

[![License](http://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html)
[![CRAN](http://www.r-pkg.org/badges/version/na.actions)](https://cran.rstudio.com/web/packages/na.actions/index.html)
[![Downloads](http://cranlogs.r-pkg.org/badges/na.actions?color=brightgreen)](http://www.r-pkg.org/pkg/na.actions)


**na.actions** is a comprehensive library for handling missing (NA) values.
laregly extending the existing `na.*` functions found in the stats packages. 
These Functions provide for detection, removal, replacement, recollection, 
imputation, etc. of `NAs`.  In short, it is a comprehensive tool set for common 
operations when working with missing values.


## Feature List
 
 * Extents functionality of of existing `na.*` functions found in the *stats* 
   package.
 * `NA` replacement
   * type/class and length-safe replacement
   * replace by scalar, vector, functions
   * imputation with complex formula and methods
   * recall/track which value have been replaced
   * high-level function for common replacements: mean, median, max, min, zero, Inf


## Installation

### Github 

    library(devtools)
    install_github( "decisionpatterns/na.actions")
    
    
### CRAN 

Coming Soon ...
  

## Function List 

### Detections

 * which_na
 * all_na
 * any_na


### Removal / Ommision / Exclusion 

 * na_rm
 * na_trim 
 
 
### Replacement / Imputation

There are a num

Constants
 * na_zero - 0 
 * na.inf / na.neginf - Inf/-Inf
 * na_constant

Computed (univariate):
 * na_n - count of NA values
 * na_max - maximum  
 * na_min - minumum 
 * na_mean - mean 
 * na_median - median value


Computed (univariate, ordered/time-series objects): 
 * na_loess - loess smoother, assumes values are ordered
 * na_spline - 
 * na_locf - last observation carried forward, assumes ordered 
 * na_nocb - next observation carried backwards, assumes ordered
 * na_structTS - Kalman Filter replacement
 
 
Computed (multivariate)
 * na_predict - use a model 
 * na_roughfix - 
 * na_approx - 


General:
 * na_replace - atomic vectors only
 * na_explicit - atomic or recursive structures
 




### Miscellaneous

 * na.roughfix.POSIXct - use with datetime values

 
## Examples

    na.replace( c(1,NA,3), 2)
  
