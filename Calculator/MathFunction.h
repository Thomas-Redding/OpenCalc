//
//  MathFunction.h
//  Calculator
//
//  Created by Thomas Redding on 9/30/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathObject.h"
#import "MathNumber.h"
#import "MathBoolean.h"
#import "MathVector.h"
#import "MathMatrix.h"

@interface MathFunction : NSObject

@property NSString* name;

- (MathFunction*) init;
- (MathObject*)func: (NSArray*) input;

@end
