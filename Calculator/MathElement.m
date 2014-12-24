//
//  MathElement.m
//  Calculator
//
//  Created by Thomas Redding on 12/24/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathElement.h"

@implementation MathElement

- (MathElement*) init {
    self.name = @"element";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if(input.count <= 1) {
        return NULL;
    }
    
    if([input[0] objectType] == MATHVECTOR) {
        MathVector *vect = input[0];
        if(input.count == 2) {
            int index = [input[1] getDouble];
            MathObject *answer = [vect getObjectAt:index];
            return answer;
        }
        else {
            MathVector *answer = [[MathVector alloc] init];
            for(int i=1; i<input.count; i++) {
                int index = [input[i] getDouble];
                [answer addObject:[vect getObjectAt:index]];
            }
            return answer;
        }
    }
    
    return NULL;
}


@end
