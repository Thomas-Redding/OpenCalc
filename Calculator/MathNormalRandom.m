//
//  MathNormalRandom.m
//  Calculator
//
//  Created by Thomas Redding on 11/5/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathNormalRandom.h"

@implementation MathNormalRandom

- (MathNormalRandom*) init {
    self.name = @"rnorm";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] == 0) {
        double x = [self standardNorm];
        
        MathNumber *answer = [[MathNumber alloc] init];
        [answer setDouble:x];
        return answer;
    }
    else if([input count] == 2) {
        double mean = [input[0] getDouble];
        double sigma = [input[1] getDouble];
        
        double x = mean+sigma*[self standardNorm];
        
        MathNumber *answer = [[MathNumber alloc] init];
        [answer setDouble:x];
        return answer;
    }
    else {
        return NULL;
    }
}

- (double) standardNorm {
    double rtn = ((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX) - 6;
    rtn += ((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX) - 6;
    rtn += ((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX) - 6;
    rtn += ((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX)+((double)arc4random() / ARC4RANDOM_MAX) - 6;
    return rtn/2;
}

@end
