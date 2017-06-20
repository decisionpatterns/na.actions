library(testthat)
library(na.actions)
library(magrittr)

context("na_replace")

test_that("na_replace", {


v <- c(1,NA,3)

v %>% na_replace(0) %>% expect_equal( c(1,0,3) )
v %>% na_replace(2) %>% expect_equal( c(1,2,3) )  

v <-c(1,NA,3,NA) 

v %>% na_replace(2) %>% expect_equal( c(1,2,3,2) )    # 1 2 3 2
v %>% na_replace(1:4) %>% expect_equal(1:4)

v %>% na_replace(letters[1:4]) %>% expect_equal( c("1","b","3","d") ) 

})
