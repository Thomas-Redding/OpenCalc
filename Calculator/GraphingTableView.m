//
//  GraphingTableView.m
//  Calculator
//
//  Created by Thomas Redding on 12/23/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "GraphingTableView.h"

@implementation GraphingTableView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void) rightMouseDown: (NSEvent*) theEvent {
    NSMenu *theMenu = [[NSMenu alloc] initWithTitle:@"Contextual Menu"];
    [theMenu insertItemWithTitle:@"Evaluate" action:@selector(evaluate) keyEquivalent:@"" atIndex:0];
    [theMenu insertItemWithTitle:@"FindRoot" action:@selector(findRoot) keyEquivalent:@"" atIndex:0];
    [theMenu insertItemWithTitle:@"Integrate" action:@selector(integrate) keyEquivalent:@"" atIndex:1];
    [theMenu insertItemWithTitle:@"FindIntersect" action:@selector(findIntersect) keyEquivalent:@"" atIndex:0];
    
    [NSMenu popUpContextMenu:theMenu withEvent:theEvent forView:self];
}

- (void) evaluate {
    [self.parent childToParentMessage:@"evaluate"];
}

- (void) findRoot {
    [self.parent childToParentMessage:@"findRoot"];
}

- (void) integrate {
    [self.parent childToParentMessage:@"integrate"];
}

- (void) findIntersect {
    [self.parent childToParentMessage:@"findIntersect"];
}

- (void)mouseUp:(NSEvent *)theEvent {
    [self.parent mouseUp: theEvent];
    [self.parent childToParentMessage:@"MouseUp"];
}

@end
