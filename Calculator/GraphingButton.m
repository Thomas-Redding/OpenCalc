//
//  GraphingButton.m
//  Calculator
//
//  Created by Thomas Redding on 1/2/15.
//  Copyright (c) 2015 Thomas Redding. All rights reserved.
//

#import "GraphingButton.h"

@implementation GraphingButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)createTrackingArea
{
    NSTrackingAreaOptions focusTrackingAreaOptions = NSTrackingActiveInActiveApp;
    focusTrackingAreaOptions |= NSTrackingMouseEnteredAndExited;
    focusTrackingAreaOptions |= NSTrackingAssumeInside;
    focusTrackingAreaOptions |= NSTrackingInVisibleRect;
    
    NSTrackingArea *focusTrackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect
                                                                     options:focusTrackingAreaOptions owner:self userInfo:nil];
    [self addTrackingArea:focusTrackingArea];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    [self setBordered:true];
    [self setBezelStyle:NSRecessedBezelStyle];
}

- (void)mouseExited:(NSEvent *)theEvent {
    [self setBordered:false];
}

@end
