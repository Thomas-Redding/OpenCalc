//
//  MathPower.m
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathPower.h"

@implementation MathPower

- (MathObject*)func: (NSArray*) input {
    if([input count] != 2) {
        return NULL;
    }
    if([input[0] objectType] == MATHNUMBER && [input[0] objectType] == MATHNUMBER) {
        double a = [input[0] getDouble:0];
        double b = [input[0] getDouble:1];
        double c = [input[1] getDouble:0];
        double d = [input[1] getDouble:1];
        if(b == 0 && d == 0) {
            // real^real
            MathNumber *answer = [[MathNumber alloc] init];
            [answer setDouble:0 newValue: pow(a, c)];
            [answer setDouble:1 newValue: 0];
            return answer;
        }
        else if(b == 0) {
            // real^complex
            if(a < 0) {
                return NULL;
            }
            else {
                if(c == 0 && d == 3.14159265358979323846) {
                    MathNumber *answer = [[MathNumber alloc] init];
                    [answer setDouble: -1];
                    [answer setDouble:1 newValue:-1];
                    return answer;
                }
                MathNumber *answer = [[MathNumber alloc] init];
                double scale = pow(a, c);
                [answer setDouble: 0 newValue: scale*cos(d*log(a))];
                [answer setDouble: 1 newValue: scale*sin(d*log(a))];
                return answer;
            }
        }
        else if(d == 0) {
            // complex^real (simplified version of complex^complex)
            double base = a*a+b*b;
            if(base == 0) {
                MathNumber *answer = [[MathNumber alloc] init];
                return answer;
            }
            double firstHalfReal = pow(base, c/2);
            double complexArgument;
            if(a == 0) {
                complexArgument = 3.141592654/2;
            }
            else {
                complexArgument = atan(b/a);
            }
            
            // return answer
            MathNumber *answer = [[MathNumber alloc] init];
            [answer setDouble:0 newValue:firstHalfReal*cos(c*complexArgument)];
            [answer setDouble:1 newValue:firstHalfReal*sin(c*complexArgument)];
            return answer;
        }
        else {
            // complex^complex
            double base = a*a+b*b;
            if(base == 0) {
                // return 0
                MathNumber *answer = [[MathNumber alloc] init];
                return answer;
            }
            
            // determine first half
            double firstHalfReal = pow(base, c/2)*cos(d/2*log(base));
            double firstHalfImag = pow(base, c/2)*sin(d/2*log(base));
            
            // determine second half
            double complexArgument;
            if(a == 0) {
                complexArgument = 3.141592654/2;
            }
            else {
                complexArgument = atan(b/a);
            }
            double powerReal = -1*d*complexArgument;
            double powerImag = c*complexArgument;
            double secondHalfReal = exp(powerReal)*cos(powerImag);
            double secondHalfImag = exp(powerReal)*sin(powerImag);
            
            // multiply two halves together
            double realValue = firstHalfReal*secondHalfReal - firstHalfImag*secondHalfImag;
            double imagValue = firstHalfReal*secondHalfImag+firstHalfImag*secondHalfReal;
            
            // return answer
            MathNumber *answer = [[MathNumber alloc] init];
            [answer setDouble:0 newValue:realValue];
            [answer setDouble:1 newValue:imagValue];
            return answer;
        }
        return NULL;
    }
    else {
        return NULL;
    }
}


@end
