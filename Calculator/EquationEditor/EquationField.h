//
//  EquationField.h
//  EquationEditor
//
//  Created by Thomas Redding on 1/11/15.
//  Copyright (c) 2015 Thomas Redding. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>

#import "EquationFieldComponent.h"
#import "FontManager.h"

@interface EquationField : NSView

@property EquationFieldComponent *eq;
@property FontManager* fontManager;
@property double maxFontSize;
@property double decayExponent;
@property double decaySummation;
@property double decayDivision;
@property double decayIntegration;
@property double decayRoot;
@property double decayLog;
@property double divisionPadding;
@property double horizontalRootPadding;

@property NSTextField *cursor;
@property NSTextField *endCursor;
@property NSTimer *cursorTimer;
@property int cursorCounter;

@property int debugVar;

- (EquationField*) initWithFont: (FontManager*) f;
- (void) completeRecalculation;
- (NSString*) toLaTeX;
- (void) setBackgroundColor: (NSColor*) col;
- (NSColor*) getBackgroundColor;
- (void) deleteEquation;

@end
