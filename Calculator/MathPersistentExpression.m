//
//  MathPersistentExpression.m
//  Calculator
//
//  Created by Thomas Redding on 9/30/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathPersistentExpression.h"

@implementation MathPersistentExpression

- (MathPersistentExpression*) initWithPointerToPublicVariablesAndFunctions: (NSMutableArray*) publicVariables publicFunctions: (NSMutableArray*) publicFunctions errors: (NSMutableArray*) errors {
    self.publicVariables = publicVariables;
    self.publicFunctions = publicFunctions;
    self.privateVariables = [[NSMutableArray alloc] init];
    self.parameters = [[NSMutableArray alloc] init];
    self.isConstantValue = false;
    self.isVariable = false;
    self.errors = errors;
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if(self.isConstantValue) {
        return self.constantValue;
    }
    if(self.isVariable) {
        for(int i=0; i<[input count]; i++) {
            
            if([self.variableName isEqual: [input[i] name]]) {
                return [input[i] variableValue];
            }
        }
        for(int i=0; i<[self.publicVariables count]; i++) {
            
            if([self.variableName isEqual: [self.publicVariables[i] name]]) {
                return [self.publicVariables[i] variableValue];
            }
        }
        [self.errors addObject:@"ERROR (Variable Not Defined)"];
        return NULL;
    }
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(int i=0; i<[self.parameters count]; i++) {
        MathObject *newObject = [[MathObject alloc] init];
        newObject = [self.parameters[i] func:input];
        if(newObject == NULL) {
            
            
            
            return NULL;
            
            
            
        }
        else {
            [arr addObject:newObject];
        }
    }
    
    return [self.op func:arr];
}

- (bool) define: (NSString*) input {
    if([input isEqual: @""]) {
        self.op = [[MathNull alloc] init];
        return true;
    }
    
    int i;
    int parantheseCount = 0;
    int parenthesesLevel = 0;
    int divisionIndex = -1;
    double orderOfOperations = 0;
    for(i=0; i<[input length]; i++) {
        
        if([input characterAtIndex:i] == '(' || [input characterAtIndex:i] == '[') {
            parenthesesLevel++;
            parantheseCount++;
        }
        else if([input characterAtIndex:i] == ')' || [input characterAtIndex:i] == ']') {
            parenthesesLevel--;
        }
        
        if(parenthesesLevel == 0) {
            int charType = [self characterType:[input characterAtIndex: i]];
            if(charType == 3) {
                if(i != 0 && i != [input length]) {
                    if([input characterAtIndex:i] == '-') {
                        // special, because we stupidly decided that "-" means negative and minus
                        if([self characterType:[input characterAtIndex:i-1]] == 3) {
                            // "-" was negative, so ignore it for now (we're only looking for operations, negation is taken care of later)
                        }
                        else {
                            // "-" was a minus-sign, its normal (unless it is preceded by 'E')
                            if([input characterAtIndex:i-1] != 'E') {
                                if(i + 10000*[self orderOfOperationsValue: [input characterAtIndex: i]] > orderOfOperations) {
                                    divisionIndex = i;
                                    orderOfOperations = i + 10000*[self orderOfOperationsValue: [input characterAtIndex: i]];
                                }
                            }
                        }
                    }
                    else {
                        if(i + 10000*[self orderOfOperationsValue: [input characterAtIndex: i]] > orderOfOperations) {
                            divisionIndex = i;
                            orderOfOperations = i + 10000*[self orderOfOperationsValue: [input characterAtIndex: i]];
                        }
                    }
                }
            }
            else if([input characterAtIndex:i] == '=') {
                // we check for equality pair here
                if(i == 0 || i == [input length]-1) {
                    // an expression should never begin or end with equal signs
                    return false;
                }
                if([input characterAtIndex:i+1] == '=')
                {
                    if(i + 10000*[self orderOfOperationsValue: [input characterAtIndex: i]] > orderOfOperations) {
                        divisionIndex = i;
                        orderOfOperations = i + 10000*[self orderOfOperationsValue: [input characterAtIndex: i]];
                    }
                }
            }
        }
    }
    
    if(parenthesesLevel != 0) {
        return false;
    }
    
    if(divisionIndex == -1) {
        if(parantheseCount == 0) {
            // whether variable or number, there could be a negation, so we must check for that
            // whether variable or number, there could be a factorial, so we must also check for that
            int charType = [self characterType:[input characterAtIndex:0]];
            
            
            if([input characterAtIndex:[input length]-1] == '!') {
                // factorial
                self.op = [[MathFactorial alloc] init];
                [self.parameters addObject:[[MathPersistentExpression alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariables publicFunctions:self.publicFunctions errors:self.errors]];
                return [self.parameters[0] define:[input substringToIndex:[input length]-1]];
            }
            else if(charType == 0) {
                // number
                self.isConstantValue = true;
                self.constantValue = [[MathNumber alloc] init];
                
                int i;
                for(i=0; i<[input length]; i++) {
                    if([input characterAtIndex:i] == 'E') {
                        break;
                    }
                }
                if(i == [input length]) {
                    self.constantValue = [[MathNumber alloc] init];
                    [self.constantValue setDouble:[input doubleValue]];
                    return true;
                }
                else {
                    
                    // scientific notation
                    NSArray *arr = [input componentsSeparatedByString:@"E"];
                    
                    if([arr count] == 2) {
                        [self.constantValue setDouble:[arr[0] doubleValue]];
                        double start = [self.constantValue getDouble];
                        start *= pow(10, [arr[1] doubleValue]);
                        [self.constantValue setDouble:start];
                        return true;
                    }
                    else {
                        // error
                        return NULL;
                    }
                }
                
            }
            else if(charType == 1) {
                // letter
                self.isVariable = true;
                self.variableName = input;
                return true;
            }
            else if([input characterAtIndex:0] == '-') {
                // we'll take care of factorial on the next iteration
                self.op = [[MathInverse alloc] init];
                [self.parameters addObject:[[MathPersistentExpression alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariables publicFunctions:self.publicFunctions errors:self.errors]];
                return [self.parameters[0] define:[input substringFromIndex:1]];
            }
            return false;
        }
        else {
            if([input characterAtIndex:0] == '(') {
                if([input characterAtIndex:[input length]-1] == '!') {
                    // (...)!
                    // We will take the liberty of removing the parentheses too
                    self.op = [[MathFactorial alloc] init];
                    [self.parameters addObject:[[MathPersistentExpression alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariables publicFunctions:self.publicFunctions errors: self.errors]];
                    return [self.parameters[0] define:[input substringWithRange:NSMakeRange(1, [input length]-3)]];
                }
                else {
                    // (...)
                    return [self define:[input substringWithRange:NSMakeRange(1, [input length]-2)]];
                }
            }
            if([input characterAtIndex:0] == '[') {
                // [...]
                NSString *functionParameters = [[NSString alloc] initWithString:[input substringWithRange:NSMakeRange(1, input.length-2)]];
                NSArray *parameterList = [self splitParameters:functionParameters];
                for(int j=0; j<parameterList.count; j++) {
                    [self.parameters addObject:[[MathPersistentExpression alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariables publicFunctions:self.publicFunctions errors:self.errors]];
                    if(![self.parameters[j] define:parameterList[j]]) {
                        return false;
                    }
                }
                self.op = [[MathConstructVector alloc] init];
                return true;
            }
            else {
                // f(...)
                // find function's name
                int firstParantheses = -1;
                for(int i=0; i<[input length]; i++) {
                    if([input characterAtIndex:i] == '(') {
                        firstParantheses = i;
                        break;
                    }
                }
                if(firstParantheses == -1) {
                    [self.errors addObject:@"ERROR (Function Missing Parantheses)"];
                    return NULL;
                }
                
                NSString *functionName = [[NSString alloc] initWithString:[input substringToIndex:firstParantheses]];
                NSString *functionParameters = [[NSString alloc] initWithString:[input substringWithRange:NSMakeRange(firstParantheses+1, [input length]-firstParantheses-2)]];
                
                // check publicFunction
                int i;
                int j;
                for(i=0; i<[self.publicFunctions count]; i++) {
                    if([[self.publicFunctions[i] name] isEqual: functionName]) {
                        NSArray *parameterList = [self splitParameters:functionParameters];
                        
                        for(j=0; j<[parameterList count]; j++) {
                            [self.parameters addObject:[[MathPersistentExpression alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariables publicFunctions:self.publicFunctions errors:self.errors]];
                            if(![self.parameters[j] define:parameterList[j]]) {
                                return false;
                            }
                        }
                        self.op = self.publicFunctions[i];
                        return true;
                    }
                }
                return false;
            }
        }
    }
    else {
        unichar character = [input characterAtIndex: divisionIndex];
        if([self characterType: character] == 3) {
            // binary atomic operation
            if(character == '*') {
                self.op = [[MathMultiplication alloc] init];
            }
            else if(character == '+') {
                self.op = [[MathAddition alloc] init];
            }
            else if(character == '-') {
                self.op = [[MathSubtraction alloc] init];
            }
            else if(character == '/') {
                self.op = [[MathDivision alloc] init];
            }
            else if(character == '^') {
                self.op = [[MathPower alloc] init];
            }
            else if(character == '%') {
                self.op = [[MathModulo alloc] init];
            }
            else if(character == '<') {
                self.op = [[MathLessThan alloc] init];
            }
            else if(character == '>') {
                self.op = [[MathGreaterThan alloc] init];
            }
            else if(character == 8804) {
                self.op = [[MathLessThanOrEqualTo alloc] init];
            }
            else if(character == 8805) {
                self.op = [[MathGreaterThanOrEqualTo alloc] init];
            }
            else if(character == 8880) {
                self.op = [[MathNotEqualTo alloc] init];
            }
            
            
            [self.parameters addObject:[[MathPersistentExpression alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariables publicFunctions:self.publicFunctions errors:self.errors]];
            [self.parameters addObject:[[MathPersistentExpression alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariables publicFunctions:self.publicFunctions errors:self.errors]];
            bool A = [self.parameters[0] define:[input substringToIndex:divisionIndex]];
            bool B = [self.parameters[1] define:[input substringFromIndex:divisionIndex+1]];
            return (A && B);
        }
        else if([input characterAtIndex:divisionIndex] == '=') {
            // check equality
            self.op = [[MathEquality alloc] init];
            [self.parameters addObject:[[MathPersistentExpression alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariables publicFunctions:self.publicFunctions errors:self.errors]];
            [self.parameters addObject:[[MathPersistentExpression alloc] initWithPointerToPublicVariablesAndFunctions:self.publicVariables publicFunctions:self.publicFunctions errors:self.errors]];
            return ([self.parameters[0] define:[input substringToIndex:divisionIndex]] && [self.parameters[1] define:[input substringFromIndex:divisionIndex+2]]);
        }
    }
                            return false;
}

- (int) orderOfOperationsValue: (unichar) x {
    if(x == '=' || x == '<' || x == '>' || x == 8804 || x == 8805 || x == 8800) {
        return 5;
    }
    if(x == '+' || x == '-') {
        return 4;
    }
    else if(x == '*' || x == '/' || x == '%') {
        return 3;
    }
    else if(x == '^') {
        return 2;
    }
    else if(x == '!') {
        return 1;
    }
    return 0;
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
    if(x == '(' || x == ')' || x == '[' || x == ']') {
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
    return -2;
}

- (NSMutableArray*) splitParameters: (NSString*) input {
    NSMutableArray *rtn = [[NSMutableArray alloc] init];
    int parenthesesLevel = 0;
    int lastComma = -1;
    int i;
    
    for(i=0; i<[input length]; i++) {
        if([input characterAtIndex:i] == '(' || [input characterAtIndex:i] == '[') {
            parenthesesLevel++;
        }
        else if([input characterAtIndex:i] == ')' || [input characterAtIndex:i] == ']') {
            parenthesesLevel--;
        }
        else if(parenthesesLevel == 0 && [input characterAtIndex:i] == ',') {
            [rtn addObject:[input substringWithRange:NSMakeRange(lastComma+1, i-lastComma-1)]];
            lastComma = i;
        }
    }
    [rtn addObject:[input substringWithRange:NSMakeRange(lastComma+1, i-lastComma-1)]];
    if([rtn count] == 1) {
        if([rtn[0] isEqual: @""]) {
            return NULL;
        }
    }
    return rtn;
}

@end
