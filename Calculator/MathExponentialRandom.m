//
//  MathExponentialRandom.m
//  Calculator
//
//  Created by Thomas Redding on 11/5/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathExponentialRandom.h"

@implementation MathExponentialRandom

- (MathExponentialRandom*) init {
    self.name = @"rexp";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] != 1) {
        return NULL;
    }
    else {
        double lambda = [input[0] getDouble];
        double x = log(((double)arc4random() / ARC4RANDOM_MAX))/lambda/-1;
        MathNumber *answer = [[MathNumber alloc] init];
        [answer setDouble:x];
        return answer;
    }
}

@end
