//
//  MathLessThan.m
//  Calculator
//
//  Created by Thomas Redding on 10/6/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathLessThan.h"

@implementation MathLessThan

- (MathObject*)func: (NSArray*) input {
    if([input count] != 2) {
        return NULL;
    }
    MathBoolean *answer = [[MathBoolean alloc] init];
    if([input[0] objectType] != [input[1] objectType]) {
        // different types --> not equal
        return answer;
    }
    if([input[0] objectType] == MATHNUMBER) {
        if([input[0] getDouble:0] < [input[1] getDouble:0]) {
            [answer setDouble:1];
            return answer;
        }
        else {
            return answer;
        }
    }
    else if([input[0] objectType] == MATHBOOLEAN) {
        return NULL;
    }
    else {
        return NULL;
    }
}

@end
