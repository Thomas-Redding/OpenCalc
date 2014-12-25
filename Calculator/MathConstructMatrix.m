//
//  MathConstructMatrix.m
//  Calculator
//
//  Created by Thomas Redding on 12/24/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathConstructMatrix.h"

@implementation MathConstructMatrix

- (MathConstructMatrix*) init {
    self.name = @"Mat";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if(input.count < 2) {
        return NULL;
    }
    if([input[0] objectType] != MATHNUMBER || [input[1] objectType] != MATHNUMBER) {
        // non-numeric dimensions
        return NULL;
    }
    if([input[0] getDouble:1] != 0 || [input[1] getDouble:1] != 0) {
        // complex dimensions
        return NULL;
    }
    if([input[0] getDouble]*[input[1] getDouble] != input.count-2) {
        // insufficient arguments
        return NULL;
    }
    MathMatrix *answer = [[MathMatrix alloc] init];
    answer.width = [input[0] getDouble];
    for(int i=2; i<input.count; i++) {
        [answer addObject:input[i]];
    }
    return answer;
}


@end
