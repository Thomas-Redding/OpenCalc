//
//  MathInverse.m
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathInverse.h"

@implementation MathInverse

- (MathObject*)func: (NSArray*) input {
    if([input count] != 1) {
        return NULL;
    }
    if([input[0] objectType] == MATHNUMBER) {
        MathNumber *answer = [[MathNumber alloc] init];
        [answer setDouble:-1*[input[0] getDouble]];
        [answer setDouble:1 newValue:[input[0] getDouble:1]];
        return answer;
    }
    else if([input[0] objectType] == MATHBOOLEAN) {
        MathBoolean *answer = [[MathBoolean alloc] init];
        if([input[0] getDouble] == 1) {
            [answer setDouble:0];
        }
        else {
            [answer setDouble:0];
        }
        return answer;
    }
    return NULL;
}

@end
