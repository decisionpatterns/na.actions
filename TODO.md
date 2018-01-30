## TODO ##

 na.tools has two sets of functions dots and underscores. The dot functions have
 names with `.`  (na.replace, na.rm, na.*). Like their inspiration from the 
 stats package, they operate on atomic vectors. 
 
 The underscore functions have
 names with `_` (na_replace, na_rm, na_*). They are meant to operate on 
 recursive structures such as lists and table-like structures and closely follow 
 dplyr/tidyverse standards and behaviors. ( They will also work on atomic 
 objects.)  
 
 - [ ] `na[._]impute` as alias for `na[._]replace` respectively.
 
 - [ ] `na.explicit` and `na_explicit` apply to factors only
 
 - [ ] Row-based imputation does not need to calculate every-value values for 
   all observations, only the missing ones. This is different than column-based
   imputations which need values from all observations. There might be some 
   efficiency gains from doing this.
   
 - [ ] There is a generalized imputation that uses both rows and columns and
   might automatically consider by-groups (how does the values of )
 
 - Should we permit some unsafe operations in na.replace?
   - Change length? No
   - Change value? No? With warning
   - Change type? Okay, if the coercion preserves the value
   
 - Differentiate class and type safety.
 
 - implement `ties` method  
 - na.random
   - weighted. 
 - na.shuffle.
 
 - favor `na.replace` & `na.restore` over `na.explicit` and `na.implicit`
 - `na.impute`(?) 
 
 - [x] Rename `.na` to `.fun`? No, because it may not be a function.
 
### `coerce_safe`

 - [ ] Handle **ALL NA** columns
 - [ ] Move `coerce_safe` to the **coercion** package. [ ] Import **coercion**.
 - [x] Move `coerce_to` functionality into `na.replace.default` -and/or- 
   rename to `coerce_safe` 
 
 
 - tbl version of na_replace / na_explicit (?)
   - should atomic be supported : LEAN: YES
   - should .na be supported for global replace (?) LEAN: YES 
   - should na_explicit be the same 
   - na_replace_all( .tbl, .funs)
   
   - _all, _if, _at
     - na_replace_all( .tbl, .funs, ... ) 
     - na_replace_if( .tbl, .predicate, .funs, ... )
     - na_replace_at( .tbl, .predicate, .funs, ... )
     
 ... w/atomics used as additional arguments to .na
 ... w/recurs used as name=... 
 
 
 
 So .tbl %>% na_replace_all( iris, 3, ...)
             na_replace( iris, mean, na.rm=TRUE )
             na_replace_if( iris, is.cont, mean, na.rm=TRUE )
             na_replace_at( iris, ! Species, mean, na.rm=TRUE )

 
 - na_replace and na_explicit
   - replace by scalar?  (Low-level)
   - replace by vector?  (Other)
   - replace by unary function? ()
   - replace by function of multiple args using  ...? ()
   - replace by model/formula? ()
   - type/class-safe? (low level) 
   - defaults (NA_explicit_) for categorical (low level)
   - automatically add/append factor levels (low level)
   - handle recursive objects (high level) ...  
   - store .na value (if scalar)
   - store replaced idxs --- like na.omit  

 - Should the package be reorganized as follows:
   - na.* functions operate on only atpomic and closely follow stat packages and 
     perhaps even re-exporting the stats packages functions if necessary.
     
   - na_* function would be higher order functions that operate on atomic and 
     recursive objects
   
 - If we are using prototype replacement with a vector ... how does that work?
   It cannot perhaps there should be a `na_mreplace` function that specifically
   applies 
   
 - How do we perform mutate_if on types/classes. See *catcont* package or maybe
   provide `na_explicit_if` or `na_replace_if` functions.
   
 - Implement slow functions with Rcpp 
 
 - check the class of `.na` in na_replace; warn(?)
 
 - Might there be a clever way to allow something like:

    NA_explicit_ <- . %>% mean(., na.rm=TRUE)
 
 - Consider having an option for values for the na_level, e.g.
      options( na_explicit = "(Missing)" ) or, 
      options( na_explicit = mean )  
 - Categorical and continuous variables must be different.
 - Explicit value might depend on the class, type (cat vs. cont), or on a 
   specific attribute, `na_explicit` or `na` of the specific vari`able. 
   
 - Test if `NA_explicit_` work when na.actions is imported.
   
 - alias as na_mutate, na_transmute or mutate_na, transmute_na,
   cf. dplyr::mutate_if, 
  
 - Consider how explicit NA will be treated in sorting 
   - Do we want exceptional values first or last?
   
 - What is the explicit value
 
 - na_ex
   
 - Functions such as `na_replace`, `na_explicit`, `na_max`, etc. should also 
   set the `na` attribute. 
   
 - change `values` argument to `na` or `.NA` 
   It cannot/should not be names NA as this is a reserved word. .NA is kinda-nice
  because it is most like na and is very apparent. na is also good.  .na changes
  too many things. 
  .Inf can also exist, but .0 cannot since this is a numeric
  
  .NA, .Inf, .NegInf, .zero or na, inf, neginf, zero?
  
  Could we do this ....

     tbl %>% na_replace( col1=max, col2=min, col3=0, ... )
  
  na_replace( x, .na=.values, ..., .values )
  na_replace( x, .na=.values, ...,  .values )
  na_explicit( x, .na=.values, ...,   .values=getOption('na_explicit.factor'))
  
  na_replace(x, 0 )
  na_replace(tbl,col= )
  
  
  I can see it ... so na, inf, neginf or zero might conflict with column names. 
  Best to prefix with .na, .Inf,
  
  Now does it make sense to 
  
  Will there ever be a case where there might be additional arguments passed or
  these might get mistaken for column names?
  
  
   + Doing so makes the argument explicit
   - Makes it non-parallel with `inf_replace`, `zero_replace`, etc. but this 
     might be alright as this would better allow wrapper functions to use 
     multiple exception handlers.
     
     A construction like .... 
     na_replace <- function( x, .na=values, values=getOption(...) )
     will allow for the use of values with default or .na
 
 - Use catcont package
 
 - `na_replace` and `na_explicit` are getting very similar and should probably be
   made aliases
   
 - Devise syntax of related to list-like/recursive objects 
   - applying a function to an **entire**  vs.
   - applying to each **element** object
   See na_explicit and na_implicit

 - [NO] Rename package nada ("nothing"); 
   - or, part of the **exceptional** packages to handle NA, Inf, -Inf, 0 values  
   - or, na.tools?
   
 - Handle R/coredata?
 
 - [ ] Make na_replace accept a function or expression as well. If an expression, 
   should also provide an environment as well.  
     x %>% na_replace( function(x) ifexists(x,y,z) )
     
 - What is faster ifelse or replace
   ifelse( is.na(x), y, x)
   replace( x, is.na(x), y[is.na(x)] )

### Completed 

 - [x] na_drop_rows, na_drop_cols for table-like objects
    - Remove rows/cols with all NAs
 - [x] Make na_replace vectorized, e.g. na_replace( value=... )
 - [x] na_ifelse for na_replace
 