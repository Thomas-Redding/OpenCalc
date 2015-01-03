//
//  AppDelegate.m
//  Calculator
//
//  Created by Thomas Redding on 9/28/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.currentWidth = 0;
    self.currentHeight = 0;
    self.currentTab = -1;
    
    self.brain = [[Brain alloc] init];
    self.tabs = [[NSMutableArray alloc] init];
    self.preferences = [[Preferences alloc] init];
    
    double width = self.window.frame.size.width;
    double height = self.window.frame.size.height;
    
    self.buttonContainer = [[NSView alloc] initWithFrame:NSMakeRect(0, height-46, width, 26)];
    // [self.buttonContainer ];
    
    self.algebraButton = [[TabButton alloc] initWithFrame:NSMakeRect(3, 3, 100, 20)];
    [self.buttonContainer addSubview: self.algebraButton];
    [self.algebraButton setTitle: @"Algebra"];
    [self.algebraButton setButtonType:NSMomentaryPushInButton];
    [self.algebraButton setBezelStyle:NSRecessedBezelStyle];
    [self.algebraButton setBordered:false];
    [self.algebraButton setTarget:self];
    [self.algebraButton setAction:@selector(algebraButtonPressed)];
    [self.algebraButton createTrackingArea];
    [self.tabs addObject:[[AlgebraTab alloc] initWithContentViewBrainAndPreferences:self.window.contentView brain:self.brain preferences:self.preferences]];
    
    self.graphingButton = [[TabButton alloc] initWithFrame:NSMakeRect(106, 3, 100, 20)];
    [self.buttonContainer addSubview: self.graphingButton];
    [self.graphingButton setTitle: @"Graphing"];
    [self.graphingButton setButtonType:NSMomentaryPushInButton];
    [self.graphingButton setBezelStyle:NSRecessedBezelStyle];
    [self.graphingButton setBordered:false];
    [self.graphingButton setTarget:self];
    [self.graphingButton setAction:@selector(graphingButtonPressed)];
    [self.graphingButton createTrackingArea];
    [self.tabs addObject:[[GraphingTab alloc] initWithContentViewBrainAndPreferences:self.window.contentView brain:self.brain preferences:self.preferences]];
    
    [self.window.contentView addSubview:self.buttonContainer];
    [self.buttonContainer setAutoresizingMask: NSViewMinYMargin];
    
    [self algebraButtonPressed];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)algebraButtonPressed {
    if(self.currentTab != -1) {
        [self.tabs[self.currentTab] close];
    }
    self.currentTab = 0;
    [self.tabs[self.currentTab] open];
}

- (void)graphingButtonPressed {
    if(self.currentTab != -1) {
        [self.tabs[self.currentTab] close];
    }
    self.currentTab = 1;
    [self.tabs[self.currentTab] open];
}

- (void)submit {
    [self.tabs[self.currentTab] submit];
}

- (void)loadVariablesAndFunctions {
    [self.brain loadVariablesAndFunctions];
}

- (void)saveVariablesAndFunctions {
    [self.brain saveVariablesAndFunctions];
}

- (IBAction)openPreferencesWindow:(id)sender {
    self.preferencesWindow = [[PreferencesWindow alloc] initWithWindowNibName:@"PreferencesWindow"];
    self.preferencesWindow.brain = self.brain;
    self.preferencesWindow.mainWindow = self;
    [self.preferencesWindow showWindow:self.preferencesWindow];
    [self.preferencesWindow loadPreferences:self.preferences];
}

- (void) preferencesChanged {
    if(self.currentTab != -1) {
        [self.tabs[self.currentTab] preferencesChanged];
    }
}

@end
