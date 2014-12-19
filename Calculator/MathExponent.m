//
//  MathExponent.m
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathExponent.h"

@implementation MathExponent

- (MathExponent*) init {
    self.name = @"exp";
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
            [answer setDouble:exp([input[0] getDouble])];
            return answer;
        }
        else {
            // input is complex
            double real = [input[0] getDouble];
            double imag = [input[0] getDouble:1];
            if(real == 0 && imag == 3.14159265358979323846) {
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble: -1];
                [answer setDouble:1 newValue:-1];
                return answer;
            }
            MathNumber *answer = [[MathNumber alloc] init];
            double scale = exp(real);
            [answer setDouble:scale*cos(imag)];
            [answer setDouble:1 newValue:scale*sin(imag)];
            return answer;
        }
    }
    return NULL;
}

@end
