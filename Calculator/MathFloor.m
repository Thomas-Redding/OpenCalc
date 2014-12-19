//
//  MathFloor.m
//  Calculator
//
//  Created by Thomas Redding on 10/1/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathFloor.h"

@implementation MathFloor

- (MathFloor*) init {
    self.name = @"floor";
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
            if([input[0] getDouble] >= 0) {
                [answer setDouble: floor([input[0] getDouble])];
            }
            else {
                [answer setDouble: floor([input[0] getDouble]+0.99999999999)];
            }
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
