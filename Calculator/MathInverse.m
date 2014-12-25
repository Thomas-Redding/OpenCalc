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
    else if([input[0] objectType] == MATHVECTOR) {
        MathVector *vect = input[0];
        MathVector *answer = [[MathVector alloc] init];
        for(int i=0; i<[vect getLength]; i++) {
            [answer addObject:[self func:[[NSArray alloc] initWithObjects:[vect getObjectAt:i], nil]]];
        }
        return answer;
    }
    else if([input[0] objectType] == MATHMATRIX) {
        MathMatrix *mat = input[0];
        MathMatrix *answer = [[MathMatrix alloc] init];
        for(int i=0; i<[mat getLength]; i++) {
            [answer addObject:[self func:[[NSArray alloc] initWithObjects:[mat getObjectAt:i], nil]]];
        }
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
