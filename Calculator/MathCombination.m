//
//  MathCombination.m
//  Calculator
//
//  Created by Thomas Redding on 10/2/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathCombination.h"

@implementation MathCombination

- (MathCombination*) init {
    self.name = @"C";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] != 2) {
        return NULL;
    }
    if([input[0] objectType] == MATHNUMBER && [input[0] objectType] == MATHNUMBER) {
        if([input[0] getDouble:1] == 0 && [input[0] getDouble:1] == 0) {
            // input is real
            long n = [input[0] getDouble];
            long k = [input[1] getDouble];
            MathNumber *answer = [[MathNumber alloc] init];
            
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
            
            [answer setDouble:output];
            return answer;
        }
        else {
            // input is complex
            return NULL;
        }
    }
    else {
        return NULL;
    }
}

@end
