//
//  AppDelegate.h
//  Calculator
//
//  Created by Thomas Redding on 9/28/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

// test comment #314

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>

#import "Brain.h"
#import "TabButton.h"
#import "AlgebraTab.h"
#import "GraphingTab.h"
#import "EquationEditingTab.h"
#import "PreferencesWindow.h"
#import "AppBlueprinter.h"

@interface AppDelegate : AppBlueprinter <NSApplicationDelegate>

@property (weak) IBOutlet NSView *mainView;

@property Brain *brain;
@property Preferences *preferences;

@property TabButton *algebraButton;
@property TabButton *graphingButton;
@property TabButton *equationEditingButton;

@property NSView *buttonContainer;
@property PreferencesWindow *preferencesWindow;

@property NSMutableArray *tabs;
@property int currentTab;
@property double currentWidth;
@property double currentHeight;

- (void)algebraButtonPressed;
- (void)graphingButtonPressed;
- (void)equationEditingButtonPressed;

- (void)loadVariablesAndFunctions;
- (void)saveVariablesAndFunctions;

- (IBAction)openPreferencesWindow:(id)sender;

@end