//
//  PreferencesWindow.h
//  Calculator
//
//  Created by Thomas Redding on 12/17/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Brain.h"
#import "Preferences.h"
#import "AppBlueprinter.h"

@interface PreferencesWindow : NSWindowController

@property Brain *brain;
@property Preferences *preferences;
@property AppBlueprinter *mainWindow;

@property NSButton *clearHarddriveButton;
@property NSButton *drawAxisCheckbox;
@property NSButton *doesScrollZoomCheckbox;

- (void) loadPreferences: (Preferences*) p;
- (void) clearHarddrive;
- (void) drawAxis;
- (void) scrollZoom;

@end
