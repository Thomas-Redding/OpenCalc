//
//  MathNormalDistribution.m
//  Calculator
//
//  Created by Thomas Redding on 11/13/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathNormalDistribution.h"

@implementation MathNormalDistribution

- (MathNormalDistribution*) init {
    self.name = @"pnorm";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] == 3) {
        if([input[0] objectType] == MATHNUMBER && [input[1] objectType] == MATHNUMBER && [input[2] objectType] == MATHNUMBER) {
            if([input[0] getDouble:1] == 0 && [input[1] getDouble:1] == 0 && [input[2] getDouble:1] == 0) {
                double x = [input[0] getDouble];
                x = (x-[input[1] getDouble])/[input[2] getDouble];
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble:(erf(x/1.41421356237)+1)/2];
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
                [answer setDouble:(erf(x/1.41421356237)+1)/2];
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
