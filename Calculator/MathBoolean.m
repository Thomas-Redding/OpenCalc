//
//  MathBoolean.m
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathBoolean.h"

@implementation MathBoolean

- (MathObject*)init {
    self.objectType = MATHBOOLEAN;
    
    self.value = false;
    
    return self;
}

- (NSString*)toString {
    if(self.value) {
        return @"true";
    }
    else {
        return @"false";
    }
}

- (double)getDouble {
    if(self.value) {
        return 1;
    }
    else {
        return 0;
    }
}

- (double)getDouble: (int) index {
    if(self.value) {
        return 1;
    }
    else {
        return 0;
    }
}

- (void)setDouble: (double) newValue {
    if(newValue <= 0) {
        self.value = false;
    }
    else {
        self.value = true;
    }
}

- (void)setDouble: (int) index newValue: (double) newValue {
    if(newValue <= 0) {
        self.value = false;
    }
    else {
        self.value = true;
    }
}

@end
