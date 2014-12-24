//
//  MathCotangentB.m
//  Calculator
//
//  Created by Thomas Redding on 12/23/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathCotangentB.h"

@implementation MathCotangentB

- (MathCotangentB*) init {
    self.name = @"cot";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] != 1) {
        return NULL;
    }
    if([input[0] objectType] == MATHNUMBER) {
        if([input[0] getDouble:1] == 0) {
            // input is real
            MathNumber *answer = [[MathNumber alloc] init];
            [answer setDouble:1/tan([input[0] getDouble])];
            return answer;
        }
        else {
            // input is complex
            double a = [input[0] getDouble];
            double b = [input[0] getDouble:1];
            double denominator = cos(2*a)-cosh(2*b);
            if(denominator == 0) {
                // This should only happen if the input is real; thus this should never happen
                return NULL;
            }
            MathNumber *answer = [[MathNumber alloc] init];
            [answer setDouble:0 newValue: -1*sin(2*a)/denominator];
            [answer setDouble:1 newValue: sinh(2*b)/denominator];
            return answer;
            
        }
    }
    return NULL;
}

@end
