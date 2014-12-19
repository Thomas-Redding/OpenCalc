//
//  MathErrorFunction.m
//  Calculator
//
//  Created by Thomas Redding on 10/30/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathErrorFunction.h"

@implementation MathErrorFunction

- (MathErrorFunction*) init {
    self.name = @"erf";
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
            [answer setDouble:erf([input[0] getDouble])];
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
