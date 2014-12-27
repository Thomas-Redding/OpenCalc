//
//  GraphingEvaluateWindow.m
//  Calculator
//
//  Created by Thomas Redding on 12/23/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "GraphingEvaluateWindow.h"

@interface GraphingEvaluateWindow ()

@end

@implementation GraphingEvaluateWindow

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.elements = [[NSMutableArray alloc] init];
    
    NSSize windSize = self.window.frame.size;
    
    // load gui for evaluate window
    if([self.windowType isEqual: @"evaluate"]) {
        if(self.funcA != nil & self.funcB == nil) {
            // valid inputs
            /*
             GUI
             0. Function
             1. x
             2. (inputed by user)
             3. [calculate button]
             4. y
             5. (y output)
             6. slope
             7. (slope output)
            */
            
            // 0. Function
            [self.elements addObject:[[NSTextField alloc] initWithFrame:NSMakeRect(20, windSize.height-40, windSize.width-40, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:0]];
            [[self.elements objectAtIndex:0] setStringValue:self.funcA.string];
            [[self.elements objectAtIndex:0] setEditable:false];
            [[self.elements objectAtIndex:0] setSelectable:false];
            [[self.elements objectAtIndex:0] setBezeled:false];
            [[self.elements objectAtIndex:0] setDrawsBackground:false];
            
            // 1. x
            [self.elements addObject:[[NSTextField alloc] initWithFrame:NSMakeRect(20, windSize.height-80, 40, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:1]];
            [[self.elements objectAtIndex:1] setStringValue:@"x"];
            [[self.elements objectAtIndex:1] setEditable:false];
            [[self.elements objectAtIndex:1] setSelectable:false];
            [[self.elements objectAtIndex:1] setBezeled:false];
            [[self.elements objectAtIndex:1] setDrawsBackground:false];
            
            // 2. (inputed by user)
            [self.elements addObject:[[NSTextField alloc] initWithFrame:NSMakeRect(60, windSize.height-80, windSize.width-80, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:2]];
            [[self.elements objectAtIndex:2] setStringValue:@"0"];
            [[self.elements objectAtIndex:2] setEditable:true];
            [[self.elements objectAtIndex:2] setSelectable:true];
            
            // 3. [calculate button]
            [self.elements addObject:[[NSButton alloc] initWithFrame:NSMakeRect(20, windSize.height-120, windSize.width-40, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:3]];
            [[self.elements objectAtIndex:3] setTitle:@"Calculate"];
            [[self.elements objectAtIndex:3] setAction:@selector(submit)];
            
            // 4. y
            [self.elements addObject:[[NSTextField alloc] initWithFrame:NSMakeRect(20, windSize.height-160, 40, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:4]];
            [[self.elements objectAtIndex:4] setStringValue:@"y"];
            [[self.elements objectAtIndex:4] setEditable:false];
            [[self.elements objectAtIndex:4] setSelectable:false];
            [[self.elements objectAtIndex:4] setBezeled:false];
            [[self.elements objectAtIndex:4] setDrawsBackground:false];
            
            // 5. (y output)
            [self.elements addObject:[[NSTextField alloc] initWithFrame:NSMakeRect(60, windSize.height-160, windSize.width-80, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:5]];
            [[self.elements objectAtIndex:5] setStringValue:@"1"];
            [[self.elements objectAtIndex:5] setEditable:false];
            [[self.elements objectAtIndex:5] setSelectable:false];
            [[self.elements objectAtIndex:5] setBezeled:false];
            [[self.elements objectAtIndex:5] setDrawsBackground:false];
            
            // 6. slope
            [self.elements addObject:[[NSTextField alloc] initWithFrame:NSMakeRect(20, windSize.height-200, 40, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:6]];
            [[self.elements objectAtIndex:6] setStringValue:@"slope"];
            [[self.elements objectAtIndex:6] setEditable:false];
            [[self.elements objectAtIndex:6] setSelectable:false];
            [[self.elements objectAtIndex:6] setBezeled:false];
            [[self.elements objectAtIndex:6] setDrawsBackground:false];
            
            // 7. (slope output)
            [self.elements addObject:[[NSTextField alloc] initWithFrame:NSMakeRect(60, windSize.height-200, windSize.width-80, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:7]];
            [[self.elements objectAtIndex:7] setStringValue:@"2"];
            [[self.elements objectAtIndex:7] setEditable:false];
            [[self.elements objectAtIndex:7] setSelectable:false];
            [[self.elements objectAtIndex:7] setBezeled:false];
            [[self.elements objectAtIndex:7] setDrawsBackground:false];

        }
        else {
            NSLog(@"error in GraphingEvaluateWindow (evaluate)");
        }
    }
    else if([self.windowType isEqual: @"findRoot"]) {
        if(self.funcA != nil & self.funcB == nil) {
            // valid inputs
            /*
             GUI
             0. Function
             1. x
             2. (inputed by user)
             3. [calculate button]
             4. root
             5. (root output)
            */
            
            // 0. Function
            [self.elements addObject:[[NSTextField alloc] initWithFrame:NSMakeRect(20, windSize.height-40, windSize.width-40, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:0]];
            [[self.elements objectAtIndex:0] setStringValue:self.funcA.string];
            [[self.elements objectAtIndex:0] setEditable:false];
            [[self.elements objectAtIndex:0] setSelectable:false];
            [[self.elements objectAtIndex:0] setBezeled:false];
            [[self.elements objectAtIndex:0] setDrawsBackground:false];
            
            // 1. x
            [self.elements addObject:[[NSTextField alloc] initWithFrame:NSMakeRect(20, windSize.height-80, 40, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:1]];
            [[self.elements objectAtIndex:1] setStringValue:@"x"];
            [[self.elements objectAtIndex:1] setEditable:false];
            [[self.elements objectAtIndex:1] setSelectable:false];
            [[self.elements objectAtIndex:1] setBezeled:false];
            [[self.elements objectAtIndex:1] setDrawsBackground:false];
            
            // 2. (inputed by user)
            [self.elements addObject:[[NSTextField alloc] initWithFrame:NSMakeRect(60, windSize.height-80, windSize.width-80, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:2]];
            [[self.elements objectAtIndex:2] setStringValue:@"0"];
            [[self.elements objectAtIndex:2] setEditable:true];
            [[self.elements objectAtIndex:2] setSelectable:true];
            
            // 3. [calculate button]
            [self.elements addObject:[[NSButton alloc] initWithFrame:NSMakeRect(20, windSize.height-120, windSize.width-40, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:3]];
            [[self.elements objectAtIndex:3] setTitle:@"Calculate"];
            [[self.elements objectAtIndex:3] setAction:@selector(submit)];
            
            // 4. root
            [self.elements addObject:[[NSTextField alloc] initWithFrame:NSMakeRect(20, windSize.height-160, 40, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:4]];
            [[self.elements objectAtIndex:4] setStringValue:@"root"];
            [[self.elements objectAtIndex:4] setEditable:false];
            [[self.elements objectAtIndex:4] setSelectable:false];
            [[self.elements objectAtIndex:4] setBezeled:false];
            [[self.elements objectAtIndex:4] setDrawsBackground:false];
            
            // 5. (root output)
            [self.elements addObject:[[NSTextField alloc] initWithFrame:NSMakeRect(60, windSize.height-160, windSize.width-80, 20)]];
            [self.window.contentView addSubview:[self.elements objectAtIndex:5]];
            [[self.elements objectAtIndex:5] setStringValue:@"1"];
            [[self.elements objectAtIndex:5] setEditable:false];
            [[self.elements objectAtIndex:5] setSelectable:false];
            [[self.elements objectAtIndex:5] setBezeled:false];
            [[self.elements objectAtIndex:5] setDrawsBackground:false];
        }
        else {
            NSLog(@"error in GraphingEvaluateWindow (findRoot)");
        }
    }
    else if([self.windowType isEqual: @"integrate"]) {
        if(self.funcA != nil & self.funcB == nil) {
            // valid inputs
            /*
             GUI
             0. Function
             1. x1
             2. (inputed by user)
             3. x2
             4. (inputed by user)
             5. [calculate button]
             6. area
             7. (area output)
            */
        }
        else {
            NSLog(@"error in GraphingEvaluateWindow (integrate)");
        }
    }
    else if([self.windowType isEqual: @"findIntersect"]) {
        if(self.funcA != nil & self.funcB != nil) {
            // valid inputs
            /*
             GUI
             0. Function 1
             1. Function 2
             2. x (inputed by user)
             3. [calculate button]
             4. x (intersect)
             5. y (intersect)
             */
        }
        else {
            NSLog(@"error in GraphingEvaluateWindow (findIntersect)");
        }
    }
}

- (void) windowDidResignMain:(NSNotification *)notification
{
    [self.parent childToParentMessage:@"deleteEvaluateWindow"];
}

- (void) submit {
    
    if(self.elements.count != 0) {
        // valid
        
        if([self.windowType isEqual: @"evaluate"]) {
            /*
             GUI
             0. Function
             1. x
             2. (inputed by user)
             3. [calculate button]
             4. y
             5. (y output)
             6. slope
             7. (slope output)
            */
            
            NSMutableString *string = [[NSMutableString alloc] initWithString:@"variableThatMustNotBeNamedObviouslyQuailsForever="];
            [string appendString:[[self.elements objectAtIndex:2] stringValue]];
            
            NSString *rtn = [self.brain runAlgebra:string];
            
            if(rtn == NULL) {
                [[self.elements objectAtIndex:5] setStringValue:@"undefined"];
                return;
            }
            
            MathObject* x = [self.brain getVariableValue:@"variableThatMustNotBeNamedObviouslyQuailsForever"];
            double y = [self.brain graphRun:[self.funcA getName] x:[x getDouble]];
            
            [[self.elements objectAtIndex:5] setStringValue:[[NSString alloc] initWithFormat:@"%f", y]];
            
            double slope = [self.brain findSlope:[self.funcA getName] x:[x getDouble]];
            [[self.elements objectAtIndex:7] setStringValue:[[NSString alloc] initWithFormat:@"%f", slope]];
        }
        else if([self.windowType isEqual: @"findRoot"]) {
            /*
             GUI
             0. Function
             1. x
             2. (inputed by user)
             3. [calculate button]
             4. root
             5. (root output)
            */
            
            NSMutableString *string = [[NSMutableString alloc] initWithString:@"variableThatMustNotBeNamedObviouslyQuailsForever="];
            [string appendString:[[self.elements objectAtIndex:2] stringValue]];
            
            
            NSString *rtn = [self.brain runAlgebra:string];
            if(rtn == NULL) {
                [[self.elements objectAtIndex:5] setStringValue:@"undefined"];
                return;
            }
            
            MathObject* x = [self.brain getVariableValue:@"variableThatMustNotBeNamedObviouslyQuailsForever"];
            
            double answer = [self.brain findRoot:[self.funcA getName] x:[x getDouble]];
            
            if(answer == INFINITY) {
                [[self.elements objectAtIndex:5] setStringValue:@"undefined"];
            }
            else {
                [[self.elements objectAtIndex:5] setStringValue:[[NSString alloc] initWithFormat:@"%f", answer]];
            }
        }
    }
}

@end
