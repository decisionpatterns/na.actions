library(testthat)
library(na.actions)
library(magrittr)

v <- c(1,NA,3)

v %>% na.replace %>% expect_equal( c(1,0,3) )
v %>% na.replace(2) %>% expect_equal( c(1,2,3) )  
