//
//  MathBinomialDensity.m
//  Calculator
//
//  Created by Thomas Redding on 11/13/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathBinomialDensity.h"

@implementation MathBinomialDensity

- (MathBinomialDensity*) init {
    self.name = @"dbinom";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] == 3) {
        if([input[0] objectType] == MATHNUMBER && [input[1] objectType] == MATHNUMBER && [input[2] objectType] == MATHNUMBER) {
            if([input[0] getDouble:1] == 0 && [input[1] getDouble:1] == 0 && [input[2] getDouble:1] == 0) {
                double s = [input[0] getDouble];
                double n = [input[1] getDouble];
                double p = [input[2] getDouble];
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble:[self getProbability:s n:n p:p]];
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
                double x = [input[0] getDouble];
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble:exp(x*x/-2)/sqrt(2*3.14159265358979323846)];
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

- (double) getProbability: (double) s n: (double) n p: (double) p {
    double rtn = 0;
    rtn = pow(p, s)*pow(1-p, n-s);
    return rtn*[self choose:n k:s];
}

- (double) choose: (long) n k: (long) k {
    double output = 1;
    long i = n-k+1;     // i<=n
    long j = 2;         // j<=k;
    while(i<=n || j<=k) {
        if(output < 1) {
            if(i <= n) {
                output *= i;
                i++;
            }
            else {
                output /= j;
                j++;
            }
        }
        else {
            if(j<=k) {
                output /= j;
                j++;
            }
            else {
                output *= i;
                i++;
            }
        }
    }
    return output;
}

@end
