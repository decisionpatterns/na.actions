library(testthat)
library(na.actions)
library(magrittr)

context("na.replace")

context(".. continous-integer")
test_that("na.replace-continuous-integer", {

# REPLACE with scalar 
  v <- 1:3
  v[2] <- NA_integer_
  
  ans <- c(1,0,3)
  v %>% na.replace(0) %T>% 
    expect_is("integer") %>%
    expect_equal(ans)
  
  ans <- 1:3
  v %>% na.replace(2) %T>% 
    expect_is("integer") %>%
    expect_equal(ans)  
  
  v <- 1:4
  v[ c(2,4) ] <- NA_integer_
  ans <-  c(1,2,3,2)
  v %>% na.replace(2) %T>% 
    expect_is("integer") %>% 
    expect_equal(ans)    # 1 2 3 2

# REPLACE with VECTOR
  ans <- 1:4
  v %>% na.replace(1:4) %T>% 
    expect_is("integer") %>% 
    expect_equal(ans)             # 1 2 3 4

 # REPLACE with FUNCTION 
  ans <- c(1,2,3,2)
   v %>% na.replace(mean) %T>% 
    expect_is("integer") %>% 
    expect_equal(ans)    # 1 2 3 2

   
# REPLACE by non-consistent class/type
  expect_error( v %>% na.replace("a") )
  
# REPLACE by inconsistent length
  expect_error( v %>% na.replace(1:2) )
  
})


context(".. continous-numeric")
test_that("na.replace-continuous-integer", {

# REPLACE with scalar 
  v <- 1:3 %>% as.numeric()
  v[2] <- NA_real_
  
  ans <- c(1,0,3)
  v %>% na.replace(0) %T>% 
    expect_is("numeric") %>%
    expect_equal(ans)
  
  ans <- 1:3
  v %>% na.replace(2) %T>% 
    expect_is("numeric") %>%
    expect_equal(ans)  
  
  v <- 1:4
  v[ c(2,4) ] <- NA_real_
  ans <- c(1,2,3,2)
  v %>% na.replace(2) %T>% 
    expect_is("numeric") %>% 
    expect_equal(ans)    # 1 2 3 2

# REPLACE with VECTOR
  ans <- 1:4
  v %>% na.replace(1:4) %T>% 
    expect_is("numeric") %>% 
    expect_equal(ans)             # 1 2 3 4

# REPLACE with FUNCTION
   ans <- c(1,2,3,2)
   v %>% na.replace(mean) %T>% 
    expect_is("numeric") %>% 
    expect_equal(ans)    # 1 2 3 2

   
# REPLACE with non-consistent class/type
  expect_error( v %>% na.replace("a") )

# REPLACE by inconsistent length
  expect_error( v %>% na.replace(1:2) )
  
})



context(".. character")
test_that("na.replace-character", {

# REPLACE with SCALAR
  v <- letters[1:4]
  v[c(2,4)] <- NA_character_
  
  ans <- qw(a,x,c,x)
  v %>% na.replace("x") %T>%
    expect_is("character") %>% 
    expect_equivalent(ans)
  
# REPLACE with VECTOR
  ans <- letters[1:4]
  v %>% na.replace(letters[1:4]) %T>%
    expect_is("character") %>% 
    expect_equivalent(ans) 

 # REPLACE with FUNCTION 
   ans <- qw(a,x,c,x)
   v %>% na.replace( function(x) "x" ) %T>% 
    expect_is("character") %>% 
    expect_equal(ans)    # 1 2 3 2
  
  
  
# REPLACE by DEFAULT
  ans <- qw(a,(NA),c,(NA))  
  v %>% na.replace() %T>%
    expect_is("character") %>% 
    expect_equivalent(ans) 


# REPLACE with non-consistent class
  ans <- c("a","1","c","1")
  v %>% na.replace(1L) %T>%
    expect_is("character") %>% 
    expect_equivalent(ans)

# REPLACE by inconsistent length
  expect_error( v %>% na.replace( qw(X,Y) ) )
      
})  
  

context( ".. factor")
test_that( "na.replace factor", { 
  
  fct <- letters[1:5] 
  fct[c(2,5)] <- NA 
  fct <- as.factor(fct)

# REPLACE with scalar
  ans <- factor( qw(a, z, c, d, z) )
  fct %>% na.replace("z")  %T>%
    expect_is("factor") %T>% 
    { . %>% levels %>% expect_equal(levels(ans)) } %>%
    expect_equivalent( as.factor(ans) )

# REPLACE with vector 
  ans <- factor( letters[1:5], levels=qw(a,c,d,b,e) ) 
  fct %>% na.replace(letters[1:5]) %T>% 
    expect_is("factor") %T>% 
    { . %>% levels %>% expect_equal(levels(ans)) } %T>%
    expect_equivalent(ans)
  
# REPLACE with FUNCTION 
  ans <- factor( qw(a, z, c, d, z) )
  fct %>% na.replace( function(x) "z" ) %T>% 
    expect_is("factor") %>% 
    expect_equal(ans)    # 1 2 3 2
    
  
# REPALCE with  default
  ans <- factor( qw(a,(NA),c,d,(NA)), levels=qw(a,c,d,(NA)) ) 
  fct %>% na.replace() %T>% 
    expect_is("factor") %T>%
    { . %>% levels %>% expect_equal( levels(ans) ) } %>% 
    expect_equivalent(ans)
  
# REPLACE by inconsistent length
  expect_error( fct %>% na.replace(1:2) )
  
})
