//
//  MathVariable.h
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MathObject.h"

@interface MathVariable : NSObject

@property NSString *name;
@property MathObject *variableValue;
@property bool isEditable;
@property bool shouldSaveToHarddrive;

- (NSString*) toSaveString;

@end
