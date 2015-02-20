//
//  EquationFieldComponent.h
//  EquationEditor
//
//  Created by Thomas Redding on 1/16/15.
//  Copyright (c) 2015 Thomas Redding. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EquationFieldComponentType.h"

@interface EquationFieldComponent : NSObject

@property double x;
@property double y;
@property double width;
@property double heightBelow;
@property double heightAbove;
@property double ratio;

@property int childWithStartCursor;
@property int childWithEndCursor;
@property int startCursorLocation;
@property int endCursorLocation;

@property EquationFieldComponentType eqFormat;
@property NSTextField* eqTextField;
@property NSImageView* eqImageView;

/*
 - LEAF: No children
 - NORMAL: Children from left (0) to right (infinity)
 - DIVISION: Children from top (0) to bottom (1)
*/
@property NSMutableArray *eqChildren;

- (void) giveNewTextField;

@end
