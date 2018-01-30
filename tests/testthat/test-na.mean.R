library(testthat)
library(na.actions)
library(magrittr)

context("na.mean")

context(".. continous-integer")
test_that("na.mean-continuous-integer", {

# REPLACE with scalar 

  v <- 1:4
  v[ c(2,4) ] <- NA_integer_
  
 # REPLACE with FUNCTION 
  ans <- c(1,2,3,2)
  v %>% na.mean %T>% 
    expect_is("integer") %>% 
    expect_equal(ans)    # 1 2 3 2    
   
# REPLACE by non-consistent class/type
  expect_error( v %>% na.mean("a") )
  
# REPLACE by inconsistent length
  expect_error( v %>% na.mean(1:2) )
  
})


context(".. continous-numeric")
test_that("na.mean-continuous-integer", {

  v <- 1:4
  v[ c(2,4) ] <- NA_real_
  
# REPLACE with FUNCTION
  ans <- c(1,2,3,2)
  v %>% na.mean %T>%
    expect_is("numeric") %>%
    expect_equal(ans)    # 1 2 3 2

   
# REPLACE with non-consistent class/type
  expect_error( v %>% na.mean("a") )

# REPLACE by inconsistent length
  expect_error( v %>% na.mean(1:2) )
  
})

context(".. categorical-character")
test_that("na.mean-continuous-integer", {
  
  x <- letters[1:4]
  x[ c(2,4) ] <- NA
  
  expect_warning( ans <- x %>% na.mean() ) 
  
  ans %T>% 
    expect_is("character") %>%
    expect_equal(x)
  
})