## TODO

 - Devise syntax of related to list-like/recursive objects 
   - applying a function to an **entire**  vs.
   -  applying to each **element** object

 - na_row_rm, na_col_rm for table-like objects
    - Remove rows/cols with all/any NAs

 - Rename package nada ("nothing"); or part of the **exceptional** packages to 
   handle NA, Inf, -Inf, 0 values  
   
 - Handle R/coredata?
 
 - Make na_replace accept a function or expression as well. If an expression, 
   should also provide an environment as well.  
   
     x %>% na_replace( function(x) ifexists(x,y,z) )
 
### Completed 

 - [x] Make na_replace vectorized, e.g. na_replace( value=... )
 