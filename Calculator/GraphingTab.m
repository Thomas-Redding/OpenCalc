//
//  GraphingTab.m
//  Calculator
//
//  Created by Thomas Redding on 10/31/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "GraphingTab.h"

@implementation GraphingTab

- (Tab*) initWithContentViewBrainAndPreferences: (id) contentView brain: (Brain*) brain preferences: (Preferences*) preferences {
    self.contentView = contentView;
    self.brain = brain;
    self.preferences = preferences;
    
    
    self.renderDimensions = [[RenderDimensions alloc] init];
    self.renderDimensions.x = 0;
    self.renderDimensions.y = 0;
    self.renderDimensions.width = 5;
    self.renderDimensions.height = 5;
    self.steps = 40;
    
    GraphingFunction *templateA = [[GraphingFunction alloc] initWithBrain:self.brain];
    templateA.string = @"x";
    templateA.index = 0;
    [templateA update:self.renderDimensions.x-self.renderDimensions.width/2 end:self.renderDimensions.x+self.renderDimensions.width/2 steps:100];
    GraphingFunction *templateB = [[GraphingFunction alloc] initWithBrain:self.brain];
    templateB.string = @"x^2";
    templateB.index = 1;
    [templateB update:self.renderDimensions.x-self.renderDimensions.width/2 end:self.renderDimensions.x+self.renderDimensions.width/2 steps:100];
    GraphingFunction *templateC = [[GraphingFunction alloc] initWithBrain:self.brain];
    templateC.string = @"log(x)";
    templateC.index = 2;
    [templateC update:self.renderDimensions.x-self.renderDimensions.width/2 end:self.renderDimensions.x+self.renderDimensions.width/2 steps:100];
    self.formulas = [[NSMutableArray alloc] initWithObjects:templateA, templateB, templateC, nil];
    
    double width = [[self.contentView window] frame].size.width;
    double height = [[self.contentView window] frame].size.height;
    
    self.graphingView = [[GraphingView alloc] init];
    self.graphingView.functionList = self.formulas;
    self.graphingView.renderDimensions = self.renderDimensions;
    self.graphingView.preferences = self.preferences;
    [self.graphingView setFrame: NSMakeRect(100, 0, width-100, height-60)];
    [self.graphingView setAutoresizingMask: NSViewMaxXMargin | NSViewWidthSizable | NSViewHeightSizable];
    [self.graphingView setParent:self];
    
    self.currentFunction = [[NSTextField alloc] initWithFrame:NSMakeRect(0, height-60, width, 20)];
    [self.currentFunction setAutoresizingMask: NSViewWidthSizable | NSViewMinYMargin];
    [self.currentFunction setAction:@selector(submit)];
    [self.currentFunction setFocusRingType:NSFocusRingTypeNone];
    [self.currentFunction setEditable:false];
    
    // left-side table of formulas
    NSTableColumn *columnVisible = [[NSTableColumn alloc] initWithIdentifier:@"isVisible"];
    NSTableColumn *columnFormula = [[NSTableColumn alloc] initWithIdentifier:@"formula"];
    self.tableView = [[GraphingTableView alloc] initWithFrame:NSMakeRect(0, 0, 0, 0)];
    self.tableView.headerView = nil;
    self.tableView.parent = self;
    
    [[columnVisible headerCell] setStringValue:[NSString stringWithFormat:@"isvisible"]];
    [columnVisible setWidth:20];
    NSButtonCell* checkBox = [[NSButtonCell alloc] init];
    [checkBox setSelectable:true];
    [checkBox setButtonType:NSSwitchButton];
    [columnVisible setDataCell:checkBox];
    [self.tableView addTableColumn: columnVisible];
    [columnFormula setWidth:75];
    [self.tableView addTableColumn: columnFormula];
    
    [self.tableView setAllowsMultipleSelection: YES];
    self.scrollView = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 100, 100, 100)];
    [self.scrollView setDocumentView:self.tableView];
    [self.scrollView setAutoresizingMask: NSViewHeightSizable];
    [self.scrollView setBorderType:NSBezelBorder];
    
    self.tableController = [[GraphingTableController alloc] init];
    self.tableController.list = self.formulas;
    [self.tableView setDataSource: self.tableController];
    [self.tableView setDelegate:self.tableController];
    [self.tableController setParent:self];
    [self.tableView setFocusRingType:NSFocusRingTypeNone];
    
    self.addButton = [[GraphingButton alloc] initWithFrame:NSMakeRect(3, 60, 45.5, 20)];
    [self.addButton setTitle:@"+"];
    [self.addButton setTarget:self];
    [self.addButton setAction:@selector(addFunc)];
    [self.addButton setButtonType:NSMomentaryPushInButton];
    [self.addButton setBezelStyle:NSRecessedBezelStyle];
    [self.addButton setBordered:false];
    [self.addButton createTrackingArea];
    
    self.removeButton = [[GraphingButton alloc] initWithFrame:NSMakeRect(51.5, 60, 45.5, 20)];
    [self.removeButton setTitle:@"-"];
    [self.removeButton setTarget:self];
    [self.removeButton setAction:@selector(removeFunc)];
    [self.removeButton setButtonType:NSMomentaryPushInButton];
    [self.removeButton setBezelStyle:NSRecessedBezelStyle];
    [self.removeButton setBordered:false];
    [self.removeButton createTrackingArea];
    
    self.selectedRows = [[NSIndexSet alloc] init];
    self.currentFormulaBeingEdited = -1;
    
    self.shouldRedraw = true;
    
    self.mousePositionTextField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 100, 50)];
    [self.mousePositionTextField setBezeled:false];
    [self.mousePositionTextField setDrawsBackground:false];
    [self.mousePositionTextField setEditable:false];
    [self.mousePositionTextField setSelectable:true];
    
    return self;
}

- (void) open {
    [self.contentView addSubview:self.graphingView];
    [self.contentView addSubview:self.currentFunction];
    [self.contentView addSubview:self.scrollView];
    [self.contentView addSubview:self.addButton];
    [self.contentView addSubview:self.removeButton];
    [self.contentView addSubview:self.mousePositionTextField];
    
    double width = [self.contentView window].frame.size.width;
    double height = [self.contentView window].frame.size.height;
    
    [self.graphingView setFrame:NSMakeRect(100, 0, width-100, height-64)];
    [self.currentFunction setFrame:NSMakeRect(0, height-64, width, 20)];
    [self.scrollView setFrame:NSMakeRect(0, 66, 100, height-129)];
    [self.addButton setFrame:NSMakeRect(3, 44, 45.5, 20)];
    [self.removeButton setFrame:NSMakeRect(51.5, 44, 45.5, 20)];
    [self.mousePositionTextField setFrame:NSMakeRect(15, 2, 100, 40)];
    
    for(int i=0; i<self.formulas.count; i++) {
        [[self.formulas objectAtIndex:i] update:self.renderDimensions.x-self.renderDimensions.width/2 end:self.renderDimensions.x+self.renderDimensions.width/2 steps:100];
    }
    
    self.drawTimer = [NSTimer scheduledTimerWithTimeInterval:0.05f
                                                      target:self
                                                    selector:@selector(timerFired)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void) mousePositionFunc {
    //
}

- (void) timerFired {
    if(self.shouldRedraw) {
        [self recomputeAllFunctions];
        [self.graphingView drawRect:self.graphingView.frame];
    }

    double x = [self xPositionOfMouse];
    double y = [self yPositionOfMouse];
    
    [self.mousePositionTextField setStringValue:[self pairToString:x y:y]];
    
    self.shouldRedraw = false;
}

- (double) xPositionOfMouse {
    double x = ([NSEvent mouseLocation].x - [self.contentView window].frame.origin.x - self.graphingView.frame.origin.x)/self.graphingView.frame.size.width;
    return (x-0.5)*self.renderDimensions.width+self.renderDimensions.x;
}

- (double) yPositionOfMouse {
    double y = ([NSEvent mouseLocation].y - [self.contentView window].frame.origin.y - self.graphingView.frame.origin.y)/self.graphingView.frame.size.height;
    return (y-0.5)*self.renderDimensions.height+self.renderDimensions.y;
}

- (NSString*) pairToString: (double) x y: (double) y {
    NSString *xStr = [self.brain doubleToNiceString:x];
    NSString *yStr = [self.brain doubleToNiceString:y];
    if([xStr characterAtIndex:0] == '-') {
        if([yStr characterAtIndex:0] == '-') {
            return [[NSString alloc] initWithFormat:@"x:%@\ny:%@", xStr, yStr];
        }
        else {
            return [[NSString alloc] initWithFormat:@"x:%@\ny: %@", xStr, yStr];
        }
    }
    else {
        if([yStr characterAtIndex:0] == '-') {
            return [[NSString alloc] initWithFormat:@"x: %@\ny:%@", xStr, yStr];
        }
        else {
            return [[NSString alloc] initWithFormat:@"x: %@\ny: %@", xStr, yStr];
        }
    }
}

- (void) addFunc {
    [self.tableController add];
    [self.tableView reloadData];
}

- (void) removeFunc {
    [self.tableController remove:self.tableView];
    self.selectedRows = [[NSIndexSet alloc] init];
    self.currentFormulaBeingEdited = -1;
    [self.tableView reloadData];
}

- (void) close {
    [self.graphingView removeFromSuperview];
    [self.currentFunction removeFromSuperview];
    [self.scrollView removeFromSuperview];
    [self.addButton removeFromSuperview];
    [self.removeButton removeFromSuperview];
    [self.mousePositionTextField removeFromSuperview];
    
    [self.drawTimer invalidate];
    self.drawTimer = nil;
}

- (void) submit {
    if(self.currentFormulaBeingEdited != -1) {
        // update old cell being edited
        [[self.formulas objectAtIndex:self.currentFormulaBeingEdited] setString:self.currentFunction.stringValue];
        [[self.formulas objectAtIndex:self.currentFormulaBeingEdited] update:self.renderDimensions.x-self.renderDimensions.width/2 end:self.renderDimensions.x+self.renderDimensions.width/2 steps:100];
    }
    self.shouldRedraw = true;
    [self.tableView reloadData];
}

- (void) cellSelected {
    // someone selected or deselected a cell on the table
    // self.selectedRows <- old list of selected cells
    // self.tableView.selectedRowIndexes <- new list of selected cells
    
    // array of changed indices (see the function's coments for details)
    NSMutableArray *changes = [self changedIndex];
    
    int i;
    for(i=0; i<changes.count; i++) {
        if([changes objectAtIndex:i] > 0) {
            // cell 'changes[i]-1' was selected
            int index = [[changes objectAtIndex:i] intValue]-1;
            
            if(self.currentFormulaBeingEdited != -1) {
                // update old cell being edited
                [[self.formulas objectAtIndex:self.currentFormulaBeingEdited] setString:self.currentFunction.stringValue];
                [[self.formulas objectAtIndex:self.currentFormulaBeingEdited] update:self.renderDimensions.x-self.renderDimensions.width/2 end:self.renderDimensions.x+self.renderDimensions.width/2 steps:100];
            }
            
            self.currentFormulaBeingEdited = index;
            [self.currentFunction setStringValue:[[self.formulas objectAtIndex:index] string]];
            [self.currentFunction setEditable:true];
            break;
        }
    }
    
    if(i == changes.count) {
        self.currentFormulaBeingEdited = -1;
        [self.currentFunction setStringValue:@""];
        [self.currentFunction setEditable:false];
    }
    
    [self.tableView reloadData];
}

- (void) childToParentMessage: (NSString*) str {
    if([str isEqual: @"cell selected"]) {
        [self cellSelected];
    }
    else if([str isEqual: @"checkbox selected"]) {
        // checkbox selected or deselected
    }
    else if([str isEqual: @"MouseDown"]) {
        //
    }
    else if([str isEqual: @"MouseUp"]) {
        //
    }
    else if([str isEqual: @"MouseDragged"]) {
        self.shouldRedraw = true;
    }
    else if([str isEqual: @"MagnifyWithEvent"]) {
        self.shouldRedraw = true;
    }
    else if([str isEqual: @"ScrollWheel"]) {
        self.shouldRedraw = true;
    }
    else if ([str isEqual: @"evaluate"]) {
        [self openEvaluateWindow:@"evaluate"];
    }
    else if ([str isEqual: @"findRoot"]) {
        [self openEvaluateWindow:@"findRoot"];
    }
    else if ([str isEqual: @"integrate"]) {
        [self openEvaluateWindow:@"integrate"];
    }
    else if ([str isEqual: @"findIntersect"]) {
        [self openEvaluateWindow:@"findIntersect"];
    }
    else if([str isEqual: @"deleteEvaluateWindow"]) {
        self.evaluateWindow = nil;
    }
}

- (void) recomputeAllFunctions {
    for(int i=0; i<self.formulas.count; i++) {
        [[self.formulas objectAtIndex:i] update:self.renderDimensions.x-self.renderDimensions.width/2 end:self.renderDimensions.x+self.renderDimensions.width/2 steps:100];
    }
}

/*
 this function returns the indices+1 that have changed
 a negative index implies the cell was recently deselected
 a postiive index implies the cell was recently selected
*/
- (NSMutableArray*)changedIndex {
    // A = self.selectedRows
    // B = self.tableView.selectedRowIndexes
    NSMutableArray *rtn = [[NSMutableArray alloc] init];
    for(int i=0; i<self.formulas.count; i++) {
        if([self.selectedRows containsIndex:i]) {
            if([self.tableView.selectedRowIndexes containsIndex:i]) {
                // element of A and B - was selected; still is selected
                // no change
            }
            else {
                // element of A, but not B - was recently deselected
                [rtn addObject: [NSNumber numberWithInt:-1*(i+1)]];
            }
        }
        else {
            if([self.tableView.selectedRowIndexes containsIndex:i]) {
                // element of B, but not A - was recently selected
                [rtn addObject: [NSNumber numberWithInt:i+1]];
            }
            else {
                // not element of A or B - was not selected; still is not selected
                // no change
            }
        }
    }
    return rtn;
}

-(void)updateSelectedRowInfo {
    // this is a copy
    self.selectedRows = self.tableView.selectedRowIndexes;
}

- (void) mouseDown:(NSEvent *)theEvent sender: (int) sender {
    double x = [self xPositionOfMouse];
    double y = [self yPositionOfMouse];
    int index = [self.graphingView functionClicked:x y:y];
    if(index != -1) {
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:index];
        if(theEvent.modifierFlags & NSCommandKeyMask) {
            // command down
            [self.tableView selectRowIndexes:indexSet byExtendingSelection:true];
        }
        else {
            // command not down
            [self.tableView selectRowIndexes:indexSet byExtendingSelection:false];
        }
    }
}

- (void) mouseUp:(NSEvent *)theEvent {
    //
}

- (void) preferencesChanged {
    self.shouldRedraw = true;
}

- (void) openEvaluateWindow: (NSString*) str {
    NSLog(@"%@", str);
    
    self.evaluateWindow = [[GraphingEvaluateWindow alloc] initWithWindowNibName:@"GraphingEvaluateWindow"];
    self.evaluateWindow.brain = self.brain;
    self.evaluateWindow.parent = self;
    self.evaluateWindow.windowType = str;
    
    if(self.tableView.selectedRowIndexes.count == 1) {
        self.evaluateWindow.funcA = [self.formulas objectAtIndex:self.tableView.selectedRowIndexes.firstIndex];
        self.evaluateWindow.funcB = nil;
    }
    else if(self.tableView.selectedRowIndexes.count == 2) {
        
        unsigned long a = self.tableView.selectedRowIndexes.firstIndex;
        unsigned long b = self.tableView.selectedRowIndexes.lastIndex;
        
        
        self.evaluateWindow.funcA = [self.formulas objectAtIndex:self.tableView.selectedRowIndexes.firstIndex];
        self.evaluateWindow.funcB = [self.formulas objectAtIndex:self.tableView.selectedRowIndexes.lastIndex];
    }
    else {
        self.evaluateWindow.funcA = nil;
        self.evaluateWindow.funcB = nil;
    }
    
    [self.evaluateWindow showWindow:self.evaluateWindow];
}

@end
