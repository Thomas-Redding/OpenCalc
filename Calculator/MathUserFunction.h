//
//  MathUserFunction.h
//  Calculator
//
//  Created by Thomas Redding on 9/30/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathFunction.h"
#import "MathPersistentExpression.h"

@interface MathUserFunction : MathFunction

@property NSMutableArray *publicVariables;
@property NSMutableArray *publicFunctions;
@property NSMutableArray *privateVariables;
@property NSMutableArray *errors;
@property MathPersistentExpression *topOfExpressionTree;

// gives instance pointers to Brain's array of public variables and functions
- (MathFunction*) initWithPointerToPublicVariablesAndFunctions: (NSMutableArray*) publicVariables publicFunctions: (NSMutableArray*) publicFunctions errors: (NSMutableArray*) errors;
- (bool) define: (NSArray*) interface input: (NSString*) str;
- (bool) stringToTree: (NSString*) input;

@end
