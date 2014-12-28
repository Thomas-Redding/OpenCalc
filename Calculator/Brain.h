//
//  Brain.h
//  Calculator
//
//  Created by Thomas Redding on 9/28/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Saver.h"

@interface Brain : NSObject

@property NSMutableArray* publicVariable;
@property NSMutableArray* publicFunction;
@property NSMutableArray* errors;
@property Saver *saver;
// adds predefined (non-editable) variables and atomic math functions (btw - atomic is a huge misnomer)
- (Brain*) init;

// this runs every time AppDelegate wants us to evaluate (or define) some expression
- (NSString*) runAlgebra: (NSString*) input;

// this allows us to define functions and variables
// if it returns false, it failed, and if the variable had an alternative value, it retains this
- (bool) define: (NSString*) badInput;

// this evaluates an expression (as opposed to defining a variable or function)
- (MathObject*) evaluate: (NSString*) input;

// this returns an int corresponding to what group the given character belongs to
- (int) characterType: (unichar) x;

// this adds or updates a user-defined variable
- (bool) addVariable: (NSString*) name value: (MathObject*) value;

// this determines whether the name given for a new variable fits the standard used by this calculate
/*
 to be a legal variable, a string must satisfy the following conditions
    - every character must be a letter or a numeral
    - the first character must be a letter
    - if a character is a numeral, then every following character must be a numeral
 examples
    LEGAL   x5  george9124
    ILLEGAL 5x  9124george  9george124  georg9e george_bob
*/
- (bool) isSafeVariable: (NSString*) name;

// this updates the special variable "last", which stores the value of the last evaluated expression
- (void) updateLast: (MathObject*) newValue;

- (bool) legalVariableName: (NSString*) input;

// takes the right-hand side of a function-defining statement and returns [functionName, [parameterName1, parameterName2, parameterName3]]
// if the right-hand side is illegal, then it return NULL
- (NSArray*) legalFunctionDefinition: (NSString*) input;

// clears all variables from harddrive
- (void) clearHardDriveVariables;

- (void) addFunction: (MathFunction*) func;

- (double) graphRun: (NSString*) funcName x: (double) x;

- (void) loadVariablesAndFunctions;
- (void) saveVariablesAndFunctions;
- (bool) setVariablesSaveValue: (NSString*) name newValue: (bool) newValue;
- (NSString*) sanitize: (NSString*) input;
- (double) findRoot: (NSString*) func x: (double) x;
- (MathObject*) getVariableValue: (NSString*) variableName;
- (double) findSlope: (NSString*) func x: (double) x;
- (double) integrate: (NSString*) func x1: (double) x1 x2: (double) x2;

@end
