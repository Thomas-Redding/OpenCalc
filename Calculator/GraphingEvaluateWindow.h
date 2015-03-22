//
//  GraphingEvaluateWindow.h
//  Calculator
//
//  Created by Thomas Redding on 12/23/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Brain.h"
#import "Tab.h"
#import "GraphingFunction.h"
#import "RenderDimensions.h"

@interface GraphingEvaluateWindow : NSWindowController

@property Brain *brain;
@property Tab *parent;
@property GraphingFunction *funcA;
@property GraphingFunction *funcB;
@property NSString *windowType;     // evaluate, findRoot, integrate, findIntersect
@property NSMutableArray *elements;
@property RenderDimensions *renderDimensions;

@end
