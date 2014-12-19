//
//  MathSquareRoot.m
//  Calculator
//
//  Created by Thomas Redding on 10/2/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathSquareRoot.h"

@implementation MathSquareRoot

- (MathSquareRoot*) init {
    self.name = @"sqrt";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] != 1) {
        return NULL;
    }
    if([input[0] objectType] == MATHNUMBER) {
        if([input[0] getDouble:1] == 0) {
            // input is real
            if([input[0] getDouble] >= 0) {
                // input is positive or 0
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble:sqrt([input[0] getDouble])];
                return answer;
            }
            else {
                // input is negative
                return NULL;
            }
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
