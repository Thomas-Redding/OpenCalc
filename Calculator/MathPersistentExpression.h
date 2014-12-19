//
//  MathPersistentExpression.h
//  Calculator
//
//  Created by Thomas Redding on 9/30/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathExpression.h"

@interface MathPersistentExpression : NSObject

@property MathFunction* op;
@property NSMutableArray *parameters;
@property bool isConstantValue;
@property MathObject *constantValue;
@property bool isVariable;
@property NSString* variableName;


// these point to Brain's corrresponding variables
@property NSMutableArray *publicVariables;
@property NSMutableArray *publicFunctions;
@property NSMutableArray *privateVariables;
@property NSMutableArray *errors;

// gives instance pointers to Brain's array of public variables and functions
- (MathPersistentExpression*) initWithPointerToPublicVariablesAndFunctions: (NSMutableArray*) publicVariables publicFunctions: (NSMutableArray*) publicFunctions errors: (NSMutableArray*) errors;
- (bool) define: (NSString*) str;
- (int) orderOfOperationsValue: (unichar) x;
- (int) characterType: (unichar) x;
- (NSMutableArray*) splitParameters: (NSString*) input;
- (MathObject*)func: (NSArray*) input;

@end
