//
//  GraphingFunction.h
//  Calculator
//
//  Created by Thomas Redding on 12/16/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Brain.h"

@interface GraphingFunction : NSObject

@property NSString *string;         // this function in string-form
@property Boolean isVisible;        // should this function be graphed?
@property Brain *brain;             // the global brain
@property unsigned long index;      // my index in GraphingTab's formulas
@property unichar type;

// x1, y1, continuous1, x2, y2, continuous2, ...
// units are not OpenGL coordinates - they are strictly Cartesian
@property NSMutableArray *points;

- (GraphingFunction*) initWithBrain: (Brain*) b;
- (void) update: (double) start end: (double) end steps: (int) steps;

@end
