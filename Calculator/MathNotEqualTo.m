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
            [answer setDouble:0];
            return answer;
        }
        else {
            // numbers are not equal
            [answer setDouble:1];
            return answer;
        }
    }
    else if([input[0] objectType] == MATHBOOLEAN) {
        if([input[0] getDouble] == [input[0] getDouble]) {
            // booleans are equal
            [answer setDouble:0];
            return answer;
        }
        else {
            // booleans are not equal
            [answer setDouble:1];
            return answer;
        }
    }
    else if([input[0] objectType] == MATHVECTOR) {
        if([input[0] getLength] == [input[1] getLength]) {
            MathVector *vectA = input[0];
            MathVector *vectB = input[1];
            for(int i=0; i<[vectA getLength]; i++) {
                if([[self func:[[NSArray alloc] initWithObjects:[vectA getObjectAt:i], [vectB getObjectAt:i], nil]] getDouble] == 1) {
                    // vectors are not equal
                    [answer setDouble:1];
                    return answer;
                }
            }
            // vectors are equal
            [answer setDouble:0];
            return answer;
        }
        else {
            // vectors are not equal
            [answer setDouble:0];
            return answer;
        }
    }
    else if([input[0] objectType] == MATHMATRIX) {
        if([input[0] getLength] == [input[1] getLength]) {
            MathMatrix *matA = input[0];
            MathMatrix *matB = input[1];
            if(matA.width != matB.width) {
                [answer setDouble:1];
                return answer;
            }
            
            for(int i=0; i<[matA getLength]; i++) {
                if([[self func:[[NSArray alloc] initWithObjects:[matA getObjectAt:i], [matB getObjectAt:i], nil]] getDouble] == 1) {
                    // matrices are not equal
                    [answer setDouble:1];
                    return answer;
                }
            }
            
            // matrices are equal
            [answer setDouble:0];
            return answer;
        }
        else {
            // matrices are not equal
            return answer;
        }
    }
    else {
        return NULL;
    }
}

@end
