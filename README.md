OpenCalc
========

An Intuitive and Powerful Open Source Calculator for OS X

========

This is a free open source calculator app. As of March 22, 2014, this app is still in the early stages, but it supports the vast majority of algebra needed for precalculus including graphing. It also includes numeric integration, slope-calculating, intersect-finding, and root-finding capabilities. In the grapher tab, right-clicking is your friend.

For about a month now, progress has been very slow. The reason is that I am working on OpenEquations, which should vastly reduce glitches with the current equation editor and improve functionality. Progress on OpenCalc should resume in early March.

Here is a tenative schedule:
MARCH-APRIL
* implementing "save as PNG"
* saving the window and equations between sessions
* fixing a glitch that prevents saving variables and functions between sessions
* improved aesthetic for graphing evaluation windows
* allow user to determine a step-size for graphing
* allow user to determine the minimum and maximum values for "t" in parameteric graphing
* add polar graphing
* add ticks on the axis (with user-determined intervals)

MAY
* improving OpenEquations
* integration of OpenEquations with OpenCalc

SUMMER OF 205
* arbitrary digit precision
* 3d graphing
* statistical analysis capabilities (still trying to determine the best GUI for this, if you have any ideas I'd be happy to hear from you)

========

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
