//
//  MathMultiplication.m
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathMultiplication.h"

@implementation MathMultiplication

- (MathObject*)func: (NSArray*) input {
    if([input count] != 2) {
        return NULL;
    }
    if([input[0] objectType] == MATHNUMBER && [input[1] objectType] == MATHNUMBER) {
        double a = [input[0] getDouble:0];
        double b = [input[0] getDouble:1];
        double c = [input[1] getDouble:0];
        double d = [input[1] getDouble:1];
        MathNumber *answer = [[MathNumber alloc] init];
        [answer setDouble:0 newValue: a*c-b*d];
        [answer setDouble:1 newValue: a*d+b*c];
        return answer;
    }
    else if([input[0] objectType] == MATHNUMBER && [input[1] objectType] == MATHVECTOR) {
        MathNumber *k = input[0];
        MathVector *vect = input[1];
        MathVector *answer = [[MathVector alloc] init];
        for(int i=0; i<[vect getLength]; i++) {
            [answer addObject:[self func:[[NSArray alloc] initWithObjects:k, [vect getObjectAt:i], nil]]];
        }
        return answer;
    }
    else if([input[0] objectType] == MATHVECTOR && [input[1] objectType] == MATHNUMBER) {
        MathNumber *k = input[1];
        MathVector *vect = input[0];
        MathVector *answer = [[MathVector alloc] init];
        for(int i=0; i<[vect getLength]; i++) {
            [answer addObject:[self func:[[NSArray alloc] initWithObjects:k, [vect getObjectAt:i], nil]]];
        }
        return answer;
    }
    else {
        return NULL;
    }
}

@end
