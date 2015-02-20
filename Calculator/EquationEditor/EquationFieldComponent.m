//
//  EquationFieldComponent.m
//  EquationEditor
//
//  Created by Thomas Redding on 1/16/15.
//  Copyright (c) 2015 Thomas Redding. All rights reserved.
//

#import "EquationFieldComponent.h"

@implementation EquationFieldComponent

NSString *content;

- (EquationFieldComponent*) init {
    self.eqFormat = LEAF;
    self.eqChildren = [[NSMutableArray alloc] init];
    self.eqTextField = [[NSTextField alloc] init];
    [self.eqTextField setEditable:false];
    [self.eqTextField setBordered:false];
    [self.eqTextField setDrawsBackground:false];
    [self.eqTextField setFocusRingType:NSFocusRingTypeNone];
    [self.eqTextField setAllowsEditingTextAttributes:true];
    
    self.childWithStartCursor = -1;
    self.childWithEndCursor = -1;
    self.startCursorLocation = -1;
    self.endCursorLocation = -1;
    
    return self;
}

- (void) giveNewTextField {
    [self.eqTextField removeFromSuperview];
    self.eqTextField = [[NSTextField alloc] init];
    [self.eqTextField setEditable:true];
    [self.eqTextField setBordered:false];
    [self.eqTextField setDrawsBackground:false];
    [self.eqTextField setFocusRingType:NSFocusRingTypeNone];
    [self.eqTextField setAllowsEditingTextAttributes:true];
}

@end
