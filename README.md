
## na.actions: Comprehensive Library For Handling Missing Values

[![License](http://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html)
[![CRAN](http://www.r-pkg.org/badges/version/na.actions)](https://cran.rstudio.com/web/packages/na.actions/index.html)
[![Downloads](http://cranlogs.r-pkg.org/badges/na.actions?color=brightgreen)](http://www.r-pkg.org/pkg/na.actions)


**na.actions** is a comprehensive library for handling missing (NA) values.
It had two goals: 1) extend existing `na.*` functions from the stats packages 
and 2) provide **dplyr**/**tidyverse** compliant methods for tables and lists. 

There are methods for the detection, removal, replacement, recollection, 
imputation, etc. of `NAs`.  In short, it is a comprehensive tool box for common 
operations when working with missing values.

In ass

## Feature List
 
 * Over 80 functions for working with missing values (See [#Function List] below.) 
 * Standardizes and extends `na.*` functions found in the *stats* package.
 * Provides **dplyr**/**tidyverse** inteface for working with table data
 * Replacement/Imputation
   * Type/class and length-safe replacement: **na.actions** will never change 
     produce an object with a different length/nrow or type/class of its target.
   * Replace using scalar, vector, functions
   * Support for ordered or time-series data: `na.loess`, `na.locf`, `na.locb`, `na.trim`
   * Summary function for common replacements: `mean`, `median`, `max`, `min`, `zero`
   * Support for recursive (list or table-like structures)
   * Easy mnemonic: 
     - `na.*` operates on vectors like na.omit
     - `na_*` operates on tables in dplyr/tidyvese comliant way.
  * Four, extensible types of Imputations

### Upcoming features

 * (-tk) recall/track which values have been replaced
 * `na.quantile`
 * `by-group` calculations
 * Model-based imputation 
   - Model-based + by-groups
   

## Installation

### Github 

    library(devtools)
    install_github( "decisionpatterns/na.actions")
    
    
### CRAN 

Coming Soon ...
  

## Function List 

### Calculation 

 * `na.n` - Count mising values 
 * `na.pct` - Calculate pct of missing values

### Identification and Tests

 * `which.na` - Return logical or character 
 * `na.all` (`all.na`) - test if all elements are missing
 * `na.any` (`any.na`) - test if any elements are missing
   
### Removal / Ommision / Exclusion 

 * `na.rm` - remove `NA`s
 * `na.trim` - remove `NA`s from beginning or end (order matters)
 
 
**Table Only Functions:**
 * `drop_rows_all_na`, `drop_rows_any_na`
 * `drop_cols_all_na`, `drop_cols_any_na`
 
 
### Replacement / Imputation ###

There are four types of imputation methods. They are distinguished by
how the replacement values are calculated. Each is described below as well as 
describing each of the methods used.

**Constants**

In "constant" imputation methods, missing values are replaced by an 
*a priori* selected constant value. The vector containing the missing values 
is not used to calculate the replacement value. These take the form: `na.fun(x, ...)`

 * `na.zero` - 0 
 * `na.inf` / `na.neginf` - Inf/-Inf
 * `na.constant` (deprecated: use `na_replace`)


**Computed (univariate)**

(Impute using a functions of the target variable)

In "computed, univariate" replacement methods, values are calculated using 
the containing vector alone. The ordering of the vector does not affect 
imputed values. 

 * `na.n` - count of NA values
 * `na.max` - maximum  
 * `na.min` - minumum 
 * `na.mean` - mean 
 * `na.median` - median value
 * `na.quantile` - quantile value
 * `na.sample`/`na.random` - randomly sampled value


**Computed (univariate, ordered/time-series objects)**

(Imputed using a function of the target variable when the variable is ordered.)

In "Computed univariate and ordered" methods, replacement valuse are calculated
from the vector that is assumed to be ordered. These types are very
often used with **time-series** data.

 * `na.loess` - loess smoother, assumes values are ordered
 * `na.locf` - last observation carried forward, assumes ordered 
 * `na.nocb` - next observation carried backwards, assumes ordered

 * `na.structTS` - Kalman Filter replacement
 * `na.spline` - Interpolated replacement; Taken from the `zoo` package. 
 * `na.approx` - Interpolated replacement; Taken from the `zoo` package. 
 * `na.aggregate` - Replace by aggregate values Taken from the `zoo` package.

 
**Computed (multivariate)**

(Impute with multiple variables)

In "Computed multivariate" imputation, any value from the same 
row (observation) can be used to derive the replacement value. This is generally 
implemented as 

 * `na_fit`,`na_predict` - use a model 



 
**General**
 * `na.replace`/`na.explicit` - atomic vectors only. General replacement function
 * `na.implicit` - turn explicit values to NAs

 
**Misc.** 
 * `na.roughfix.POSIXct` - Impute for POSIXct vectors in the RandomForest package
 

**Future:**
 * `na.unreplace`/`na.restore` - restore NAs to the vector; remembering
    replacement
 * `na.toggle` - toggle between `NA` and replacement values


 






### Miscellaneous

 * na.roughfix.POSIXct - use with datetime values

 
## Examples

    v <- 1:3
    v[2] <- NA_real_
     
    na.replace( v, 2) 
    na.replace( v, mean )
    