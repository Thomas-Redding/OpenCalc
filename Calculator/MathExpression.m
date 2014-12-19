//
//  MathExpression.m
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathExpression.h"

@implementation MathExpression

- (MathObject*) evaluate: (NSString*) input publicVariable: (NSMutableArray*) publicVariable publicFunction: (NSMutableArray*) publicFunction errors: (NSMutableArray*) errors {
    if([input length] == 0) {
        // this may not be an error because of rand()
        return NULL;
    }
    
    int i;
    int parantheseCount = 0;
    int parenthesesLevel = 0;
    int divisionIndex = -1;
    double orderOfOperations = 0;
    for(i=0; i<[input length]; i++) {
        if([input characterAtIndex:i] == '(') {
            parenthesesLevel++;
            parantheseCount++;
        }
        else if([input characterAtIndex:i] == ')') {
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
                if(i == 0) {
                    [errors addObject:@"ERROR (Equal Signs at Beginning of Expression)"];
                    return NULL;
                }else if(i == [input length]-1) {
                    // an expression should never begin or end with equal signs
                    [errors addObject:@"ERROR (Equal Signs at End of Expression)"];
                    return NULL;
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
        else if(parenthesesLevel < 0) {
            [errors addObject:@"ERROR (Parantheses Issue)"];
            return NULL;
        }
    }
    
    if(divisionIndex == -1) {
        if(parantheseCount == 0) {
            // whether variable or number, there could be a negation, so we must check for that
            // whether variable or number, there could be a factorial, so we must also check for that
            int charType = [self characterType:[input characterAtIndex:0]];
            if([input characterAtIndex:[input length]-1] == '!') {
                // factorial
                MathFactorial *factorialer = [[MathFactorial alloc] init];
                MathExpression *simplified = [[MathExpression alloc] init];
                return [factorialer func:[[NSArray alloc] initWithObjects:[simplified evaluate:[input substringToIndex:[input length]-1] publicVariable: publicVariable publicFunction:publicFunction errors:errors], nil]];
            }
            else if(charType == 0) {
                // number
                int i;
                for(i=0; i<[input length]; i++) {
                    if([input characterAtIndex:i] == 'E') {
                        break;
                    }
                }
                if(i == [input length]) {
                    MathNumber *answer = [[MathNumber alloc] init];
                    [answer setDouble:0 newValue:[input doubleValue]];
                    return answer;
                }
                else {
                    
                    // scientific notation
                    NSArray *arr = [input componentsSeparatedByString:@"E"];
                    
                    if([arr count] == 2) {
                        MathNumber *answer = [[MathNumber alloc] init];
                        [answer setDouble:[arr[0] doubleValue]];
                        double start = [answer getDouble];
                        start *= pow(10, [arr[1] doubleValue]);
                        [answer setDouble:start];
                        return answer;
                    }
                    else {
                        // error
                        return NULL;
                    }
                }
            }
            else if(charType == 1) {
                // letter
                for(int i=0; i<[publicVariable count]; i++) {
                    if([[publicVariable[i] name] isEqual: input]) {
                        return [publicVariable[i] variableValue];
                    }
                }
                [errors addObject:@"ERROR (Variable Not Found)"];
                return NULL;
            }
            else if([input characterAtIndex:0] == '-') {
                // we'll take care of factorial on the next iteration
                MathInverse *inverser = [[MathInverse alloc] init];
                MathExpression *simplified = [[MathExpression alloc] init];
                return [inverser func:[[NSArray alloc] initWithObjects:[simplified evaluate:[input substringFromIndex:1] publicVariable: publicVariable publicFunction:publicFunction errors:errors], nil]];
            }
            [errors addObject:@"ERROR"];
            return NULL;
        }
        else {
            if([input characterAtIndex:0] == '(') {
                if([input characterAtIndex:[input length]-1] == '!') {
                    // (...)!
                    // We will take the liberty of removing the parentheses too
                    MathFactorial *factorialer = [[MathFactorial alloc] init];
                    MathExpression *simplified = [[MathExpression alloc] init];
                    return [factorialer func:[[NSArray alloc] initWithObjects:[simplified evaluate:[input substringWithRange:NSMakeRange(1, [input length]-2)] publicVariable: publicVariable publicFunction:publicFunction errors:errors], nil]];
                }
                else {
                    // (...)
                    NSString *inputAString = [input substringWithRange:NSMakeRange(1, [input length]-2)];
                    MathExpression *simplified = [[MathExpression alloc] init];
                    return [simplified evaluate:inputAString publicVariable: publicVariable publicFunction:publicFunction errors:errors];
                }
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
                    [errors addObject:@"ERROR (Function Doesn't Have Parantheses)"];
                    return NULL;
                }
                
                NSString *functionName = [[NSString alloc] initWithString:[input substringToIndex:firstParantheses]];
                NSString *functionParameters = [[NSString alloc] initWithString:[input substringWithRange:NSMakeRange(firstParantheses+1, [input length]-firstParantheses-2)]];
                
                
                
                // check publicFunction
                for(int i=0; i<[publicFunction count]; i++) {
                    if([[publicFunction[i] name] isEqual: functionName]) {
                        NSArray *parameterList = [self splitParameters:functionParameters];
                        NSMutableArray* inputExpression = [[NSMutableArray alloc] init];
                        NSMutableArray* inputObject = [[NSMutableArray alloc] init];
                        for(int j=0; j<[parameterList count]; j++) {
                            [inputExpression addObject: [[MathExpression alloc] init]];
                            
                            
                            [inputObject addObject:[inputExpression[j] evaluate:parameterList[j] publicVariable:publicVariable publicFunction:publicFunction errors:errors]];
                        }
                        MathObject *answer = [publicFunction[i] func:inputObject];
                        return answer;
                    }
                }
                
                
                
                [errors addObject: @"ERROR (Function Is Not Defined)"];
                return NULL;
            }
        }
    }
    else {
        unichar character = [input characterAtIndex: divisionIndex];
        if([self characterType: character] == 3) {
            // binary atomic operation
            NSString* inputStringA = [input substringToIndex:divisionIndex];
            NSString* inputStringB = [input substringFromIndex:divisionIndex+1];
            MathFunction *op;
            if(character == '*') {
                op = [[MathMultiplication alloc] init];
            }
            else if(character == '+') {
                op = [[MathAddition alloc] init];
            }
            else if(character == '-') {
                op = [[MathSubtraction alloc] init];
            }
            else if(character == '/') {
                op = [[MathDivision alloc] init];
            }
            else if(character == '^') {
                op = [[MathPower alloc] init];
            }
            else if(character == '%') {
                op = [[MathModulo alloc] init];
            }
            else if(character == '<') {
                op = [[MathLessThan alloc] init];
            }
            else if(character == '>') {
                op = [[MathGreaterThan alloc] init];
            }
            else if(character == 8804) {
                op = [[MathLessThanOrEqualTo alloc] init];
            }
            else if(character == 8805) {
                op = [[MathGreaterThanOrEqualTo alloc] init];
            }
            else if(character == 8800) {
                op = [[MathNotEqualTo alloc] init];
            }
            
            
            
            MathExpression *inputExpression = [[MathExpression alloc] init];
            MathObject* inputObjectA = [inputExpression evaluate:inputStringA publicVariable:publicVariable publicFunction:publicFunction errors:errors];
            MathObject* inputObjectB = [inputExpression evaluate:inputStringB publicVariable:publicVariable publicFunction:publicFunction errors:errors];
            NSArray* arr = [[NSArray alloc] initWithObjects: inputObjectA, inputObjectB, nil];
            MathObject* answer = [op func: arr];
            
            
            
            return answer;
        }
        else if([input characterAtIndex:divisionIndex] == '=') {
            // check equality
            NSString* inputStringA = [input substringToIndex:divisionIndex];
            NSString* inputStringB = [input substringFromIndex:divisionIndex+2];
            MathEquality *op = [[MathEquality alloc] init];
            
            MathExpression *inputExpression = [[MathExpression alloc] init];
            MathObject* inputObjectA = [inputExpression evaluate:inputStringA publicVariable:publicVariable publicFunction:publicFunction errors:errors];
            MathObject* inputObjectB = [inputExpression evaluate:inputStringB publicVariable:publicVariable publicFunction:publicFunction errors:errors];
            return [op func:[[NSArray alloc] initWithObjects: inputObjectA, inputObjectB, nil]];
        }
        else {
            // non-binary atomic operation ! or -
            [errors addObject: @"ERROR"];
            return NULL;
        }
    }
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
    if(x == '(' || x == ')') {
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
    if([input isEqual: @""]) {
        return rtn;
    }
    int parenthesesLevel = 0;
    int lastComma = -1;
    int i;
    
    for(i=0; i<[input length]; i++) {
        if([input characterAtIndex:i] == '(') {
            parenthesesLevel++;
        }
        else if([input characterAtIndex:i] == ')') {
            parenthesesLevel--;
        }
        else if(parenthesesLevel == 0 && [input characterAtIndex:i] == ',') {
            [rtn addObject:[input substringWithRange:NSMakeRange(lastComma+1, i-lastComma-1)]];
            lastComma = i;
        }
    }
    [rtn addObject:[input substringWithRange:NSMakeRange(lastComma+1, i-lastComma-1)]];
    return rtn;
}

@end
