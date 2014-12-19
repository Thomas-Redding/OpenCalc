//
//  MathPoissonQuantile.m
//  Calculator
//
//  Created by Thomas Redding on 11/13/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathPoissonQuantile.h"

@implementation MathPoissonQuantile

- (MathPoissonQuantile*) init {
    self.name = @"qpois";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] == 2) {
        if([input[0] objectType] == MATHNUMBER && [input[1] objectType] == MATHNUMBER) {
            if([input[0] getDouble:1] == 0 && [input[1] getDouble:1] == 0) {
                double p = [input[0] getDouble];
                double lambda = [input[1] getDouble];
                
                if(p<0 || p>=1) {
                    return NULL;
                }
                
                p *= exp(lambda);
                double deltaP;
                
                for(int k=0; k<1000; k++) {
                    deltaP = pow(lambda, k);
                    for(int i=1; i<=k; i++) {
                        deltaP /= i;
                    }
                    p -= deltaP;
                    if(p <= 0) {
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
        else {
            return NULL;
        }
    }
    else {
        return NULL;
    }
}


@end
