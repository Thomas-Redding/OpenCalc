//
//  Tab.m
//  Calculator
//
//  Created by Thomas Redding on 10/2/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "Tab.h"

@implementation Tab

/*
 This method is called when the application is opened
  - create any GUI elements you want to be persistent, but do NOT add them to contentView
  - make sure to save contentView, brain, and preferences
*/
- (Tab*) initWithContentViewBrainAndPreferences: (id) contentView brain: (Brain*) brain preferences: (Preferences*) preferences {
    return self;
}

/*
 This method is called when this tab is opened
  - add GUI elements to contentView
*/
- (void) open {
    //
}

/*
 This method is called when this tab is closed
  - remove GUI elements from contentView
*/
- (void) close {
    //
}

- (void) submit {
    //
}

/*
 This method is a template that the tab can use to receive messages from its GUI elements
 For instance, when someone clicks the up-arrow in the Algebra Tab, the currentAlgebra NSTextField
 sends a message to AlgeabraTab
 
 EXAMPLE: [self.parent childToParentMessage:@"moveUp"];
*/
- (void) childToParentMessage: (NSString*) str {
    //
}

/*
 This method is called by the Tab's children when they are clicked;
 This call must be implemented by the programmer in the child
 
 [self.parent mouseDown:theEvent sender:self.index];
*/
- (void)mouseDown:(NSEvent *)theEvent sender: (int) sender {
    //
}

/*
 This method is called by the Tab's children when they are clicked and then released;
 This call must be implemented by the programmer in the child
 
 [self.parent mouseUp:theEvent sender:self.index];
*/
- (void) mouseUp:(NSEvent *)theEvent {
    //
}

@end
