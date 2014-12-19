//
//  MathExponentialDistribution.m
//  Calculator
//
//  Created by Thomas Redding on 11/13/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathExponentialDistribution.h"

@implementation MathExponentialDistribution

- (MathExponentialDistribution*) init {
    self.name = @"pexp";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] == 2) {
        if([input[0] objectType] == MATHNUMBER && [input[1] objectType] == MATHNUMBER) {
            if([input[0] getDouble:1] == 0 && [input[1] getDouble:1] == 0) {
                double x = [input[0] getDouble];
                if(x < 0) {
                    return NULL;
                }
                double lambda = [input[1] getDouble];
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble:1-exp(-1*lambda*x)];
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
