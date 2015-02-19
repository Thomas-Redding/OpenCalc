OpenCalc
========

An Intuitive and Powerful Open Source Calculator for OS X

========

This is a free open source calculator app. As of December 23, 2014, this app is still in the early stages, but it supports the vast majority of algebra needed for precalculus including graphing. Below is a tenative schedule:

* Jan 3 - Jan 4 - add seq(x^2, x, 1, 7); add sum(vector or matrix), add ser(x^2, x, 1, 7)
* Jan 5 - Jan 11 - add equation editor
* Jan 12 - Jan 18 - add help-book

OPERATORS
* =   is defined as (does not store to hard drive)
* :=  is defined as (stores to hard drive)
* ==  is equal to (returns a boolean)
* ≤   less than or equal to (alt/option <)
* ≥   greater than or equal to (alt/option >)
* <   less than
* >   greater than
* ≠   not equal to (alt/option =)
* *   multiplication
* -   subtraction
* +   addition
* /   division
* !   factorial
* ()  parantheses

HARD-CODED FUNCTIONS
* Vect(x1,x2,x3,...) - constructs a vector
* element(vect, i) - returns element #i from vect (which can be a vector or a matrix)
* element(vect, i, j, ...) - returns a vector of the ith, jth, etc. elements in vect (which can be a vector or a matrix)
* Mat(width, height, x1, x2, ...) - constructs a matrix
* det(mat)    determinant (of a matrix)
* inv(mat)    inverse (of a matrix)
* sin(x)      sine
* cos(x)      cosine
* tan(x)      tangent
* ctn(x)      cotangent
* cot(x)      cotangent
* sec(x)      secant
* csc(x)      cosecant
* ln(x)       natural log
* log(x)      log base 10
* exp(x)      exponentiation
* floor(x)    round down
* sqrt(x)     square root
* abs(x)      absolute value
* C(x,y)      choose
* rand()      generates a random number between 0 and 1
* err(x)      error function
* lg(x)       log base two
* ppois()     poisson density function
* dpois()     poisson cumulative function
* qpois()     poisson quantile function
* rpois()     poisson random number generator
* pexp()      exponential density function
* dexp()      exponential cumulative function
* qexp()      exponential quantile function
* rexp()      exponential random number generator
* pnorm()     normal density function
* dnorm()     normal cumulative function
* qnorm()     normal quantile function
* rnorm()     normal random number generator
* pbinom()    binomial density function
* dbinom()    binomial cumulative function
* qbinom()    binomial quantile function
* rbinom()    binomial random number generator

HARD-CODED VARIABLES
* pi          3.141...
* e           2.718...
* phi         1.618...
* true        true
* false       false
* TRUE        true
* FALSE       false
* i           √-1

OTHER
* scientific notation: 6.23E3 == 6230
* declaring a vector: [5,11,7] == Vect(5,11,7)

GRAPHING
* f(x)            graphs function
* >f(x)           graphs inequality
* ≥f(x)           graphs inequality
* ≤f(x)           graphs inequality
* <f(x)           graphs inequality
* [f(x), g(x)]    graphs parametric function