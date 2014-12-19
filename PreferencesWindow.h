//
//  PreferencesWindow.h
//  Calculator
//
//  Created by Thomas Redding on 12/17/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "Brain.h"
#include "Preferences.h"

@interface PreferencesWindow : NSWindowController

@property Brain *brain;
@property Preferences *preferences;

@property NSButton *clearHarddriveButton;
@property NSButton *displayAxisCheckbox;

- (void) loadPreferences: (Preferences*) p;
- (void) clearHarddrive;
- (void) displayAxis;

@end
