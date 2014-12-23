//
//  MathVector.h
//  Calculator
//
//  Created by Thomas Redding on 12/23/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathObject.h"

@interface MathVector : MathObject

@property NSMutableArray *arr;
@property NSMutableArray *degreesOfFreedom;     // cumulative measure of degrees of freedom [number, number, boolean, boolean] -> [2, 4, 5, 6]

@end
