//
//  GraphingTab.h
//  Calculator
//
//  Created by Thomas Redding on 10/31/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "Tab.h"
#import "GraphingView.h"
#import "GraphingTableController.h"
#import "GraphingFunction.h"
#import "RenderDimensions.h"

@interface GraphingTab : Tab

// @property Preferences *preferences;

@property GraphingView *graphingView;
@property NSTextField *currentFunction;
@property NSTextField *mousePositionTextField;
@property GraphingTableController *tableController;
@property NSTableView *tableView;
@property NSScrollView *scrollView;
@property NSMutableArray *formulas;
@property NSIndexSet *selectedRows;
@property int currentFormulaBeingEdited;

@property NSButton *addButton;
@property NSButton *removeButton;

@property RenderDimensions *renderDimensions;

@property int steps;

@property NSTimer *drawTimer;
@property BOOL shouldRedraw;

- (void) addFunc;
- (void) removeFunc;
- (void) timerFired;
- (void) recomputeAllFunctions;

@end
