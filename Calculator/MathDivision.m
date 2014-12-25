//
//  MathDivision.m
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathDivision.h"

@implementation MathDivision

- (MathObject*)func: (NSArray*) input {
    if([input count] != 2) {
        return NULL;
    }
    if([input[0] objectType] == MATHNUMBER && [input[1] objectType] == MATHNUMBER) {
        double a = [input[0] getDouble:0];
        double b = [input[0] getDouble:1];
        double c = [input[1] getDouble:0];
        double d = [input[1] getDouble:1];
        double denominator = c*c+d*d;
        if(denominator == 0) {
            return NULL;
        }
        MathNumber *answer = [[MathNumber alloc] init];
        [answer setDouble:0 newValue: (a*c+b*d)/denominator];
        [answer setDouble:1 newValue: (b*c-a*d)/denominator];
        return answer;
    }
    else if([input[0] objectType] == MATHVECTOR && [input[1] objectType] == MATHNUMBER) {
        MathVector *vect = input[0];
        MathNumber *k = input[1];
        MathVector *answer = [[MathVector alloc] init];
        for(int i=0; i<[vect getLength]; i++) {
            [answer addObject:[self func:[[NSArray alloc] initWithObjects:[vect getObjectAt:i], k, nil]]];
        }
        return answer;
    }
    else if([input[0] objectType] == MATHMATRIX && [input[1] objectType] == MATHNUMBER) {
        MathMatrix *mat = input[0];
        MathNumber *k = input[1];
        MathMatrix *answer = [[MathMatrix alloc] init];
        answer.width = mat.width;
        for(int i=0; i<[mat getLength]; i++) {
            [answer addObject:[self func:[[NSArray alloc] initWithObjects:[mat getObjectAt:i], k, nil]]];
        }
        return answer;
    }
    else {
        return NULL;
    }
}

@end
