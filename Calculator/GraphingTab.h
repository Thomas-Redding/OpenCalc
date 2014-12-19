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

@interface GraphingTab : Tab

// @property Preferences *preferences;

@property GraphingView *graphingView;
@property NSTextField *currentFunction;
@property GraphingTableController *tableController;
@property NSTableView *tableView;
@property NSScrollView *scrollView;
@property NSMutableArray *formulas;
@property NSIndexSet *selectedRows;
@property int currentFormulaBeingEdited;

@property NSButton *addButton;
@property NSButton *removeButton;

@property double x;
@property double y;
@property double width;
@property double height;
@property int steps;

- (void) addFunc;
- (void) removeFunc;

@end
