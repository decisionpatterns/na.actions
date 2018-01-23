## TODO ##

 - Consider having an option for values for the na_level, e.g.
      options( na_explicit = "(Missing)" ) or, 
      options( na_explicit = mean )  
 -  Categorical and continuous variables must be different.
 
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
 