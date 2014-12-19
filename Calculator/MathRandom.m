//
//  MathRandom.m
//  Calculator
//
//  Created by Thomas Redding on 10/3/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathRandom.h"

@implementation MathRandom

- (MathRandom*) init {
    self.name = @"rand";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    MathNumber *answer = [[MathNumber alloc] init];
    [answer setDouble:((double)arc4random() / ARC4RANDOM_MAX)];
    return answer;
}

@end
