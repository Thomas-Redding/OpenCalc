//
//  MathModulo.m
//  Calculator
//
//  Created by Thomas Redding on 10/4/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathModulo.h"

@implementation MathModulo

- (MathObject*)func: (NSArray*) input {
    if([input count] != 2) {
        return NULL;
    }
    if([input[0] objectType] == MATHNUMBER && [input[0] objectType] == MATHNUMBER) {
        if([input[0] getDouble:1] == 0 && [input[1] getDouble:1] == 0) {
            // both real numbers
            long a = [input[0] getDouble];
            long b = [input[1] getDouble];
            if(a == [input[0] getDouble] && b == [input[1] getDouble]) {
                // both integers
                MathNumber *answer = [[MathNumber alloc] init];
                [answer setDouble:a%b];
                return answer;
            }
        }
    }
    return NULL;
}

@end
