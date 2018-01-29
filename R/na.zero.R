#' na_zero 
#'
#' Replaces `NA`s by 0. 
#'
#' @param x vector of values to have the NA replaced with `value`
#' 
#' @details 
#' 
#' `na_zero` replaces missing values with `0`. It is coerced to character or 
#' factor as needed.
#' 
#' @return 
#'   `x` with `NA`s replaced by 0.
#' 
#' @seealso 
#'   [na.replace()]
#'   [na.constant()] 
#'
#' @examples 
#'  
#'   library(mtcars) 
#'   mtcars <- head(mtcars)
#'   mtcars[3,] <- NA
#'   
#'   
#'   mtcars %>% na_zero(mpg, cyl)
#'   mtcars %>% na_zero(1,2:4)
#'   mtcars %>% na_zero("mpg", "cyl")
#'   
#'   na_zero_at( mtcars, "cyl" )
#'   na_zero_at( mtcars, c("mpg","cyl"))
#'   na_zero_at( mtcars, 2 )
#'   na_zero_at( mtcars, 1:3)
#'
#'   na_zero_all( mtcars )  
#'           
#'   na_zero_if( mtcars, mean(.) > 10 )   
#'            
#' @rdname na.replace  
#' @md  
#' @export

na.zero <- function(x) 
  na.replace(x,0)



## TABLE FUNCTIONS 



na_zero <- function(.data, ...) { 
  
 vars <- select_vars( names(.data), ... )
 for( v in vars )
   .data[[v]] <- na.zero( .data[[v]] )
 .data
 
}


na_zero_at <- function(.tbl, .vars ) { 

  for( i in .vars )
    .tbl[[i]] <- na.zero( .tbl[[i]] )
  .tbl
  
}  


na_zero_all <- function(.tbl) { 

  for( i in 1:length(.tbl) )
    .tbl[[i]] <- na.zero( .tbl[[i]] )
  .tbl
    
}


na_zero_if <- function( .tbl, .predicate ) { 

  for( i in 1:length(.tbl) ) 
    if( .predicate(.tbl[[i]] ) ) 
      .tbl[[i]] <- na.zero(.tbl[[i]])
    
  .tbl
}
  

# mtcars %>%  na_zero_if( true )
# true <- function(x) TRUE
