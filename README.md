[![Build Status](https://travis-ci.org/decisionpatterns/na.actions.png?branch=master)](decisionpatterns/na.actions)

na.actions
==========

Functions for handling NA values.

na.actions is a packages for dealing with NA values. The goal is to create a collection for the na.* family of functions that extends the native functions from the stats package. The curent list of functions is:

 * na.inf / na.neginf - replance na with Inf/-Inf
 * na.loess - use loess smoother for replacement
 * na.max 
 * na.min 
 * na.mean
 * na.median
 * na.nocb - next observation carried backwards
 * na.predict - use a model 
 * na.replace - replace with a constant \code{value}
 * na.roughfix.POSIXct - use with datetime values
 * na.zero - replace with 0 


examples
----------
    na.replace( c(1,NA,3), 2)
  
