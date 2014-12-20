//
//  MathNormalQuantile.m
//  Calculator
//
//  Created by Thomas Redding on 11/13/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathNormalQuantile.h"

@implementation MathNormalQuantile

- (MathNormalQuantile*) init {
    self.name = @"qnorm";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] == 3) {
        if([input[0] objectType] == MATHNUMBER && [input[1] objectType] == MATHNUMBER && [input[2] objectType] == MATHNUMBER) {
            if([input[0] getDouble:1] == 0 && [input[1] getDouble:1] == 0 && [input[2] getDouble:1] == 0) {
                double p = [input[0] getDouble];
                double z = [self inverseNormal: p];
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble:[input[2] getDouble]*z+[input[1] getDouble]];
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
    else if([input count] == 1) {
        if([input[0] objectType] == MATHNUMBER) {
            if([input[0] getDouble:1] == 0) {
                double p = [input[0] getDouble];
                double z = [self inverseNormal: p];
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble:z];
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

- (double) inverseNormal: (double) p {
    double z;
    
    // guess z
    if(p <= 0.5) {
        z = -1.1*pow(-1-log2(p), 0.51);
    }
    else {
        z = 1.1*pow(-1-log2(1-p), 0.51);
    }
    
    double y = [self cumulativeNormal:z];
    double s = exp(z*z/-2)/2.506628275;     // √(2*pi)
    // use Newton's method
    for(int i=0; i<100000; i++) {
        z -= (y-p)/s;
        y = [self cumulativeNormal:z];
        s = exp(z*z/-2)/sqrt(6.283185307);
    }
    return z;
}

- (double) cumulativeNormal: (double) x {
    return (erf(x/1.41421356237)+1)/2;
}

@end
