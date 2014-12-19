//
//  CurrentAlgebraTextField.h
//  Calculator
//
//  Created by Thomas Redding on 10/3/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "Tab.h"

@interface CurrentAlgebraTextField : NSTextField

@property Tab *parent;

- (void) giveParent: (Tab*) parent;

@end
