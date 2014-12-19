//
//  Tab.h
//  Calculator
//
//  Created by Thomas Redding on 10/2/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MathFunction.h"
#import "Brain.h"
#import "Preferences.h"

@interface Tab : NSObject

@property id contentView;
@property Brain *brain;
@property Preferences *preferences;

- (Tab*) initWithContentViewBrainAndPreferences: (id) contentView brain: (Brain*) brain preferences: (Preferences*) preferences;
- (void) open;
- (void) close;
- (void) submit;
- (void) childToParentMessage: (NSString*) str;
- (void) mouseDown:(NSEvent *)theEvent sender: (int) sender;
- (void) mouseUp:(NSEvent *)theEvent;

@end
