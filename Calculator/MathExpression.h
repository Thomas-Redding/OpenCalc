//
//  MathExpression.h
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathFunction.h"
#import "MathVariable.h"
#import "MathConstructVector.h"
#import "MathElement.h"
#import "MathConstructMatrix.h"
#import "MathDeterminant.h"

#import "MathMultiplication.h"
#import "MathAddition.h"
#import "MathSubtraction.h"
#import "MathDivision.h"
#import "MathPower.h"
#import "MathInverse.h"
#import "MathFactorial.h"
#import "MathEquality.h"
#import "MathModulo.h"
#import "MathLessThan.h"
#import "MathGreaterThan.h"
#import "MathLessThanOrEqualTo.h"
#import "MathGreaterThanOrEqualTo.h"
#import "MathNotEqualTo.h"

#import "MathSine.h"
#import "MathCosine.h"
#import "MathTangent.h"
#import "MathCotangent.h"
#import "MathCotangentB.h"
#import "MathSecant.h"
#import "MathCosecant.h"
#import "MathNaturalLogarithm.h"
#import "MathLogBaseTen.h"
#import "MathExponent.h"
#import "MathFloor.h"
#import "MathSquareRoot.h"
#import "MathAbsoluteValue.h"
#import "MathCombination.h"
#import "MathRandom.h"
#import "MathNull.h"
#import "MathErrorFunction.h"
#import "MathLogBaseTwo.h"

#import "MathBinomialDensity.h"
#import "MathBinomialDistribution.h"
#import "MathBinomialRandom.h"
#import "MathBinomialQuantile.h"

#import "MathExponentialDensity.h"
#import "MathExponentialDistribution.h"
#import "MathExponentialQuantile.h"
#import "MathExponentialRandom.h"

#import "MathNormalDensity.h"
#import "MathNormalDistribution.h"
#import "MathNormalQuantile.h"
#import "MathNormalRandom.h"

#import "MathPoissonDensity.h"
#import "MathPoissonDistribution.h"
#import "MathPoissonQuantile.h"
#import "MathPoissonRandom.h"

@interface MathExpression : NSObject

- (MathObject*) evaluate: (NSString*) input publicVariable: (NSMutableArray*) publicVariable publicFunction: (NSMutableArray*) publicFunction errors: (NSMutableArray*) errors;

/*
 -2 other
 -1 whitespace
 0  digit or .
 1  letter
 2  parantheses
 3  binary operator
 4  !
 5  =
*/
- (int) characterType: (unichar) x;
- (int) orderOfOperationsValue: (unichar) x;
- (NSMutableArray*) splitParameters: (NSString*) input;

@end
