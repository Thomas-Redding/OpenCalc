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
            [[self.elements objectAtIndex:4] setStringValue:@"y"];
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
            
            NSString *x = [self.brain runAlgebra:[[self.elements objectAtIndex:2] stringValue]];
            NSString *y = [self.brain runAlgebra:[[NSString alloc] initWithFormat:@"%@(%@)", [self.funcA getName], x]];
            if(y != nil) {
                [[self.elements objectAtIndex:5] setStringValue:y];
            }
            else {
                [[self.elements objectAtIndex:5] setStringValue:@"undefined"];
            }
            
            NSString *h = @"0.001";
            NSString *y1 = [self.brain runAlgebra:[[NSString alloc] initWithFormat:@"%@(%@-%@)", [self.funcA getName], x, h]];
            NSString *y2 = [self.brain runAlgebra:[[NSString alloc] initWithFormat:@"%@(%@+%@)", [self.funcA getName], x, h]];
            if(y1 != nil && y2 != nil) {
                NSString *limit = [[NSString alloc] initWithFormat:@"(%@-%@)/(%@)/2", y2, y1, h];
                NSString *slope = [self.brain runAlgebra:limit];
                [[self.elements objectAtIndex:7] setStringValue:slope];
            }
            else {
                [[self.elements objectAtIndex:7] setStringValue:@"undefined"];
            }
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
            
            NSString *x = [self.brain runAlgebra:[[self.elements objectAtIndex:2] stringValue]];
            NSString *y, *h, *y1, *y2, *limit, *slope;
            for(int i=0; i<20; i++) {
                    y = [self.brain runAlgebra:[[NSString alloc] initWithFormat:@"%@(%@)", [self.funcA getName], x]];
                    h = @"0.001";
                    y1 = [self.brain runAlgebra:[[NSString alloc] initWithFormat:@"%@(%@-%@)", [self.funcA getName], x, h]];
                    y2 = [self.brain runAlgebra:[[NSString alloc] initWithFormat:@"%@(%@+%@)", [self.funcA getName], x, h]];
                if(y1 != nil && y2 != nil && y != nil) {
                    limit = [[NSString alloc] initWithFormat:@"(%@-%@)/(%@)/2", y2, y1, h];
                    slope = [self.brain runAlgebra:limit];
                    x = [self.brain runAlgebra:[[NSString alloc] initWithFormat:@"%@-(%@)/(%@)", x, y, slope]];
                    if(x == nil) {
                        x = @"undefined";
                        break;
                    }
                }
                else {
                    x = @"undefined";
                    break;
                }
            }
            [[self.elements objectAtIndex:5] setStringValue:x];
        }
    }
}

@end
