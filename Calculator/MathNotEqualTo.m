//
//  MathNotEqualTo.m
//  Calculator
//
//  Created by Thomas Redding on 10/6/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathNotEqualTo.h"

@implementation MathNotEqualTo

- (MathObject*)func: (NSArray*) input {
    if([input count] != 2) {
        return NULL;
    }
    MathBoolean *answer = [[MathBoolean alloc] init];
    if([input[0] objectType] != [input[1] objectType]) {
        // different types --> not equal
        [answer setDouble:1];
        return answer;
    }
    if([input[0] objectType] == MATHNUMBER) {
        // equality of numbers
        if([input[0] getDouble:0] == [input[1] getDouble:0] && [input[0] getDouble:1] == [input[1] getDouble:1]) {
            // numbers are equal
            return answer;
        }
        else {
            // numbers are not equal
            [answer setDouble:1];
            return answer;
        }
    }
    else if([input[0] objectType] == MATHBOOLEAN) {
        if([input[0] getDouble] != [input[0] getDouble]) {
            // booleans are equal
            [answer setDouble:1];
            return answer;
        }
        else {
            // booleans are not equal
            return answer;
        }
    }
    else {
        return NULL;
    }
}

@end
