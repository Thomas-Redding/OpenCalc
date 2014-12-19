//
//  Saver.h
//  Calculator
//
//  Created by Thomas Redding on 10/3/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathVariable.h"
#import "MathExpression.h"
#import "MathUserFunction.h"

@interface Saver : NSObject

@property NSMutableArray* publicVariable;
@property NSMutableArray* publicFunction;

/*
 character 0 = type
 'b' = MathBoolean
 character 1 = false (0) or true (1)
 'n' = MathNumber
 characters 1-8 = real
 characters 9-15 = imaginary
 */


- (Saver*)initWithMemory: (NSMutableArray*) publicVariables publicFunctions: (NSMutableArray*) publicFunctions;
- (void)loadVariablesAndFunctions;
- (void)saveVariablesAndFunctions;
- (NSString*) variableToString: (MathVariable*) var;
- (bool) addVariable: (MathVariable*) var;
- (MathVariable*) stringToVariable: (NSString*) str;

@end
