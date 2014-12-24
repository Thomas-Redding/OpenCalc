//
//  MathFactorial.m
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathFactorial.h"

@implementation MathFactorial

- (MathObject*)func: (NSArray*) input {
    if([input count] != 1) {
        return NULL;
    }
    if([input[0] objectType] == MATHNUMBER) {
        if([input[0] getDouble:1] == 0) {
            double x = [input[0] getDouble];
            if(x == (long) x) {
                if(x <= 0) {
                    // real negative integer
                    return NULL;
                }
                else {
                    // real non-negative integer
                    MathNumber *answer = [[MathNumber alloc] init];
                    double newValue = 1;
                    for(long i=2; i<=x; i++) {
                        newValue *= i;
                    }
                    [answer setDouble:newValue];
                    return answer;
                }
            }
            else {
                // real non-integer
                return NULL;
            }
        }
        else {
            // complex
            return NULL;
        }
    }
    return NULL;
}

@end
