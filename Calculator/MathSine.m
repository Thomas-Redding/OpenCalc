//
//  MathSine.m
//  Calculator
//
//  Created by Thomas Redding on 9/30/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathSine.h"

@implementation MathSine

- (MathSine*) init {
    self.name = @"sin";
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
            [answer setDouble:sin([input[0] getDouble])];
            return answer;
        }
        else {
            // input is complex
            MathNumber *answer = [[MathNumber alloc] init];
            [answer setDouble: sin([input[0] getDouble])*cosh([input[0] getDouble:1])];
            [answer setDouble:1 newValue:cos([input[0] getDouble])*sinh([input[0] getDouble:1])];
            return answer;
        }
    }
    return NULL;
}

@end
