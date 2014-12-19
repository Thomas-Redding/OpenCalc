//
//  PreferencesWindow.m
//  Calculator
//
//  Created by Thomas Redding on 12/17/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "PreferencesWindow.h"

@interface PreferencesWindow ()

@end

@implementation PreferencesWindow

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    self.clearHarddriveButton = [[NSButton alloc] initWithFrame:NSMakeRect(10, 10, 100, 20)];
    [self.clearHarddriveButton setTitle: @"Clear Harddrive"];
    [self.clearHarddriveButton setButtonType:NSMomentaryPushInButton];
    [self.clearHarddriveButton setBezelStyle:NSSmallSquareBezelStyle];
    [self.clearHarddriveButton setTarget:self];
    [self.clearHarddriveButton setAction:@selector(clearHarddrive)];
    [self.window.contentView addSubview:self.clearHarddriveButton];
    
    self.displayAxisCheckbox = [[NSButton alloc] initWithFrame:NSMakeRect(10, 50, 100, 20)];
    [self.displayAxisCheckbox setTitle: @"Show/Hide Axes"];
    [self.displayAxisCheckbox setButtonType:NSSwitchButton];
    [self.displayAxisCheckbox setTarget:self];
    [self.displayAxisCheckbox setAction:@selector(displayAxis)];
    [self.window.contentView addSubview:self.displayAxisCheckbox];
    
    self.screenWidth = [NSScreen mainScreen].frame.size.width;
    self.screenHeight = [NSScreen mainScreen].frame.size.height;
    self.defaultWindowWidth = 300;
    self.defaultWindowHeight = 200;
    
    if(self.screenWidth > self.defaultWindowWidth && self.screenHeight > self.self.defaultWindowHeight) {
        [self.window setFrame:NSMakeRect(100, 100, 300, 200) display:true];
        [self.window setFrame:NSMakeRect((self.screenWidth-self.defaultWindowWidth)/2, (self.screenHeight-self.defaultWindowHeight)/2, self.defaultWindowWidth, self.defaultWindowHeight) display:true];
        [self.window setStyleMask:[self.window styleMask] & ~NSResizableWindowMask];
    }
    else {
        // screen isn't big enough for preferences window, quit the application
        [NSApp terminate:nil];
    }
}

- (void)loadPreferences: (Preferences*) p {
    self.preferences = p;
    [self.displayAxisCheckbox setState:self.preferences.drawAxes];
}

- (void) clearHarddrive {
    [self.brain clearHardDriveVariables];
}

- (void) displayAxis {
    NSLog(@"check");
    BOOL newValue = [self.displayAxisCheckbox state];
    self.preferences.drawAxes = newValue;
    [self.preferences save];
}

@end
