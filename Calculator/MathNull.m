//
//  MathNull.m
//  Calculator
//
//  Created by Thomas Redding on 10/4/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathNull.h"

@implementation MathNull

- (MathNull*) init {
    self.name = @"";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    return NULL;
}

@end
