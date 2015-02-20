//
//  EquationEditingTab.m
//  Calculator
//
//  Created by Thomas Redding on 2/20/15.
//  Copyright (c) 2015 Thomas Redding. All rights reserved.
//

#import "EquationEditingTab.h"

@implementation EquationEditingTab


- (Tab*) initWithContentViewBrainAndPreferences: (id) contentView brain: (Brain*) brain preferences: (Preferences*) preferences {
    self.contentView = contentView;
    self.brain = brain;
    self.preferences = preferences;
    return self;
}

- (void) open {
    //
}

- (void) close {
    //
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

@end
