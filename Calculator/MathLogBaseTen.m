//
//  MathLogBaseTen.m
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathLogBaseTen.h"

@implementation MathLogBaseTen

- (MathLogBaseTen*) init {
    self.name = @"log";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] != 1) {
        return NULL;
    }
    if([input[0] objectType] == MATHNUMBER) {
        double real = [input[0] getDouble];
        double imag = [input[0] getDouble:1];
        if(imag == 0) {
            // input is real
            if(real > 0) {
                // positive
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble:log10(real)];
                return answer;
            }
            else if(real < 0) {
                // negative
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble:log10(-1*real)];
                [answer setDouble:1 newValue:1.3643763538418413474857836254313557702101274837239254];
                return answer;
            }
            else {
                // zero
                return NULL;
            }
        }
        else if(real == 0) {
            // input is imaginary (not complex)
            MathNumber *answer = [[MathNumber alloc] init];
            if(imag > 0) {
                // positive
                [answer setDouble:log10(imag)];
                [answer setDouble:1 newValue:1.3643763538418413474857836254313557702101274837239251];
                return answer;
            }
            else {
                // negative
                [answer setDouble:log10(-1*imag)];
                [answer setDouble:1 newValue:-1.3643763538418413474857836254313557702101274837239251];
                return answer;
            }
        }
        else {
            // input is complex (neither real, nor imaginary)
            // TODO
            return NULL;
        }
    }
    else {
        return NULL;
    }
}

@end
