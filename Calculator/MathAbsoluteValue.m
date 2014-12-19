//
//  MathAbsoluteValue.m
//  Calculator
//
//  Created by Thomas Redding on 10/2/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathAbsoluteValue.h"

@implementation MathAbsoluteValue

- (MathAbsoluteValue*) init {
    self.name = @"abs";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] != 1) {
        return NULL;
    }
    if([input[0] objectType] == MATHNUMBER) {
        if([input[0] getDouble:1] == 0) {
            // input is real
            MathNumber *answer = [[MathNumber alloc] init];
            [answer setDouble:fabs([input[0] getDouble])];
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
