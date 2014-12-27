//
//  Brain.m
//  Calculator
//
//  Created by Thomas Redding on 9/28/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "Brain.h"

@implementation Brain

- (Brain*) init {
    self.publicVariable = [[NSMutableArray alloc] init];
    
    MathVariable *newVar = [[MathVariable alloc] init];
    newVar.name = @"e";
    MathObject *newValue = [[MathNumber alloc] init];
    [newValue setDouble:2.71828182845904523536];
    newVar.isEditable = false;
    newVar.variableValue = newValue;
    [self.publicVariable addObject:newVar];
    
    newVar = [[MathVariable alloc] init];
    newVar.name = @"pi";
    newValue = [[MathNumber alloc] init];
    [newValue setDouble:3.14159265358979323846];
    newVar.isEditable = false;
    newVar.variableValue = newValue;
    [self.publicVariable addObject:newVar];
    
    newVar = [[MathVariable alloc] init];
    newVar.name = @"π";
    newValue = [[MathNumber alloc] init];
    [newValue setDouble:3.14159265358979323846];
    newVar.isEditable = false;
    newVar.variableValue = newValue;
    [self.publicVariable addObject:newVar];
    
    newVar = [[MathVariable alloc] init];
    newVar.name = @"phi";
    newValue = [[MathNumber alloc] init];
    [newValue setDouble:1.6180339887498948482];
    newVar.isEditable = false;
    newVar.variableValue = newValue;
    [self.publicVariable addObject:newVar];
    
    newVar = [[MathVariable alloc] init];
    newVar.name = @"i";
    newValue = [[MathNumber alloc] init];
    [newValue setDouble: 1 newValue: 1];
    newVar.isEditable = false;
    newVar.variableValue = newValue;
    [self.publicVariable addObject:newVar];
    
    newVar = [[MathVariable alloc] init];
    newVar.name = @"true";
    newValue = [[MathBoolean alloc] init];
    [newValue setDouble: 1];
    newVar.isEditable = false;
    newVar.variableValue = newValue;
    [self.publicVariable addObject:newVar];
    
    newVar = [[MathVariable alloc] init];
    newVar.name = @"false";
    newValue = [[MathBoolean alloc] init];
    newVar.isEditable = false;
    newVar.variableValue = newValue;
    [self.publicVariable addObject:newVar];
    
    newVar = [[MathVariable alloc] init];
    newVar.name = @"TRUE";
    newValue = [[MathBoolean alloc] init];
    [newValue setDouble: 1];
    newVar.isEditable = false;
    newVar.variableValue = newValue;
    [self.publicVariable addObject:newVar];
    
    newVar = [[MathVariable alloc] init];
    newVar.name = @"FALSE";
    newValue = [[MathBoolean alloc] init];
    [newValue setDouble: 1];
    newVar.isEditable = false;
    newVar.variableValue = newValue;
    [self.publicVariable addObject:newVar];
    
    /*
     last is a reserved variable
     the program edits last to be the last valid line's value
     the user cannot write to last
     last defaults to the number 0
    */
    newVar = [[MathVariable alloc] init];
    newVar.name = @"last";
    newValue = [[MathNumber alloc] init];
    newVar.isEditable = false;
    newVar.variableValue = newValue;
    [self.publicVariable addObject:newVar];
    
    self.publicFunction = [[NSMutableArray alloc] init];
    
    [self.publicFunction addObject: [[MathConstructVector alloc] init]];
    [self.publicFunction addObject: [[MathElement alloc] init]];
    [self.publicFunction addObject: [[MathConstructMatrix alloc] init]];
    [self.publicFunction addObject: [[MathDeterminant alloc] init]];
    [self.publicFunction addObject: [[MathMatrixInverse alloc] init]];
    
    [self.publicFunction addObject: [[MathSine alloc] init]];
    [self.publicFunction addObject: [[MathCosine alloc] init]];
    [self.publicFunction addObject: [[MathTangent alloc] init]];
    [self.publicFunction addObject: [[MathCotangent alloc] init]];
    [self.publicFunction addObject: [[MathCotangentB alloc] init]];
    [self.publicFunction addObject: [[MathSecant alloc] init]];
    [self.publicFunction addObject: [[MathCosecant alloc] init]];
    [self.publicFunction addObject: [[MathNaturalLogarithm alloc] init]];
    [self.publicFunction addObject: [[MathLogBaseTen alloc] init]];
    [self.publicFunction addObject: [[MathExponent alloc] init]];
    [self.publicFunction addObject: [[MathFloor alloc] init]];
    [self.publicFunction addObject: [[MathSquareRoot alloc] init]];
    [self.publicFunction addObject: [[MathAbsoluteValue alloc] init]];
    [self.publicFunction addObject: [[MathCombination alloc] init]];
    [self.publicFunction addObject: [[MathRandom alloc] init]];
    [self.publicFunction addObject: [[MathErrorFunction alloc] init]];
    [self.publicFunction addObject: [[MathLogBaseTwo alloc] init]];
    
    [self.publicFunction addObject: [[MathPoissonDensity alloc] init]];
    [self.publicFunction addObject: [[MathPoissonDistribution alloc] init]];
    [self.publicFunction addObject: [[MathPoissonQuantile alloc] init]];
    [self.publicFunction addObject: [[MathPoissonRandom alloc] init]];
    
    [self.publicFunction addObject: [[MathExponentialDistribution alloc] init]];
    [self.publicFunction addObject: [[MathExponentialDensity alloc] init]];
    [self.publicFunction addObject: [[MathExponentialQuantile alloc] init]];
    [self.publicFunction addObject: [[MathExponentialRandom alloc] init]];
    
    [self.publicFunction addObject: [[MathNormalDensity alloc] init]];
    [self.publicFunction addObject: [[MathNormalDistribution alloc] init]];
    [self.publicFunction addObject: [[MathNormalQuantile alloc] init]];
    [self.publicFunction addObject: [[MathNormalRandom alloc] init]];
    
    [self.publicFunction addObject: [[MathBinomialRandom alloc] init]];
    [self.publicFunction addObject: [[MathBinomialDensity alloc] init]];
    [self.publicFunction addObject: [[MathBinomialDistribution alloc] init]];
    [self.publicFunction addObject: [[MathBinomialQuantile alloc] init]];
    
    self.errors = [[NSMutableArray alloc] init];
    self.saver = [[Saver alloc] initWithMemory:self.publicVariable publicFunctions:self.publicVariable];
    [self.saver loadVariablesAndFunctions];
    return self;
}

- (bool) legalVariableName: (NSString*) input {
    if([self characterType:[input characterAtIndex: 0]] == 1) {
        int charType;
        bool hitFirstDigit = false;
        for(int i=1; i<[input length]; i++) {
            charType = [self characterType:[input characterAtIndex: i]];
            if(charType == 0) {
                if(isdigit([input characterAtIndex: i])) {
                    // digit
                    hitFirstDigit = true;
                }
                else {
                    // .
                }
            }
            else if(charType == 1) {
                // letter
                if(hitFirstDigit) {
                    return false;
                }
            }
            else {
                // not alphanumeric
                return false;
            }
        }return true;
    }
    else {
        return false;
    }
}

- (NSArray*) legalFunctionDefinition: (NSString*) input {
    if([input characterAtIndex:[input length]-1] != ')') {
        // input doesn't end with ')'
        return NULL;
    }
    
    input = [input substringToIndex:[input length]-1];
    
    NSArray *splitInput = [input componentsSeparatedByString:@"("];
    if([splitInput count] != 2) {
        // input either has no '(' or more than one ')'
        return  NULL;
    }
    
    if(![self legalVariableName:splitInput[0]]) {
        // function name is not legal
        return NULL;
    }
    
    NSArray *parameters = [[NSArray alloc] initWithObjects:splitInput[0], [splitInput[1] componentsSeparatedByString:@","], nil];
    for(int i=0; i<[parameters[1] count]; i++) {
        if(![self legalVariableName:parameters[1][i]]) {
            // this parameter is not a legal variable name
            return NULL;
        }
    }
    
    return parameters;
}

- (bool) isDefinition: (NSString*) input {
    for(int i=1; i<[input length]; i++) {
        if([input characterAtIndex:i] == '=') {
            // first equal sign
            if(i == [input length]-1) {
                // delete current definition
                return true;
            }
            else if([input characterAtIndex:i+1] == '=') {
                // check equality
                return false;
            }
            else {
                // definition
                return true;
            }
        }
    }
    // no equal signs
    return false;
}

- (NSString*) runAlgebra: (NSString*) input {
    // clear whitespace, tabs, etc.
    [self.errors removeAllObjects];
    NSArray* words = [input componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
    input = [words componentsJoinedByString:@""];
    
    if([input length] == 0) {
        [self.errors addObject:@"ERROR (Nothing Entered)"];
        return NULL;
    }
    
    if([input length] >= 2) {
        if([[input substringToIndex:2] isEqual: @">="]) {
            return NULL;
        }
        else if([[input substringToIndex:2] isEqual: @"<="]) {
            return NULL;
        }
    }
    
    // determine whether the input is a (attempted) definition or an evaluation
    bool definition = [self isDefinition: input];
    if(definition) {
        // define
        bool answer = [self define: input];
        if(answer) {
            return @"";
        }
        else {
            return NULL;
        }
    }
    else {
        // evaluate
        MathObject *answer = [self evaluate: input];
        if(answer == NULL) {
            return NULL;
        }
        else {
            [self updateLast:answer];
            return [answer toString];
        }
    }
}

- (bool) define: (NSString*) badInput {
    NSString* input = [self sanitize: badInput];
    if(input == NULL) {
        return NULL;
    }
    
    // 0 = error, 1 = successful
    int i;
    bool shouldSaveVariableToHardDrive = false;
    for(i=0; i<[input length]-1; i++) {
        if([input characterAtIndex:i] == '=') {
            break;
        }
        if([input characterAtIndex:i] == ':' && [input characterAtIndex:i+1] == '=') {
            shouldSaveVariableToHardDrive = true;
            break;
        }
    }
    
    if(shouldSaveVariableToHardDrive) {
        if([[input substringFromIndex:i+2] length] == 0) {
            bool rtn = [self addVariable:[input substringToIndex:i] value:NULL];
            if(rtn) {
                [self setVariablesSaveValue:[input substringToIndex:i] newValue:true];
                [self saveVariablesAndFunctions];
            }
            return rtn;
        }
        
        if([self legalVariableName:[input substringToIndex:i]]) {
            // attempted variable definition
            if([self isSafeVariable:[input substringToIndex:i]]) {
                MathObject* newValue = [self evaluate:[input substringFromIndex:i+2]];
                if(newValue == NULL) {
                    return false;
                }
                else {
                    bool rtn = [self addVariable:[input substringToIndex:i] value:newValue];
                    if(rtn) {
                        [self setVariablesSaveValue:[input substringToIndex:i] newValue:true];
                        [self saveVariablesAndFunctions];
                    }
                    return rtn;
                }
            }
            else {
                [self.errors addObject:@"ERROR(Illegal Variable Name)"];
                return false;
            }
        }
        
        // attempted function definition
        NSArray* arr = [self legalFunctionDefinition:[input substringToIndex:i]];
        if(arr != NULL) {
            if([[input substringFromIndex:i+2] length] == 0) {
                // remove function
                for (int j=0; [self.publicFunction count]; j++) {
                    if([self.publicFunction[j] name] == [input substringToIndex:i]) {
                        // found function; delete it now
                        self.publicFunction[j] = [[MathUserFunction alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariable publicFunctions:self.publicFunction errors:self.errors];
                        return true;
                    }
                }
                return false;
            }
            MathUserFunction *newFunction = [[MathUserFunction alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariable publicFunctions:self.publicFunction errors:self.errors];
            bool success = [newFunction define:arr input:[input substringFromIndex:i+2]];
            if(success) {
                [self addFunction:newFunction];
            }
            return success;
        }
        else {
            [self.errors addObject:@"ERROR(Illegal Function Name)"];
            return false;
        }
    }
    else {
        if([self legalVariableName:[input substringToIndex:i]]) {
            if([[input substringFromIndex:i+1] length] == 0) {
                // x=
                // delete variable
                return [self addVariable:[input substringToIndex:i] value:NULL];
            }
            // attempted variable definition
            if([self isSafeVariable:[input substringToIndex:i]]) {
                MathObject* newValue = [self evaluate:[input substringFromIndex:i+1]];
                if(newValue == NULL) {
                    return false;
                }
                else {
                    return [self addVariable:[input substringToIndex:i] value:newValue];
                }
            }
            else {
                [self.errors addObject:@"ERROR(Illegal Variable Name)"];
                return false;
            }
        }
        
        // attempted function definition
        NSArray* arr = [self legalFunctionDefinition:[input substringToIndex:i]];
        
        
        
        if(arr != NULL) {
            
            if([[input substringToIndex:i+1] length] == 0) {
                for (int j=0; j<[self.publicFunction count]; j++) {
                    if([self.publicFunction[j] name] == [input substringToIndex:i]) {
                        // found function; delete it now
                        self.publicFunction[j] = [[MathUserFunction alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariable publicFunctions:self.publicFunction errors:self.errors];
                        return true;
                    }
                }
                return false;
            }
            
            MathUserFunction *newFunction = [[MathUserFunction alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariable publicFunctions:self.publicFunction errors:self.errors];
            
            bool success = [newFunction define:arr input:[input substringFromIndex:i+1]];
            if(success) {
                [self addFunction:newFunction];
            }
            return success;
        }
        else {
            [self.errors addObject:@"ERROR(Illegal Function Name)"];
            return false;
        }
    }
}

- (void) addFunction: (MathFunction*) func {
    for(int i=0; i<[self.publicFunction count]; i++) {
        if([func.name isEqual:[self.publicFunction[i] name]]) {
            self.publicFunction[i] = func;
            return;
        }
    }
    [self.publicFunction addObject:func];
}

- (bool) isSafeVariable: (NSString*) name {
    if([name isEqual: @"last"]) {
        return false;
    }
    if([name length] == 0) {
        return false;
    }
    if([self characterType:[name characterAtIndex:0]] != 1) {
        return false;
    }
    if([name characterAtIndex:0] == 'E') {
        // reserved for scientific notation
        if([name length] == 1) {
            return false;
        }
        else if([self characterType:[name characterAtIndex:1]] == 0) {
            return false;
        }
    }
    
    for(int i=0; i<[name length]; i++) {
        if([self characterType:[name characterAtIndex:i]] != 1) {
            if(isdigit([name characterAtIndex:i])) {
                // this is legal iff all characters after this point are also digits
                for(i=i; i<[name length]; i++) {
                    if(!isdigit([name characterAtIndex:i])) {
                        return false;
                    }
                }
                return true;
            }
            else {
                return false;
            }
            
        }
    }
    return true;
}

- (MathObject*) evaluate: (NSString*) input {
    MathExpression *myExpression = [MathExpression alloc];
    NSString* sanitizedInput = [self sanitize: input];
    
    if(sanitizedInput == NULL) {
        return NULL;
    }
    MathObject *answer = [myExpression evaluate: sanitizedInput publicVariable: self.publicVariable publicFunction:self.publicFunction errors:self.errors];
    return answer;
}

- (NSString*) sanitize: (NSString*) input {
    NSMutableString* rtn = [[NSMutableString alloc] initWithString: input];
    if([rtn characterAtIndex:0] == '-') {
        // negative marker
        if([rtn length] < 2) {
            return NULL;
        }
        if([self characterType:[rtn characterAtIndex:1]] != 0) {
            [rtn insertString:@"*" atIndex:1];
        }
    }
    
    for(int i=0; i<[rtn length]; i++) {
        if([self characterType:[rtn characterAtIndex:i]] < 0) {
            return NULL;
        }
    }
    
    int charType;
    for(int i=0; i<[rtn length]; i++)
    {
        charType = [self characterType:[rtn characterAtIndex:i]];
        if(charType < 0) {
            return NULL;
        }
        else if(charType == 0) {
            if(i < [rtn length]-1) {
                charType = [self characterType:[rtn characterAtIndex:i+1]];
                if([rtn characterAtIndex:i+1] == '(' || [rtn characterAtIndex:i+1] == '[' || charType == 1) {
                    // implicit multiplication
                    /*
                     ...5(... -> ...5*(...
                     ...7x... -> ...7*x...
                    */
                    
                    if(i < [rtn length]-2) {
                        if([rtn characterAtIndex:i+1] == 'E' && ([self characterType:[rtn characterAtIndex:i+2]] == 0 || [rtn characterAtIndex:i+2] == '-')) {
                            // scientific notation: #E#
                        }
                        else {
                            [rtn insertString:@"*" atIndex:i+1];
                        }
                    }
                    else {
                        [rtn insertString:@"*" atIndex:i+1];
                    }
                }
            }
        }
        // we do not treat  x( as x*(
        // if we see x(, we assume its a function
    }
    
    for(int i=0; i<[rtn length]-1; i++) {
        if([rtn characterAtIndex:i] == '-' && [self characterType:[rtn characterAtIndex:i+1]] == 1) {
            // -x --> -1*x
            [rtn insertString:@"1*" atIndex:i+1];
        }
    }
    
    return rtn;
}

- (int) characterType: (unichar) x {
    if(x == ' ' || x == '\n' || x == '\r') {
        return -1;
    }
    if(isdigit(x) || x=='.') {
        return 0;
    }
    NSCharacterSet *letters = [NSCharacterSet letterCharacterSet];
    if ([letters characterIsMember : x]) {
        return 1;
    }
    if(x == '(' || x == ')' || x == ']' || x == '[') {
        return 2;
    }
    if(x == '+' || x == '-' || x == '^' || x == '*' || x == '/' || x == '%' || x == '<' || x == '>' || x == 8804 || x == 8805 || x == 8800) {
        return 3;
    }
    if(x == '!') {
        return 4;
    }
    if(x == '=') {
        return 5;
    }
    if(x == ',') {
        return 6;
    }
    if(x == ':') {
        return 7;
    }
    
    return -2;
}

- (bool) addVariable: (NSString*) name value: (MathObject*) value {
    int i;
    for(i=0; i<[self.publicVariable count]; i++) {
        if([[self.publicVariable[i] name] isEqual:name]) {
            if([self.publicVariable[i] isEditable]) {
                MathVariable *newVar = [[MathVariable alloc] init];
                newVar.variableValue = value;
                newVar.name = name;
                newVar.isEditable = true;
                newVar.shouldSaveToHarddrive = false;
                self.publicVariable[i] = newVar;
                return true;
            }
            else {
                return false;
            }
        }
    }
    MathVariable *newVar = [[MathVariable alloc] init];
    newVar.name = name;
    newVar.variableValue = value;
    newVar.isEditable = true;
    newVar.shouldSaveToHarddrive = false;
    [self.publicVariable addObject:newVar];
    return true;
}

- (void) updateLast: (MathObject*) newValue {
    if(newValue != NULL) {
        int i;
        for(i=0; i<[self.publicVariable count]; i++) {
            if([[self.publicVariable[i] name] isEqual:@"last"]) {
                MathVariable *newVar = [[MathVariable alloc] init];
                newVar.variableValue = newValue;
                newVar.name = @"last";
                newVar.shouldSaveToHarddrive = true;
                newVar.isEditable = true;
                self.publicVariable[i] = newVar;
                return;
            }
        }
        // in case "last" is ever deleted
        MathVariable *newVar = [[MathVariable alloc] init];
        newVar.name = @"last";
        newVar.isEditable = false;
        newVar.shouldSaveToHarddrive = true;
        newVar.variableValue = newValue;
        [self.publicVariable addObject:newVar];
    }
}

- (double) graphRun: (NSString*) funcName x: (double) x {
    MathObject *inputObject = [[MathNumber alloc] init];
    NSArray *inputArr = [[NSArray alloc] initWithObjects:inputObject, nil];
    for(int i=0; i<[self.publicFunction count]; i++) {
        if([funcName isEqual: [self.publicFunction[i] name]]) {
            [inputArr[0] setDouble:x];
            MathObject *answer = [self.publicFunction[i] func:inputArr];
            if(answer == NULL) {
                return INFINITY;
            }
            else {
                if([answer getDouble:1] == 0) {
                    return [answer getDouble];
                }
                else {
                    return INFINITY;
                }
            }
        }
    }
    return INFINITY;
}

- (void) loadVariablesAndFunctions {
    [self.saver loadVariablesAndFunctions];
    
}

- (void) saveVariablesAndFunctions {
    [self.saver saveVariablesAndFunctions];
}

- (bool) setVariablesSaveValue: (NSString*) name newValue: (bool) newValue {
    int i;
    for(i=0; i<[self.publicVariable count]; i++) {
        if([[self.publicVariable[i] name] isEqual:name]) {
            if([self.publicVariable[i] isEditable]) {
                [self.publicVariable[i] setShouldSaveToHarddrive:newValue];
                return true;
            }
            else {
                return false;
            }
        }
    }
    // variable not found
    return false;
}

- (void) clearHardDriveVariables {
    for(int i=0; i<[self.publicVariable count]; i++) {
        if([self.publicVariable[i] shouldSaveToHarddrive]) {
            [self.publicVariable[i] setShouldSaveToHarddrive:false];
        }
    }
    [self saveVariablesAndFunctions];
}

- (double) findRoot: (NSString*) func x: (double) x {
    double y = 0.0, h = 0.0, slope = 0.0;
    double startY = [self graphRun:func x:x];
    if(startY == 0) {
        return x;
    }
    for(int i=0; i<100; i++) {
        y = [self graphRun:func x:x];
        h = 0.001;
        slope = [self findSlope:func x:x]; // ([self graphRun:func x:x+h]-y)/h;
        if(slope == 0 || y == 0) {
            break;
        }
        x -= y/slope;
    }
    
    if(y/startY < 0.001) {
        return x;
    }
    else {
        return INFINITY;
    }
}

- (double) findSlope: (NSString*) func x: (double) x {
    double h = 0.0001;
    double y1 = [self graphRun:func x:x-h];
    double y2 = [self graphRun:func x:x+h];
    return (y2-y1)/2/h;
}

- (MathObject*) getVariableValue: (NSString*) variableName {
    for(int i=0; i<self.publicVariable.count; i++) {
        if([[self.publicVariable[i] name] isEqual: variableName]) {
            MathObject *answer = [[self.publicVariable[i] variableValue] copy];
            return answer;
        }
    }
    return NULL;
}

@end
