//
//  MathExponentialQuantile.m
//  Calculator
//
//  Created by Thomas Redding on 11/13/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathExponentialQuantile.h"

@implementation MathExponentialQuantile

- (MathExponentialQuantile*) init {
    self.name = @"qexp";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] == 2) {
        if([input[0] objectType] == MATHNUMBER && [input[1] objectType] == MATHNUMBER) {
            if([input[0] getDouble:1] == 0 && [input[1] getDouble:1] == 0) {
                double p = [input[0] getDouble];
                if(p < 0 || p > 1) {
                    return NULL;
                }
                double lambda = [input[1] getDouble];
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble:log(1-p)/-1/lambda];
                return answer;
            }
            else {
                return NULL;
            }
        }
        else {
            return NULL;
        }
    }
    else {
        return NULL;
    }
}

@end
