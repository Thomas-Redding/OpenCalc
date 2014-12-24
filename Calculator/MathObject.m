//
//  MathObject.m
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathObject.h"

@implementation MathObject

- (MathObject*)init {
    return self;
}

- (NSString*)toString {
    return NULL;
}

- (double)getDouble {
    return 0;
}

- (double)getDouble: (int) index {
    return 0;
}

- (void)setDouble: (double) newValue {
}

- (void)setDouble: (int) index newValue: (double) newValue {
}

- (MathObject*)getObjectAt: (int) index {
    return nil;
}

- (MathObject*)getObjectAt: (int) row column: (int) column {
    return nil;
}

- (int) getDegreesOfFreedom {
    return 0;
}

- (unsigned long) getLength {
    return 0;
}

@end
