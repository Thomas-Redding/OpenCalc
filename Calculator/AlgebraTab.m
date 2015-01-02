//
//  AlgebraTab.m
//  Calculator
//
//  Created by Thomas Redding on 10/2/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "AlgebraTab.h"

@implementation AlgebraTab



- (Tab*) initWithContentViewBrainAndPreferences: (id) contentView brain: (Brain*) brain preferences: (Preferences*) preferences {
    self.contentView = contentView;
    self.brain = brain;
    self.preferences = preferences;
    
    NSScrollView *scrollview = [[NSScrollView alloc] initWithFrame:NSMakeRect(0, 20, 500, 363)];
    NSSize contentSize = [scrollview contentSize];
    
    [scrollview setBorderType:NSNoBorder];
    [scrollview setHasVerticalScroller:YES];
    [scrollview setHasHorizontalScroller:YES];
    [scrollview setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
    
    NSTextView *theTextView = [[NSTextView alloc] initWithFrame:NSMakeRect(0, 0, contentSize.width, contentSize.height)];
    [theTextView setMinSize:NSMakeSize(0.0, contentSize.height)];
    [theTextView setMaxSize:NSMakeSize(FLT_MAX, FLT_MAX)];
    [theTextView setVerticallyResizable:YES];
    [theTextView setHorizontallyResizable:YES];
    [theTextView setAutoresizingMask:NSViewWidthSizable];
    [theTextView setEditable:false];
    
    [[theTextView textContainer]
     setContainerSize:NSMakeSize(contentSize.width, FLT_MAX)];
    [[theTextView textContainer] setWidthTracksTextView:YES];
    
    [scrollview setDocumentView:theTextView];
    [self.contentView addSubview:scrollview];
    [scrollview removeFromSuperview];
    [scrollview setBorderType:NSBezelBorder];
    
    self.algeabraHistoryScrollView = scrollview;
    self.algebraHistory = theTextView;
    
    self.algebraCurrent = [[CurrentAlgebraTextField alloc] initWithFrame:NSMakeRect(0, 0, 500, 20)];
    [self.algebraCurrent giveParent:self];
    [self.algebraCurrent setBordered:false];
    [self.algebraCurrent setAction:@selector(submit)];
    [self.algebraCurrent setFocusRingType:NSFocusRingTypeNone];
    
    self.currentHistoryLine = 0;
    return self;
}

- (void) open {
    [self.contentView addSubview: self.algeabraHistoryScrollView];
    [self.contentView addSubview: self.algebraCurrent];
    
    double width = [self.contentView window].frame.size.width;
    double height = [self.contentView window].frame.size.height;
    
    [self.algebraCurrent setFrame:NSMakeRect(0, 0, width, 20)];
    [self.algeabraHistoryScrollView setFrame:NSMakeRect(0, 20, width, height-64)];
}

- (void) close {
    [self.algebraCurrent removeFromSuperview];
    [self.algeabraHistoryScrollView removeFromSuperview];
}

- (void) submit {
    NSString* str = self.algebraCurrent.stringValue;
    self.algebraCurrent.stringValue = @"";
    NSMutableString *newHistory = [[NSMutableString alloc] initWithString: self.algebraHistory.string];
    [newHistory appendString:@"\n"];
    [newHistory appendString:str];
    NSString* output = [self.brain runAlgebra: str];
    if(![output isEqual: @""]) {
        [newHistory appendString:@"\n"];
    }
    
    if(output == NULL) {
        if([self.brain.errors count] > 0) {
            [newHistory appendString: self.brain.errors[[self.brain.errors count]-1]];
        }
        else {
            [newHistory appendString: @"ERROR"];
        }
    }
    else {
        [newHistory appendString:output];
    }
    
    // Smart Scrolling
    BOOL scroll = (NSMaxY(self.algebraHistory.visibleRect) == NSMaxY(self.algebraHistory.bounds));
    
    self.algebraHistory.string = newHistory;
    
    if (scroll) {
        // Scroll to end of the textview contents
        [self.algebraHistory scrollRangeToVisible: NSMakeRange(self.algebraHistory.string.length, 0)];
    }
}

- (void) childToParentMessage:(NSString *)str {
    if([str isEqual: @"moveUp"]) {
        NSArray *pastLines = [self.algebraHistory.string componentsSeparatedByString:@"\n"];
        if(self.currentHistoryLine >= 2) {
            self.currentHistoryLine -= 2;
            self.algebraCurrent.stringValue = pastLines[self.currentHistoryLine];
        }
    }
    else if([str isEqual: @"moveDown"]) {
        NSArray *pastLines = [self.algebraHistory.string componentsSeparatedByString:@"\n"];
        if(self.currentHistoryLine+2 < [pastLines count]) {
            self.currentHistoryLine += 2;
            self.algebraCurrent.stringValue = pastLines[self.currentHistoryLine];
        }
        else if(self.currentHistoryLine+2 == [pastLines count]) {
            self.algebraCurrent.stringValue = @"";
        }
    }
}

- (void) resized: (double) width height: (double) height {
    [self.algebraCurrent setFrame:NSMakeRect(0, 0, width, 20)];
}

@end
