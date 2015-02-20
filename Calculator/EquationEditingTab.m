//
//  EquationEditingTab.m
//  Calculator
//
//  Created by Thomas Redding on 2/20/15.
//  Copyright (c) 2015 Thomas Redding. All rights reserved.
//

#import "EquationEditingTab.h"

@implementation EquationEditingTab

double oldWidth = -1;
double oldHeight = -1;
BOOL isOpen = false;

- (Tab*) initWithContentViewBrainAndPreferences: (NSWindow*) window brain: (Brain*) brain preferences: (Preferences*) preferences {
    self.contentView = window.contentView;
    self.brain = brain;
    self.preferences = preferences;
    self.window = window;
    
    double width = [[self.contentView window] frame].size.width;
    double height = [[self.contentView window] frame].size.height;
    self.fontManager = [[FontManager alloc] init];
    self.eqField = [[EquationField alloc] initWithFont:self.fontManager];
    self.eqField.frame = NSMakeRect(0, 0, width, height-20);
    
    [self.eqField setAutoresizingMask: NSViewMaxXMargin | NSViewWidthSizable | NSViewHeightSizable];
    
    return self;
}

- (void) open {
    isOpen = true;
    [self.contentView addSubview:self.eqField];
    [self.window makeFirstResponder:self.eqField];
    [self autoRedraw];
}

- (void) close {
    isOpen = false;
    [self.eqField removeFromSuperview];
}

- (void) submit {
    //
}

- (void) childToParentMessage: (NSString*) str {
}

- (void)mouseDown:(NSEvent *)theEvent sender: (int) sender {
    //
}

- (void) mouseUp:(NSEvent *)theEvent {
    //
}

- (void) preferencesChanged {
    //
}

- (void) resized: (double) width height: (double) height {
    [self.eqField completeRecalculation];
}

- (void) autoRedraw {
    if(isOpen) {
        if(self.eqField.frame.size.width != oldWidth || self.eqField.frame.size.height != oldHeight) {
            oldWidth = self.eqField.frame.size.width;
            oldHeight = self.eqField.frame.size.height;
            [self.eqField completeRecalculation];
        }
        [self performSelector:@selector(autoRedraw) withObject:nil afterDelay:0.1];
    }
}

@end
