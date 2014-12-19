//
//  MathBinomialRandom.m
//  Calculator
//
//  Created by Thomas Redding on 11/5/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathBinomialRandom.h"

@implementation MathBinomialRandom

- (MathBinomialRandom*) init {
    self.name = @"rbinom";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] != 2) {
        return NULL;
    }
    else {
        if([input[0] objectType] == MATHNUMBER && [input[1] objectType] == MATHNUMBER) {
            if([input[0] getDouble:1] == 0 && [input[1] getDouble:1] == 0) {
                double n = [input[0] getDouble];
                double p = [input[1] getDouble];
                double rtn = 0;
                for(int i=0; i<n; i++) {
                    if(((double)arc4random() / ARC4RANDOM_MAX) < p) {
                        rtn++;
                    }
                }
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble:rtn];
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
}

@end
