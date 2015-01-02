//
//  TabButton.h
//  Calculator
//
//  Created by Thomas Redding on 1/2/15.
//  Copyright (c) 2015 Thomas Redding. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TabButton : NSButton

- (void)createTrackingArea;
- (void)mouseEntered:(NSEvent *)theEvent;
- (void)mouseExited:(NSEvent *)theEvent;

@end
