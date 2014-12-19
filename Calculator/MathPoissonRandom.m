//
//  MathPoissonRandom.m
//  Calculator
//
//  Created by Thomas Redding on 11/5/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathPoissonRandom.h"

@implementation MathPoissonRandom

- (MathPoissonRandom*) init {
    self.name = @"rpois";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] != 1) {
        return NULL;
    }
    else {
        if([input[0] objectType] == MATHNUMBER && [input[0] getDouble: 1] == 0) {
            double x = ((double)arc4random() / ARC4RANDOM_MAX);
            double lambda = [input[0] getDouble];
            x *= exp(lambda);
            for(int k=0; k<50; k++) {
                double y = pow(lambda, k);
                for(int i=2; i<=k; i++) {
                    y /= i;
                }
                x -= y;
                if(x <= 0) {
                    MathNumber *answer = [[MathNumber alloc] init];
                    [answer setDouble:k];
                    return answer;
                }
            }
            return NULL;
        }
        else {
            return NULL;
        }
    }
}

@end
