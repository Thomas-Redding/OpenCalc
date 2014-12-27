//
//  MathVariable.m
//  Calculator
//
//  Created by Thomas Redding on 9/29/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathVariable.h"

@implementation MathVariable

- (NSString*) toSaveString {
    NSString *str = @"";
    return str;
}

- (MathVariable*) copy {
    MathVariable* obj = [[MathVariable alloc] init];
    obj.name = [self.name copy];
    obj.variableValue = [self.variableValue copy];
    obj.isEditable = self.isEditable;
    obj.shouldSaveToHarddrive = self.shouldSaveToHarddrive;
    return obj;
}

@end
