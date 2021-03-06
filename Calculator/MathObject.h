//
//  MathObject.h
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathType.h"

@interface MathObject : NSObject

@property MathType objectType;

- (MathObject*)init;
- (NSString*)toString;
- (double)getDouble;
- (double)getDouble: (int) index;
- (void)setDouble: (double) newValue;
- (void)setDouble: (int) index newValue: (double) newValue;
- (int) getDegreesOfFreedom;

- (MathObject*)getObjectAt: (int) index;                        // this is for vectors
- (MathObject*)getObjectAt: (int) row column: (int) column;     // this is for matrices
- (unsigned long) getLength;                                    // this is for vectors

@end
