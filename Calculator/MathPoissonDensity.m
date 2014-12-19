//
//  MathPoissonDensity.m
//  Calculator
//
//  Created by Thomas Redding on 11/13/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathPoissonDensity.h"

@implementation MathPoissonDensity

- (MathPoissonDensity*) init {
    self.name = @"dpois";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] == 2) {
        if([input[0] objectType] == MATHNUMBER && [input[1] objectType] == MATHNUMBER) {
            if([input[0] getDouble:1] == 0 && [input[1] getDouble:1] == 0) {
                double k = [input[0] getDouble];
                double lambda = [input[1] getDouble];
                double p = 0;
                p = pow(lambda, k);
                for(int i=1; i<=k; i++) {
                    p /= i;
                }
                
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble:p*exp(-1*lambda)];
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
