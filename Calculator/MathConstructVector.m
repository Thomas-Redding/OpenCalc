//
//  MathConstructVector.m
//  Calculator
//
//  Created by Thomas Redding on 12/23/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathConstructVector.h"

@implementation MathConstructVector

- (MathConstructVector*) init {
    self.name = @"Vect";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if(input.count == 0) {
        return NULL;
    }
    MathVector *answer = [[MathVector alloc] init];
    for(int i=0; i<input.count; i++) {
        if([input[i] objectType] == MATHBOOLEAN || [input[i] objectType] == MATHNUMBER || [input[i] objectType] == MATHVECTOR) {
            [answer addObject:input[i]];
        }
    }
    return answer;
}

@end
