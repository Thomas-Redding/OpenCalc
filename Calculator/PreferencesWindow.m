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
    
    self.drawAxisCheckbox = [[NSButton alloc] initWithFrame:NSMakeRect(10, 50, 100, 20)];
    [self.drawAxisCheckbox setTitle: @"Show Axes?"];
    [self.drawAxisCheckbox setButtonType:NSSwitchButton];
    [self.drawAxisCheckbox setTarget:self];
    [self.drawAxisCheckbox setAction:@selector(drawAxis)];
    [self.window.contentView addSubview:self.drawAxisCheckbox];
    
    self.doesScrollZoomCheckbox = [[NSButton alloc] initWithFrame:NSMakeRect(10, 90, 100, 20)];
    [self.doesScrollZoomCheckbox setTitle: @"Zoom-Scroll?"];
    [self.doesScrollZoomCheckbox setButtonType:NSSwitchButton];
    [self.doesScrollZoomCheckbox setTarget:self];
    [self.doesScrollZoomCheckbox setAction:@selector(scrollZoom)];
    [self.window.contentView addSubview:self.doesScrollZoomCheckbox];
}

- (void)loadPreferences: (Preferences*) p {
    self.preferences = p;
    
    if(self.preferences.drawAxes) {
        [self.drawAxisCheckbox setState:NSOnState];
    }
    else {
        [self.drawAxisCheckbox setState:NSOffState];
    }
    
    if(self.preferences.doesScrollZoom) {
        [self.doesScrollZoomCheckbox setState:NSOnState];
    }
    else {
        [self.doesScrollZoomCheckbox setState:NSOffState];
    }
}

- (void) clearHarddrive {
    [self.brain clearHardDriveVariables];
}

- (void) drawAxis {
    BOOL newValue = [self.drawAxisCheckbox state];
    self.preferences.drawAxes = newValue;
    [self.preferences save];
    [self.mainWindow preferencesChanged];
}

- (void) scrollZoom {
    BOOL newValue = [self.doesScrollZoomCheckbox state];
    self.preferences.doesScrollZoom = newValue;
    [self.preferences save];
    [self.mainWindow preferencesChanged];
}

@end
