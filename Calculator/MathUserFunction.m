//
//  MathUserFunction.m
//  Calculator
//
//  Created by Thomas Redding on 9/30/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathUserFunction.h"

@implementation MathUserFunction

- (MathFunction*) initWithPointerToPublicVariablesAndFunctions: (NSMutableArray*) publicVariables publicFunctions: (NSMutableArray*) publicFunctions errors: (NSMutableArray*) errors {
    self.publicVariables = publicVariables;
    self.publicFunctions = publicFunctions;
    self.errors = errors;
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] != [self.privateVariables count]) {
        // different number of parameters
        return NULL;
    }
    for(int i=0; i<[input count]; i++) {
        [self.privateVariables[i] setVariableValue:input[i]];
    }
    
    
    
    return [self.topOfExpressionTree func:self.privateVariables];
}

- (bool) define: (NSArray*) interface input: (NSString*) str {
    // interface takes the form [functionName, [parameterName1, parameterName2, parameterName3, ...]]
    self.privateVariables = [[NSMutableArray alloc] init];
    self.name = interface[0];
    for(int i=0; i<[interface[1] count]; i++) {
        MathVariable *newVariable = [[MathVariable alloc] init];
        newVariable.name = interface[1][i];
        newVariable.variableValue = NULL;
        [self.privateVariables addObject:newVariable];
    }
    self.topOfExpressionTree = [[MathPersistentExpression alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariables publicFunctions:self.publicFunctions errors:self.errors];
    return [self.topOfExpressionTree define:str];
}

- (bool) stringToTree: (NSString*) input {
    return false;
}

@end
