
## na.actions: tools for missing values

[![License](http://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html)
[![CRAN](http://www.r-pkg.org/badges/version/na.actions)](https://cran.rstudio.com/web/packages/na.actions/index.html)
[![Downloads](http://cranlogs.r-pkg.org/badges/na.actions?color=brightgreen)](http://www.r-pkg.org/pkg/na.actions)


**na.actions** provides tools for working with missing (`NA`) values. Functions 
are provided for replacement, imputation, removal and detection. 
The goals are create a collection of functions to extend the for the `na.*` 
family of functions that extends the native functions from the **stats* package 
and provide a comprehensive tool set for common problems encountered with 
missing values.


## Installation

### Github 

    library(devtools)
    install_github( "decisionpatterns/na.actions")
    
### CRAN 

Coming Soon ...
  


## Function List 

### `NA` Replacement and Imputation
 * na.inf / na.neginf - replance na with Inf/-Inf
 * na.loess - use loess smoother for replacement
 * na.max 
 * na.min 
 * na.mean
 * na.median
 * na.nocb - next observation carried backwards
 * na.predict - use a model 
 * na.replace / na.constant - replace with a constant \code{value}
 * na.zero - replace with 0 


### `NA` Imputation 

 * -tk


### `NA` Removal

 * na.rm 


### `NA` Detections

 * all_na
 * any_na


### Miscellaneous

 * na.roughfix.POSIXct - use with datetime values

 
## Examples

    na.replace( c(1,NA,3), 2)
  
