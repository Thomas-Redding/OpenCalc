//
//  MathNumber.m
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathNumber.h"

@implementation MathNumber

- (MathObject*)init {
    self.objectType = MATHNUMBER;
    
    self.real = 0;
    self.imaginary = 0;
    
    return self;
}

- (NSString*)toString {
    if(self.imaginary == 0) {
        if(self.real == (long)self.real) {
            // integer
            return [NSString stringWithFormat: @"%ld", (long) self.real];
        }
        else {
            // long
            return [NSString stringWithFormat: @"%f", self.real];
        }
    }
    else if(self.real == 0) {
        if(self.imaginary == (long)self.imaginary) {
            // integer
            return [NSString stringWithFormat: @"%ldi", (long) self.imaginary];
        }
        else {
            // long
            return [NSString stringWithFormat: @"%fi", self.imaginary];
        }
    }
    else {
        if(self.real == (long)self.real) {
            // real = integer
            if(self.imaginary == (long)self.imaginary) {
                // imaginary = integer
                return [NSString stringWithFormat: @"%ld+%ldi", (long) self.real, (long) self.imaginary];
            }
            else {
                // imaginary = double
                return [NSString stringWithFormat: @"%ld+%fi", (long) self.real, self.imaginary];
            }
        }
        else {
            // real = double
            if(self.imaginary == (long)self.imaginary) {
                // imaginary = integer
                return [NSString stringWithFormat: @"%f+%ldi", self.real, (long) self.imaginary];
            }
            else {
                // imaginary = double
                return [NSString stringWithFormat: @"%f+%fi", self.real, self.imaginary];
            }
        }
    }
}

- (double)getDouble {
    return self.real;
}

- (double)getDouble: (int) index {
    if(index == 1) {
        return self.imaginary;
    }
    else {
        return self.real;
    }
}

- (void)setDouble: (double) newValue {
    self.real = newValue;
}

- (void)setDouble: (int) index newValue: (double) newValue {
    if(index == 1) {
        self.imaginary = newValue;
    }
    else {
        self.real = newValue;
    }
}

- (int) getDegreesOfFreedom {
    return 2;
}

@end
