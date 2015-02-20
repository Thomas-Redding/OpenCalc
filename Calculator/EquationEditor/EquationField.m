//
//  EquationField.m
//  EquationEditor
//
//  Created by Thomas Redding on 1/11/15.
//  Copyright (c) 2015 Thomas Redding. All rights reserved.
//

/*
 TODO
 - add "d"x to integral
 - add undo/redo
 - add highlighting
*/

#import "EquationField.h"

@implementation EquationField

/* INTERFACE FUNCTIONS */

- (EquationField*) initWithFont: (FontManager*) f {
    self = [super init];
    
    self.debugVar = 0;
    
    self.fontManager = f;
    self.maxFontSize = 80;
    
    self.decayDivision = 0.8;
    self.decayExponent = 0.8;
    self.decayIntegration = 0.8;
    self.decaySummation = 0.8;
    self.decayLog = 0.8;
    self.decayRoot = 1;
    self.divisionPadding = 0.03;
    self.horizontalRootPadding = 0.5;
    
    NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:self.maxFontSize]};
    
    self.eq = [[EquationFieldComponent alloc] init];
    self.eq.eqFormat = NORMAL;
    [self.eq.eqChildren addObject:[[EquationFieldComponent alloc] init]];
    [self.eq.eqChildren[0] setEqFormat: LEAF];
    [self.eq.eqChildren[0] eqTextField].attributedStringValue = [[NSAttributedString alloc] initWithString:@"5x+3-" attributes:attr];
    
    
    
    [self.eq.eqChildren addObject:[[EquationFieldComponent alloc] init]];
    [self.eq.eqChildren[1] setEqFormat: DIVISION];
    
    
    
    [[self.eq.eqChildren[1] eqChildren] addObject: [[EquationFieldComponent alloc] init]];
    [[self.eq.eqChildren[1] eqChildren][0] setEqFormat:NORMAL];
    
    NSString *pathToRootImage = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForImageResource:@"root.png"]];
    NSImageView *rootImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 50, 50)];
    NSImage *rootImage = [[NSImage alloc] initWithContentsOfFile:pathToRootImage];
    [rootImageView setImage:rootImage];
    [[[self.eq.eqChildren[1] eqChildren][0] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] setEqFormat:SQUAREROOT];
    [[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] setEqImageView:rootImageView];
    [[[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] eqChildren][0] setEqFormat:NORMAL];
    [[[[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] eqChildren][0] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] eqChildren][0] eqChildren][0] setEqFormat:LEAF];
    [[[[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] eqChildren][0] eqChildren][0] eqTextField].attributedStringValue = [[NSAttributedString alloc] initWithString:@"1-y+" attributes:attr];
    
    [[[[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] eqChildren][0] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] eqChildren][0] eqChildren][1] setEqFormat:LOGBASE];
    
    [[[[[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] eqChildren][0] eqChildren][1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] eqChildren][0] eqChildren][1] eqChildren][0] setEqFormat:LEAF];
    [[[[[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] eqChildren][0] eqChildren][1] eqChildren][0] eqTextField].attributedStringValue = [[NSAttributedString alloc] initWithString:@"71" attributes:attr];

    [[[[[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] eqChildren][0] eqChildren][1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] eqChildren][0] eqChildren][1] eqChildren][1] setEqFormat:LEAF];
    [[[[[[self.eq.eqChildren[1] eqChildren][0] eqChildren][0] eqChildren][0] eqChildren][1] eqChildren][1] eqTextField].attributedStringValue = [[NSAttributedString alloc] initWithString:@"53" attributes:attr];
    
    [[[self.eq.eqChildren[1] eqChildren][0] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[self.eq.eqChildren[1] eqChildren][0] eqChildren][1] setEqFormat:LEAF];
    [[[self.eq.eqChildren[1] eqChildren][0] eqChildren][1] eqTextField].attributedStringValue = [[NSAttributedString alloc] initWithString:@"+π" attributes:attr];
    
    [[self.eq.eqChildren[1] eqChildren] addObject: [[EquationFieldComponent alloc] init]];
    [[self.eq.eqChildren[1] eqChildren][1] setEqFormat:NORMAL];
    
    
    [[[self.eq.eqChildren[1] eqChildren][1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[self.eq.eqChildren[1] eqChildren][1] eqChildren][0] setEqFormat:LEAF];
    [[[self.eq.eqChildren[1] eqChildren][1] eqChildren][0] eqTextField].attributedStringValue = [[NSAttributedString alloc] initWithString:@"x-3" attributes:attr];
    
    [[[self.eq.eqChildren[1] eqChildren][1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] setEqFormat:SUMMATION];
    NSString *pathToSummationImage = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForImageResource:@"summation.png"]];
    // [[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] setEqFormat:INTEGRATION];
    // NSString *pathToSummationImage = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForImageResource:@"integration.png"]];
    NSImageView *summationImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 50, 50)];
    NSImage *summationImage = [[NSImage alloc] initWithContentsOfFile:pathToSummationImage];
    [summationImageView setImage:summationImage];
    [[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] setEqImageView:summationImageView];
    
    [[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][0] setEqFormat:LEAF];
    [[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][0] eqTextField].attributedStringValue  = [[NSAttributedString alloc] initWithString:@"0" attributes:attr];
    
    // division should be inside a normal: [leaf, divison, leaf]
    [[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] setEqFormat:NORMAL];
    
    [[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][0] setEqFormat:LEAF];
    [[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][0] eqTextField].attributedStringValue = [[NSAttributedString alloc] initWithString:@"2" attributes:attr];
    [[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][1] setEqFormat:DIVISION];
    [[[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][0] setEqFormat:LEAF];
    [[[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][0] eqTextField].stringValue = @"3";
    [[[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][1] setEqFormat:LEAF];
    [[[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][1] eqTextField].stringValue = @"4";
    
    
    [[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][2] setEqFormat:LEAF];
    [[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][1] eqChildren][2] eqTextField].attributedStringValue = [[NSAttributedString alloc] initWithString:@"+5" attributes:attr];

    
    [[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][2] setEqFormat:NORMAL];
    
    [[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][2] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][2] eqChildren][0] setEqFormat:LEAF];
    [[[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][2] eqChildren][0] eqTextField] setAttributedStringValue:[[NSAttributedString alloc] initWithString:@"i+2" attributes:attr]];
    
    [[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][2] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][2] eqChildren][1] setEqFormat:EXPONENT];
    
    [[[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][2] eqChildren][1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
    [[[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][2] eqChildren][1] eqChildren][0] setEqFormat:LEAF];
    [[[[[[[self.eq.eqChildren[1] eqChildren][1] eqChildren][1] eqChildren][2] eqChildren][1] eqChildren][0] eqTextField] setAttributedStringValue:[[NSAttributedString alloc] initWithString:@"j" attributes:attr]];
    
    [self setWantsLayer:YES];
    self.layer.backgroundColor = [NSColor whiteColor].CGColor;
    
    self.cursor = [[NSTextField alloc] init];
    [self.cursor setEditable:NO];
    [self.cursor setBordered:NO];
    [self.cursor setDrawsBackground:false];
    [self.cursor setFocusRingType:NSFocusRingTypeNone];
    
    self.endCursor = [[NSTextField alloc] init];
    [self.endCursor setEditable:NO];
    [self.endCursor setBordered:NO];
    [self.endCursor setDrawsBackground:false];
    [self.endCursor setFocusRingType:NSFocusRingTypeNone];
    
    /*
    self.cursorTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f
                                                      target:self
                                                    selector:@selector(changeCursorState)
                                                    userInfo:nil
                                                     repeats:YES];
    */
    self.cursorCounter = 0;
    [self changeCursorState: [NSNumber numberWithInt:0]];
    
    return self;
}

- (void) setBackgroundColor: (NSColor*) col {
    self.layer.backgroundColor = col.CGColor;
}

- (NSColor*) getBackgroundColor {
    return [NSColor colorWithCGColor:self.layer.backgroundColor];
}

- (void) completeRecalculation {
    [self simplify];
    [self makeSizeRequests:self.eq size:self.maxFontSize];
    [self grantSizeRequests];
    [self completeViewUpdate];
    [self alignLeftCursor];
    
}

- (void) drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [self updateConstraints];
}

- (void) changeCursorState: (NSNumber*) counter {
    if(counter.intValue == self.cursorCounter) {
        [self.cursor setHidden:!self.cursor.hidden];
        [self performSelector:@selector(changeCursorState:) withObject:counter afterDelay:0.5];
    }
}

- (void) showCursor {
    self.cursorCounter++;
    if(self.cursor.isHidden) {
        [self.cursor setHidden:false];
        [self performSelector:@selector(changeCursorState:) withObject:[NSNumber numberWithInt:self.cursorCounter] afterDelay:0.5];
    }
    else {
        [self performSelector:@selector(changeCursorState:) withObject:[NSNumber numberWithInt:self.cursorCounter] afterDelay:0.5];
    }
}

- (NSString*) toLaTeX {
    return [self toLaTeX: self.eq];
}

- (void) deleteEquation {
    [self deleteMyChildren:self.eq];
    [self.eq.eqChildren addObject:[[EquationFieldComponent alloc] init]];
    [self.eq.eqChildren[0] setEqFormat:LEAF];
    self.eq.childWithStartCursor = 0;
    [self.eq.eqChildren[0] setStartCursorLocation:0];
    [self completeRecalculation];
}

- (NSString*) toString {
    return [self toString:self.eq];
}

/* EVENT FUNCTIONS */

- (void) reshape {
}

- (void) magnifyWithEvent:(NSEvent *)theEvent {
}

- (void) scrollWheel:(NSEvent *)theEvent {
}

- (void) mouseDragged:(NSEvent *)theEvent {
}

- (void) mouseDown:(NSEvent *)theEvent {
    NSPoint pt = [self.window mouseLocationOutsideOfEventStream];
    pt.x -= self.frame.origin.x;
    pt.y -= self.frame.origin.y;
    [self setStartCursorToEq:self.eq x:pt.x y:pt.y];
}

- (void) mouseUp:(NSEvent *)theEvent {
}

- (void) keyDown:(NSEvent *)theEvent {
    if(theEvent.keyCode == 36) {
        // return
    }
    else if(theEvent.keyCode == 48) {
        // tab
    }
    else if(theEvent.keyCode == 51) {
        [self delete];
    }
    else if(theEvent.keyCode == 123) {
        [self moveCursorLeft];
    }
    else if(theEvent.keyCode == 124) {
        [self moveCursorRight];
    }
    else if(theEvent.keyCode == 125) {
        // down-arrow
    }
    else if(theEvent.keyCode == 126) {
        // up-arrow
    }
    else {
        [self insertCharacter:[theEvent.characters characterAtIndex:0]];
    }
}

- (BOOL) acceptsFirstResponder {
    return YES;
}

- (BOOL) becomeFirstResponder {
    return YES;
}

- (BOOL) resignFirstResponder {
    return YES;
}

- (void) rightMouseDown: (NSEvent*) theEvent {
    NSMenu *theMenu = [[NSMenu alloc] initWithTitle:@"Contextual Menu"];
    [theMenu insertItemWithTitle:@"Save Image as PNG" action:@selector(saveImageAsPNG) keyEquivalent:@"" atIndex:0];
    [theMenu insertItemWithTitle:@"Delete Equation" action:@selector(deleteEquation) keyEquivalent:@"" atIndex:0];
    [theMenu insertItemWithTitle:@"Copy LateX to Clipboard" action:@selector(latexToClipBoard) keyEquivalent:@"" atIndex:0];
    [NSMenu popUpContextMenu:theMenu withEvent:theEvent forView:self];
}

- (void) latexToClipBoard {
    NSString *str = [self toLaTeX];
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    NSArray *copiedObjects = [NSArray arrayWithObject:str];
    [pasteboard writeObjects:copiedObjects];
}

- (void) saveImageAsPNG {
    NSData *data = [self dataWithPDFInsideRect:[self bounds]];
    NSImage *img = [[NSImage alloc] initWithData:data];
    
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)[img TIFFRepresentation], NULL);
    CGImageRef maskRef =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
    
    NSBitmapImageRep *imgRep = [[NSBitmapImageRep alloc] initWithCGImage:maskRef];
    NSData *exportedData = [imgRep representationUsingType:NSPNGFileType properties:nil];
    
    NSSavePanel *savepanel = [NSSavePanel savePanel];
    savepanel.title = @"Save chart";
    
    [savepanel setAllowedFileTypes:[NSArray arrayWithObjects:@"png", nil]];
    
    
    [savepanel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result)
     {
         if(NSFileHandlingPanelOKButton == result)
         {
             NSURL* fileURL = [savepanel URL];
             if ([fileURL.pathExtension isEqualToString:@""])
                 fileURL = [fileURL URLByAppendingPathExtension:@"png"];
             [exportedData writeToURL:fileURL atomically:YES];
         }
     }];
}

- (BOOL) setStartCursorToEq: (EquationFieldComponent*) eq x: (double) x y: (double) y {
    [self showCursor];
    if(eq.eqFormat == LEAF) {
        // special
        eq.childWithStartCursor = -1;
        NSString *str = [eq.eqTextField.stringValue copy];
        int i;
        double siz = eq.heightAbove+eq.heightBelow;
        double xpos;
        NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
        
        NSMutableArray *lenArr = [[NSMutableArray alloc] init];
        for(i=0; i<=str.length; i++) {
            double len = eq.eqTextField.frame.origin.x + [[[NSAttributedString alloc] initWithString:[str substringToIndex:i] attributes:attr] size].width;
            [lenArr addObject:[NSNumber numberWithDouble:len]];
        }
        
        for(i=0; i<str.length; i++) {
            int quail = ([lenArr[i+1] doubleValue]-[lenArr[i] doubleValue])/2+[lenArr[i] doubleValue];
            if(x < quail) {
                break;
            }
        }
        xpos = [lenArr[i] intValue];
        eq.startCursorLocation = i;
        [self.cursor setFrame:NSMakeRect(xpos-siz/6, eq.eqTextField.frame.origin.y, 50, siz)];
        attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"|" attributes:attr];
        [self.cursor setAttributedStringValue:attStr];
        [self.cursor removeFromSuperview];
        [self addSubview:self.cursor];
        return true;
    }
    else {
        int i;
        for(i=0; i<eq.eqChildren.count; i++) {
            if([eq.eqChildren[i] x] < x && [eq.eqChildren[i] y]-[eq.eqChildren[i] heightBelow] < y && x < [eq.eqChildren[i] x]+[eq.eqChildren[i] width] && y < [eq.eqChildren[i] y]+[eq.eqChildren[i] heightAbove]) {
                BOOL answer = [self setStartCursorToEq:eq.eqChildren[i] x:x y:y];
                if(answer) {
                    eq.childWithStartCursor = i;
                }
                return answer;
            }
        }
        if(i == eq.eqChildren.count) {
            return false;
        }
    }
    // we should never get here
    NSLog(@"ERROR - EquationField:setStartCursorToEq");
    return false;
}

- (void) moveCursorRight {
    [self showCursor];
    if(self.eq.childWithStartCursor == -1) {
        // no cursor
        return;
    }
    
    // construct a list of descendants from self.eq to the component currently containing the (start) cursor
    EquationFieldComponent *current;
    NSMutableArray *descendants = [[NSMutableArray alloc] initWithObjects:self.eq, nil];
    while(true) {
        current = descendants[descendants.count-1];
        if(current.childWithStartCursor == -1) {
            break;
        }
        else {
            [descendants addObject:current.eqChildren[current.childWithStartCursor]];
        }
    }
    
    while(true) {
        if(descendants.count == 0) {
            [self sendCursorToEnd];
            return;
        }
        current = descendants[descendants.count-1];
        if(current.eqFormat == LEAF) {
            if(current.startCursorLocation < -1) {
                // error - cursor either doesn't exist or is too far left
                return;
            }
            else if(current.startCursorLocation > (int) current.eqTextField.stringValue.length) {
                // error - cursor is too far right
                return;
            }
            
            // we're legal
            if(current.startCursorLocation == -1) {
                // cursor doesn't exist yet
                current.startCursorLocation = 0;
                // place cursor at beginning of leaf
                double siz = current.heightAbove+current.heightBelow;
                NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
                double xpos = current.eqTextField.frame.origin.x + [[[NSAttributedString alloc] initWithString:[current.eqTextField.stringValue substringToIndex:current.startCursorLocation] attributes:attr] size].width;
                [self.cursor setFrame:NSMakeRect(xpos-siz/6, current.eqTextField.frame.origin.y, 50, siz)];
                attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
                NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"|" attributes:attr];
                [self.cursor setAttributedStringValue:attStr];
                [self.cursor removeFromSuperview];
                [self addSubview:self.cursor];
                return;
            }
            if(current.startCursorLocation == current.eqTextField.stringValue.length) {
                // pass cursor on to next component
                current.startCursorLocation = -1;
                [descendants removeLastObject];
            }
            else {
                // move cursor right one character
                current.startCursorLocation++;
                double siz = current.heightAbove+current.heightBelow;
                NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
                double xpos = current.eqTextField.frame.origin.x + [[[NSAttributedString alloc] initWithString:[current.eqTextField.stringValue substringToIndex:current.startCursorLocation] attributes:attr] size].width;
                [self.cursor setFrame:NSMakeRect(xpos-siz/6, current.eqTextField.frame.origin.y, 50, siz)];
                attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
                NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"|" attributes:attr];
                [self.cursor setAttributedStringValue:attStr];
                [self.cursor removeFromSuperview];
                [self addSubview:self.cursor];
                return;
            }
        }
        else {
            if(current.childWithStartCursor == -1) {
                // cursor doesn't exist yet
                current.childWithStartCursor = 0;
                [descendants addObject:current.eqChildren[current.childWithStartCursor]];
            }
            else if(current.childWithStartCursor == (int) current.eqChildren.count-1) {
                // right-most child had cursor
                // pass on to parent
                current.childWithStartCursor = -1;
                [descendants removeLastObject];
            }
            else if(current.childWithStartCursor >= 0 && current.childWithStartCursor < (int) current.eqChildren.count) {
                // some other child had cursor
                current.childWithStartCursor++;
                [descendants addObject:current.eqChildren[current.childWithStartCursor]];
            }
            else {
                // error
                return;
            }
        }
    }
}

- (void) sendCursorToBeginning {
    EquationFieldComponent *component = self.eq;
    while(component.eqFormat != LEAF) {
        component.childWithStartCursor = 0;
        component = component.eqChildren[0];
    }
    component.childWithStartCursor = -1;
    component.startCursorLocation = 0;
}

- (void) sendCursorToEnd {
    EquationFieldComponent *component = self.eq;
    while(component.eqFormat != LEAF) {
        component.childWithStartCursor = (int) component.eqChildren.count-1;
        component = component.eqChildren[component.eqChildren.count-1];
    }
    component.childWithStartCursor = -1;
    component.startCursorLocation = (int) component.eqTextField.stringValue.length;
}

- (void) moveCursorLeft {
    [self showCursor];
    if(self.eq.childWithStartCursor == -1) {
        // no cursor
        [self sendCursorToBeginning];
        return;
    }
    
    // construct a list of descendants from self.eq to the component currently containing the (start) cursor
    EquationFieldComponent *current;
    NSMutableArray *descendants = [[NSMutableArray alloc] initWithObjects:self.eq, nil];
    while(true) {
        current = descendants[descendants.count-1];
        if(current.childWithStartCursor == -1) {
            break;
        }
        else {
            [descendants addObject:current.eqChildren[current.childWithStartCursor]];
        }
    }
    
    while(true) {
        if(descendants.count == 0) {
            return;
        }
        current = descendants[descendants.count-1];
        if(current.eqFormat == LEAF) {
            if(current.startCursorLocation < -1) {
                // error - cursor either doesn't exist or is too far left
                return;
            }
            else if(current.startCursorLocation > (int) current.eqTextField.stringValue.length) {
                // error - cursor is too far right
                return;
            }
            
            // we're legal
            if(current.startCursorLocation == -1) {
                // cursor doesn't exist yet
                current.startCursorLocation = (int) current.eqTextField.stringValue.length;
                // place cursor at end of leaf
                double siz = current.heightAbove+current.heightBelow;
                NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
                double xpos = current.eqTextField.frame.origin.x + [[[NSAttributedString alloc] initWithString:[current.eqTextField.stringValue substringToIndex:current.startCursorLocation] attributes:attr] size].width;
                [self.cursor setFrame:NSMakeRect(xpos-siz/6, current.eqTextField.frame.origin.y, 50, siz)];
                attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
                NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"|" attributes:attr];
                [self.cursor setAttributedStringValue:attStr];
                [self.cursor removeFromSuperview];
                [self addSubview:self.cursor];
                return;
            }
            else if(current.startCursorLocation == 0) {
                // pass cursor on to next (prior) component
                current.startCursorLocation = -1;
                [descendants removeLastObject];
            }
            else {
                // move cursor left one character
                current.startCursorLocation--;
                double siz = current.heightAbove+current.heightBelow;
                NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
                double xpos = current.eqTextField.frame.origin.x + [[[NSAttributedString alloc] initWithString:[current.eqTextField.stringValue substringToIndex:current.startCursorLocation] attributes:attr] size].width;
                [self.cursor setFrame:NSMakeRect(xpos-siz/6, current.eqTextField.frame.origin.y, 50, siz)];
                attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
                NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"|" attributes:attr];
                [self.cursor setAttributedStringValue:attStr];
                [self.cursor removeFromSuperview];
                [self addSubview:self.cursor];
                return;
            }
        }
        else {
            if(current.childWithStartCursor == -1) {
                // cursor doesn't exist yet
                current.childWithStartCursor = ((int) current.eqChildren.count)-1;
                [descendants addObject:current.eqChildren[current.childWithStartCursor]];
            }
            else if(current.childWithStartCursor == 0) {
                // left-most child had cursor
                // pass on to parent
                current.childWithStartCursor = -1;
                [descendants removeLastObject];
            }
            else if(current.childWithStartCursor > 0 && current.childWithStartCursor < (int) current.eqChildren.count) {
                // some other child had cursor
                current.childWithStartCursor--;
                [descendants addObject:current.eqChildren[current.childWithStartCursor]];
            }
            else {
                // error
                return;
            }
        }
    }
}

- (void) delete {
    if(self.eq.childWithEndCursor == -1) {
        // nothing highlighted
        if(self.eq.childWithStartCursor == -1) {
            // no cursor
            return;
        }
        
        // construct a list of descendants from self.eq to the component currently containing the (start) cursor
        EquationFieldComponent *current;
        NSMutableArray *descendants = [[NSMutableArray alloc] initWithObjects:self.eq, nil];
        while(true) {
            current = descendants[descendants.count-1];
            if(current.childWithStartCursor == -1) {
                break;
            }
            else {
                [descendants addObject:current.eqChildren[current.childWithStartCursor]];
            }
        }
        
        current = descendants[descendants.count-1];
        
        if(current.eqFormat == LEAF) {
            if(current.startCursorLocation < 0 || current.startCursorLocation > current.eqTextField.stringValue.length) {
                // problem with cursor location
                return;
            }
            
            if(current.startCursorLocation == 0) {
                EquationFieldComponent *parent = descendants[descendants.count-2];
                if(parent.eqFormat == NORMAL) {
                    // attempt to delete sibling to the left; if no such sibling exists, then delete grandparent
                    int i;
                    for(i = 0; i < (int) parent.eqChildren.count; i++) {
                        if(parent.eqChildren[i] == current) {
                            if(i != 0) {
                                // delete sibling to left
                                EquationFieldComponent *deleteMe = parent.eqChildren[i-1];
                                [self deleteMyChildren:deleteMe];
                                [deleteMe.eqTextField removeFromSuperview];
                                [deleteMe.eqImageView removeFromSuperview];
                                [parent.eqChildren removeObjectAtIndex:i-1];
                                parent.childWithStartCursor--;
                            }
                            else {
                                // delete grandparent
                                EquationFieldComponent *greatGrandparent = descendants[descendants.count-4];
                                EquationFieldComponent *grandparent = descendants[descendants.count-3];
                                [self deleteMyChildren:grandparent];
                                [grandparent.eqTextField removeFromSuperview];
                                [grandparent.eqImageView removeFromSuperview];
                                for(int i = 0; i < (int) greatGrandparent.eqChildren.count; i++) {
                                    if(greatGrandparent.eqChildren[i] == grandparent) {
                                        if(i != 0) {
                                            greatGrandparent.childWithStartCursor--;
                                            [self giveCursor:greatGrandparent.eqChildren[i-1] atEnd:true];
                                        }
                                        [greatGrandparent.eqChildren removeObjectAtIndex:i];
                                        break;
                                    }
                                }
                            }
                        }
                    }
                }
                else {
                    EquationFieldComponent *grandparent = descendants[descendants.count-3];
                    [self deleteMyChildren:parent];
                    [parent.eqTextField removeFromSuperview];
                    [parent.eqImageView removeFromSuperview];
                    for(int i = 0; i < (int) grandparent.eqChildren.count; i++) {
                        if(grandparent.eqChildren[i] == parent) {
                            // replace parent with empty leaf
                            parent.eqFormat = LEAF;
                            parent.eqTextField.stringValue = @"";
                            break;
                        }
                    }
                }
                [self completeRecalculation];
                return;
            }
            else {
                // I can deal with this
                NSMutableString *sub = [[NSMutableString alloc] initWithString:[current.eqTextField.stringValue substringToIndex:current.startCursorLocation-1]];
                [sub appendString:[current.eqTextField.stringValue substringFromIndex:current.startCursorLocation]];
                double siz = current.heightAbove+current.heightBelow;
                NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
                current.eqTextField.attributedStringValue = [[NSAttributedString alloc] initWithString:sub attributes:attr];
                current.startCursorLocation--;
                [self completeRecalculation];
                return;
            }
        }
        else {
            // do nothing
            return;
        }
    }
    else {
        // something highlighted
        // TODO
    }
}

- (void) giveCursor: (EquationFieldComponent*) eq atEnd: (BOOL) atEnd {
    if(atEnd) {
        EquationFieldComponent *current = eq;
        while(current.eqFormat != LEAF) {
            if(current.eqChildren.count == 0) {
                return;
            }
            current = current.eqChildren[current.eqChildren.count-1];
        }
        eq.startCursorLocation = (int) eq.eqTextField.stringValue.length;
    }
    else {
        EquationFieldComponent *current = eq;
        while(current.eqFormat != LEAF) {
            if(current.eqChildren.count == 0) {
                return;
            }
            current = current.eqChildren[0];
        }
        eq.startCursorLocation = 0;
    }
}

- (void) deleteMyChildren: (EquationFieldComponent*) parent {
    for(int i=0; i<parent.eqChildren.count; i++) {
        [self deleteMyChildren:parent.eqChildren[i]];
        [[parent.eqChildren[i] eqImageView] removeFromSuperview];
        [[parent.eqChildren[i] eqTextField] removeFromSuperview];
    }
    parent.eqChildren = [[NSMutableArray alloc] init];
}

- (void) simplify {
    for(int i=0; i<5; i++) {
        if(self.eq.childWithStartCursor != -1) {
            if(![self simplify:self.eq worryAboutCursor:true]) {
                return;
            }
        }
        else {
            if(![self simplify:self.eq worryAboutCursor:false]) {
                return;
            }
        }
    }
}

- (BOOL) simplify: (EquationFieldComponent*) eq worryAboutCursor: (BOOL) worryAboutCursor {
    BOOL rtn = false;
    for(int i=0; i<eq.eqChildren.count; i++) {
        if(eq.childWithStartCursor == i && worryAboutCursor) {
            if([self simplify:eq.eqChildren[i] worryAboutCursor:true]) {
                rtn = true;
            }
        }
        else {
            if([self simplify:eq.eqChildren[i] worryAboutCursor:false]) {
                rtn = true;
            }
        }
    }
    
    if(eq.eqFormat == NORMAL) {
        if(eq.eqChildren.count == 1 && eq != self.eq) {
            // remove redundant NORMAL components
            rtn = true;
            EquationFieldComponent *child = eq.eqChildren[0];
            if(worryAboutCursor) {
                eq.childWithStartCursor = -1;
                eq.startCursorLocation = child.startCursorLocation;
            }
            eq.eqFormat = child.eqFormat;
            eq.eqChildren = child.eqChildren;
            eq.eqImageView = child.eqImageView;
            eq.eqTextField = child.eqTextField;
        }
        else {
            // combine two adjacent LEAFs
            for(int i=1; i<eq.eqChildren.count; i++) {
                if([eq.eqChildren[i-1] eqFormat] == LEAF && [eq.eqChildren[i] eqFormat] == LEAF) {
                    rtn = true;
                    int info = -1;
                    if(worryAboutCursor) {
                        if(eq.childWithStartCursor == i-1) {
                            info = [eq.eqChildren[i-1] startCursorLocation];
                        }
                        else if(eq.childWithStartCursor == i) {
                            info = (int) [eq.eqChildren[i-1] eqTextField].stringValue.length + [eq.eqChildren[i] startCursorLocation];
                            eq.childWithStartCursor = i-1;
                        }
                    }
                    
                    NSMutableString *str = [[NSMutableString alloc] initWithString:[eq.eqChildren[i-1] eqTextField].stringValue];
                    [str appendString:[eq.eqChildren[i] eqTextField].stringValue];
                    [eq.eqChildren[i-1] eqTextField].stringValue = str;
                    [self deleteMyChildren:eq.eqChildren[i]];
                    [[eq.eqChildren[i] eqTextField] removeFromSuperview];
                    [eq.eqChildren removeObjectAtIndex:i];
                    if(info != -1) {
                        [eq.eqChildren[i-1] setStartCursorLocation:info];
                    }
                    i--;
                }
            }
        }
    }
    return rtn;
}

- (void) insertCharacter: (unichar) c {
    
    if(self.eq.childWithStartCursor == -1) {
        // no cursor
        return;
    }
    
    // construct a list of descendants from self.eq to the component currently containing the (start) cursor
    EquationFieldComponent *current = self.eq;
    while(true) {
        if(current.childWithStartCursor == -1) {
            break;
        }
        else {
            current = current.eqChildren[current.childWithStartCursor];
        }
    }
    
    if(c == '/') {
        // division
        if(current.eqFormat == LEAF) {
            if(current.startCursorLocation < 0 || current.startCursorLocation > current.eqTextField.stringValue.length) {
                // problem with cursor location
                return;
            }
            else {
                // insert character
                NSString *partA = [[NSString alloc] initWithString:[current.eqTextField.stringValue substringToIndex:current.startCursorLocation]];
                NSString *partB = [current.eqTextField.stringValue substringFromIndex:current.startCursorLocation];
                current.eqFormat = NORMAL;
                current.eqTextField.stringValue = @"";
                current.eqChildren = [[NSMutableArray alloc] init];
                current.childWithStartCursor = 1;
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[0] setEqFormat:LEAF];
                [current.eqChildren[0] eqTextField].stringValue = partA;
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[1] setEqFormat:DIVISION];
                [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                [[current.eqChildren[1] eqChildren][0] setEqFormat:LEAF];
                [[current.eqChildren[1] eqChildren][0] eqTextField].stringValue = @"";
                [current.eqChildren[1] setChildWithStartCursor:0];
                [[current.eqChildren[1] eqChildren][0] setChildWithStartCursor:-1];
                [[current.eqChildren[1] eqChildren][0] setStartCursorLocation:0];
                [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                [[current.eqChildren[1] eqChildren][1] setEqFormat:LEAF];
                [[current.eqChildren[1] eqChildren][1] eqTextField].stringValue = @"";
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[2] setEqFormat:LEAF];
                [current.eqChildren[2] eqTextField].stringValue = partB;
                [self completeRecalculation];
                return;
            }
        }
        else {
            // error
            return;
        }
    }
    else if(c == '^') {
        // power
        if(current.eqFormat == LEAF) {
            if(current.startCursorLocation < 0 || current.startCursorLocation > current.eqTextField.stringValue.length) {
                // problem with cursor location
                return;
            }
            else {
                // insert character
                NSString *partA = [[NSString alloc] initWithString:[current.eqTextField.stringValue substringToIndex:current.startCursorLocation]];
                NSString *partB = [current.eqTextField.stringValue substringFromIndex:current.startCursorLocation];
                current.eqFormat = NORMAL;
                current.eqTextField.stringValue = @"";
                current.eqChildren = [[NSMutableArray alloc] init];
                current.childWithStartCursor = 1;
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[0] setEqFormat:LEAF];
                [current.eqChildren[0] eqTextField].stringValue = partA;
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[1] setEqFormat:EXPONENT];
                [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                [[current.eqChildren[1] eqChildren][0] setEqFormat:LEAF];
                [[current.eqChildren[1] eqChildren][0] eqTextField].stringValue = @"";
                [current.eqChildren[1] setChildWithStartCursor:0];
                [[current.eqChildren[1] eqChildren][0] setChildWithStartCursor:-1];
                [[current.eqChildren[1] eqChildren][0] setStartCursorLocation:0];
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[2] setEqFormat:LEAF];
                [current.eqChildren[2] eqTextField].stringValue = partB;
                [self completeRecalculation];
                return;
            }
        }
        else {
            // error
            return;
        }
    }
    else if(c == 8730) {
        // square-root
        if(current.eqFormat == LEAF) {
            if(current.startCursorLocation < 0 || current.startCursorLocation > current.eqTextField.stringValue.length) {
                // problem with cursor location
                return;
            }
            else {
                // insert character
                NSString *partA = [[NSString alloc] initWithString:[current.eqTextField.stringValue substringToIndex:current.startCursorLocation]];
                NSString *partB = [current.eqTextField.stringValue substringFromIndex:current.startCursorLocation];
                current.eqFormat = NORMAL;
                current.eqTextField.stringValue = @"";
                current.eqChildren = [[NSMutableArray alloc] init];
                current.childWithStartCursor = 1;
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[0] setEqFormat:LEAF];
                [current.eqChildren[0] eqTextField].stringValue = partA;
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[1] setEqFormat:SQUAREROOT];
                
                NSString *pathToRootImage = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForImageResource:@"root.png"]];
                NSImageView *rootImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 50, 50)];
                NSImage *rootImage = [[NSImage alloc] initWithContentsOfFile:pathToRootImage];
                [rootImageView setImage:rootImage];
                [current.eqChildren[1] setEqImageView:rootImageView];
                
                [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                [[current.eqChildren[1] eqChildren][0] setEqFormat:LEAF];
                [[current.eqChildren[1] eqChildren][0] eqTextField].stringValue = @"";
                [current.eqChildren[1] setChildWithStartCursor:0];
                [[current.eqChildren[1] eqChildren][0] setChildWithStartCursor:-1];
                [[current.eqChildren[1] eqChildren][0] setStartCursorLocation:0];
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[2] setEqFormat:LEAF];
                [current.eqChildren[2] eqTextField].stringValue = partB;
                [self completeRecalculation];
                return;
            }
        }
        else {
            // error
            return;
        }
    }
    else if(c == 8747) {
        // integral
        if(current.eqFormat == LEAF) {
            if(current.startCursorLocation < 0 || current.startCursorLocation > current.eqTextField.stringValue.length) {
                // problem with cursor location
                return;
            }
            else {
                // insert character
                NSString *partA = [[NSString alloc] initWithString:[current.eqTextField.stringValue substringToIndex:current.startCursorLocation]];
                NSString *partB = [current.eqTextField.stringValue substringFromIndex:current.startCursorLocation];
                current.eqFormat = NORMAL;
                current.eqTextField.stringValue = @"";
                current.eqChildren = [[NSMutableArray alloc] init];
                current.childWithStartCursor = 1;
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[0] setEqFormat:LEAF];
                [current.eqChildren[0] eqTextField].stringValue = partA;
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[1] setEqFormat:INTEGRATION];
                
                NSString *pathToIntegralImage = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForImageResource:@"integration.png"]];
                NSImageView *integralImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 50, 50)];
                NSImage *integralImage = [[NSImage alloc] initWithContentsOfFile:pathToIntegralImage];
                [integralImageView setImage:integralImage];
                [current.eqChildren[1] setEqImageView:integralImageView];
                
                [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                [[current.eqChildren[1] eqChildren][0] setEqFormat:LEAF];
                [[current.eqChildren[1] eqChildren][0] eqTextField].stringValue = @"";
                [current.eqChildren[1] setChildWithStartCursor:0];
                [[current.eqChildren[1] eqChildren][0] setChildWithStartCursor:-1];
                [[current.eqChildren[1] eqChildren][0] setStartCursorLocation:0];
                
                [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                [[current.eqChildren[1] eqChildren][1] setEqFormat:LEAF];
                [[current.eqChildren[1] eqChildren][1] eqTextField].stringValue = @"";
                [[current.eqChildren[1] eqChildren][1] setChildWithStartCursor:-1];
                [[current.eqChildren[1] eqChildren][1] setStartCursorLocation:0];
                
                [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                [[current.eqChildren[1] eqChildren][2] setEqFormat:LEAF];
                [[current.eqChildren[1] eqChildren][2] eqTextField].stringValue = @"";
                [[current.eqChildren[1] eqChildren][2] setChildWithStartCursor:-1];
                [[current.eqChildren[1] eqChildren][2] setStartCursorLocation:0];
                
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[2] setEqFormat:LEAF];
                [current.eqChildren[2] eqTextField].stringValue = partB;
                [self completeRecalculation];
                return;
            }
        }
        else {
            // error
            return;
        }
    }
    else if(c == 8721) {
        // summation
        if(current.eqFormat == LEAF) {
            if(current.startCursorLocation < 0 || current.startCursorLocation > current.eqTextField.stringValue.length) {
                // problem with cursor location
                return;
            }
            else {
                // insert character
                NSString *partA = [[NSString alloc] initWithString:[current.eqTextField.stringValue substringToIndex:current.startCursorLocation]];
                NSString *partB = [current.eqTextField.stringValue substringFromIndex:current.startCursorLocation];
                current.eqFormat = NORMAL;
                current.eqTextField.stringValue = @"";
                current.eqChildren = [[NSMutableArray alloc] init];
                current.childWithStartCursor = 1;
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[0] setEqFormat:LEAF];
                [current.eqChildren[0] eqTextField].stringValue = partA;
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[1] setEqFormat:SUMMATION];
                
                NSString *pathToSumImage = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForImageResource:@"summation.png"]];
                NSImageView *sumImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 50, 50)];
                NSImage *sumImage = [[NSImage alloc] initWithContentsOfFile:pathToSumImage];
                [sumImageView setImage:sumImage];
                [current.eqChildren[1] setEqImageView:sumImageView];
                
                [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                [[current.eqChildren[1] eqChildren][0] setEqFormat:LEAF];
                [[current.eqChildren[1] eqChildren][0] eqTextField].stringValue = @"i=1";
                [current.eqChildren[1] setChildWithStartCursor:0];
                [[current.eqChildren[1] eqChildren][0] setChildWithStartCursor:-1];
                [[current.eqChildren[1] eqChildren][0] setStartCursorLocation:0];
                
                [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                [[current.eqChildren[1] eqChildren][1] setEqFormat:LEAF];
                [[current.eqChildren[1] eqChildren][1] eqTextField].stringValue = @"";
                [[current.eqChildren[1] eqChildren][1] setChildWithStartCursor:-1];
                [[current.eqChildren[1] eqChildren][1] setStartCursorLocation:0];
                
                [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                [[current.eqChildren[1] eqChildren][2] setEqFormat:LEAF];
                [[current.eqChildren[1] eqChildren][2] eqTextField].stringValue = @"";
                [[current.eqChildren[1] eqChildren][2] setChildWithStartCursor:-1];
                [[current.eqChildren[1] eqChildren][2] setStartCursorLocation:0];
                
                
                [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                [current.eqChildren[2] setEqFormat:LEAF];
                [current.eqChildren[2] eqTextField].stringValue = partB;
                [self completeRecalculation];
                return;
            }
        }
        else {
            // error
            return;
        }
    }
    else {
        // normal
        
        if(current.eqFormat == LEAF) {
            if(current.startCursorLocation < 0 || current.startCursorLocation > current.eqTextField.stringValue.length) {
                // problem with cursor location
                return;
            }
            else {
                // insert character
                
                NSMutableString *sub = [[NSMutableString alloc] initWithString:[current.eqTextField.stringValue substringToIndex:current.startCursorLocation]];
                
                [sub appendString:[[NSString alloc] initWithCharacters:&c length:1]];
                [sub appendString:[current.eqTextField.stringValue substringFromIndex:current.startCursorLocation]];
                
                double siz = current.heightAbove+current.heightBelow;
                NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
                
                current.eqTextField.attributedStringValue = [[NSAttributedString alloc] initWithString:sub attributes:attr];
                current.startCursorLocation++;
                
                // check to see if we have to inser ∑ or ∫
                /*
                 sum = ∑
                 int = ∫
                 log_ = log_{}{}
                */
                if(current.startCursorLocation >= 3) {
                    // NSLog(@"{%i : %@, %@}", current.startCursorLocation, current.eqTextField.stringValue, [current.eqTextField.stringValue substringWithRange:NSMakeRange(current.startCursorLocation-3, 3)]);
                    if([[current.eqTextField.stringValue substringWithRange:NSMakeRange(current.startCursorLocation-3, 3)] isEqual: @"sum"]) {
                        // replace with ∑
                        NSString *before = [current.eqTextField.stringValue substringToIndex:current.startCursorLocation-3];
                        NSString *after = [current.eqTextField.stringValue substringFromIndex:current.startCursorLocation];
                        current.eqFormat = NORMAL;
                        [current.eqTextField removeFromSuperview];
                        
                        [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                        [current.eqChildren[0] setEqFormat:LEAF];
                        [current.eqChildren[0] eqTextField].stringValue = before;
                        
                        [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                        [current.eqChildren[1] setEqFormat:SUMMATION];
                        NSString *pathToSummationImage = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForImageResource:@"summation.png"]];
                        NSImageView *summationImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 50, 50)];
                        NSImage *summationImage = [[NSImage alloc] initWithContentsOfFile:pathToSummationImage];
                        [summationImageView setImage:summationImage];
                        [current.eqChildren[1] setEqImageView:summationImageView];
                        
                        [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                        [[current.eqChildren[1] eqChildren][0] setEqFormat:LEAF];
                        [[current.eqChildren[1] eqChildren][0] eqTextField].stringValue = @"";
                        [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                        [[current.eqChildren[1] eqChildren][1] setEqFormat:LEAF];
                        [[current.eqChildren[1] eqChildren][1] eqTextField].stringValue = @"";
                        [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                        [[current.eqChildren[1] eqChildren][2] setEqFormat:LEAF];
                        [[current.eqChildren[1] eqChildren][2] eqTextField].stringValue = @"";
                        
                        [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                        [current.eqChildren[2] setEqFormat:LEAF];
                        [current.eqChildren[2] eqTextField].stringValue = after;
                        
                        current.childWithStartCursor = 1;
                        [current.eqChildren[1] setChildWithStartCursor:0];
                        [[current.eqChildren[1] eqChildren][0] setStartCursorLocation:0];
                    }
                    else if([[current.eqTextField.stringValue substringWithRange:NSMakeRange(current.startCursorLocation-3, 3)] isEqual: @"int"]) {
                        // replace with ∑
                        NSString *before = [current.eqTextField.stringValue substringToIndex:current.startCursorLocation-3];
                        NSString *after = [current.eqTextField.stringValue substringFromIndex:current.startCursorLocation];
                        current.eqFormat = NORMAL;
                        [current.eqTextField removeFromSuperview];
                        
                        [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                        [current.eqChildren[0] setEqFormat:LEAF];
                        [current.eqChildren[0] eqTextField].stringValue = before;
                        
                        [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                        [current.eqChildren[1] setEqFormat:INTEGRATION];
                        NSString *pathToIntegrationImage = [[NSString alloc] initWithString:[[NSBundle mainBundle] pathForImageResource:@"integration.png"]];
                        NSImageView *integrationImageView = [[NSImageView alloc] initWithFrame:NSMakeRect(0, 0, 50, 50)];
                        NSImage *integrationImage = [[NSImage alloc] initWithContentsOfFile:pathToIntegrationImage];
                        [integrationImageView setImage:integrationImage];
                        [current.eqChildren[1] setEqImageView:integrationImageView];
                        
                        [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                        [[current.eqChildren[1] eqChildren][0] setEqFormat:LEAF];
                        [[current.eqChildren[1] eqChildren][0] eqTextField].stringValue = @"";
                        [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                        [[current.eqChildren[1] eqChildren][1] setEqFormat:LEAF];
                        [[current.eqChildren[1] eqChildren][1] eqTextField].stringValue = @"";
                        [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                        [[current.eqChildren[1] eqChildren][2] setEqFormat:LEAF];
                        [[current.eqChildren[1] eqChildren][2] eqTextField].stringValue = @"";
                        
                        [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                        [current.eqChildren[2] setEqFormat:LEAF];
                        [current.eqChildren[2] eqTextField].stringValue = after;
                        
                        current.childWithStartCursor = 1;
                        [current.eqChildren[1] setChildWithStartCursor:0];
                        [[current.eqChildren[1] eqChildren][0] setStartCursorLocation:0];
                    }
                    else if(current.startCursorLocation >= 4 && [[current.eqTextField.stringValue substringWithRange:NSMakeRange(current.startCursorLocation-4, 4)] isEqual: @"log_"]) {
                        // replace with ∑
                        NSString *before = [current.eqTextField.stringValue substringToIndex:current.startCursorLocation-4];
                        NSString *after = [current.eqTextField.stringValue substringFromIndex:current.startCursorLocation];
                        current.eqFormat = NORMAL;
                        [current.eqTextField removeFromSuperview];
                        
                        [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                        [current.eqChildren[0] setEqFormat:LEAF];
                        [current.eqChildren[0] eqTextField].stringValue = before;
                        
                        [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                        [current.eqChildren[1] setEqFormat:LOGBASE];
                        
                        [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                        [[current.eqChildren[1] eqChildren][0] setEqFormat:LEAF];
                        [[current.eqChildren[1] eqChildren][0] eqTextField].stringValue = @"";
                        [[current.eqChildren[1] eqChildren] addObject:[[EquationFieldComponent alloc] init]];
                        [[current.eqChildren[1] eqChildren][1] setEqFormat:LEAF];
                        [[current.eqChildren[1] eqChildren][1] eqTextField].stringValue = @"";
                        
                        [current.eqChildren addObject:[[EquationFieldComponent alloc] init]];
                        [current.eqChildren[2] setEqFormat:LEAF];
                        [current.eqChildren[2] eqTextField].stringValue = after;
                        
                        current.childWithStartCursor = 1;
                        [current.eqChildren[1] setChildWithStartCursor:0];
                        [[current.eqChildren[1] eqChildren][0] setStartCursorLocation:0];
                        
                    }
                }
                [self completeRecalculation];
            }
        }
        else {
            // error
        }
    }
}

- (void) alignLeftCursor {
    if(self.eq.childWithStartCursor == -1) {
        // no cursor
        return;
    }
    
    // construct a list of descendants from self.eq to the component currently containing the (start) cursor
    EquationFieldComponent *current = self.eq;
    while(true) {
        if(current.childWithStartCursor == -1) {
            break;
        }
        else {
            current = current.eqChildren[current.childWithStartCursor];
        }
    }
    
    if(current.eqFormat == LEAF) {
        if(current.startCursorLocation >= 0 && current.startCursorLocation <= current.eqTextField.stringValue.length) {
            // valid cursor location
            double siz = current.heightAbove+current.heightBelow;
            NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
            double xpos = current.eqTextField.frame.origin.x + [[[NSAttributedString alloc] initWithString:[current.eqTextField.stringValue substringToIndex:current.startCursorLocation] attributes:attr] size].width;
            [self.cursor setFrame:NSMakeRect(xpos-siz/6, current.eqTextField.frame.origin.y, 50, siz)];
            attr = @{NSFontAttributeName : [self.fontManager getFont:siz]};
            NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"|" attributes:attr];
            [self.cursor setAttributedStringValue:attStr];
            [self.cursor removeFromSuperview];
            [self addSubview:self.cursor];
        }
        else {
            // invalid cursor location - error
            return;
        }
    }
    else {
        // error
        return;
    }
}

- (void) makeSizeRequests: (EquationFieldComponent*) component size: (double) size {
    if(component.eqFormat == LEAF) {
        NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:self.maxFontSize]};
        component.eqTextField.attributedStringValue = [[NSAttributedString alloc] initWithString:component.eqTextField.stringValue attributes:attr];
        NSSize textSize = [component.eqTextField.attributedStringValue size];
        component.heightBelow = size/2;
        component.heightAbove = size/2;
        component.width = textSize.width * size/self.maxFontSize;
        if(component.width < 0.5*size) {
            component.width = 0.5*size;
        }
    }
    else if(component.eqFormat == NORMAL) {
        component.width = 0;
        component.heightBelow = 0;
        component.heightAbove = 0;
        for(int i=0; i<component.eqChildren.count; i++) {
            [self makeSizeRequests:component.eqChildren[i] size:size];
            if([component.eqChildren[i] heightBelow] > component.heightBelow) {
                component.heightBelow = [component.eqChildren[i] heightBelow];
            }
            if([component.eqChildren[i] heightAbove] > component.heightAbove) {
                component.heightAbove = [component.eqChildren[i] heightAbove];
            }
            component.width += [component.eqChildren[i] width];
        }
    }
    else if(component.eqFormat == DIVISION) {
        [self makeSizeRequests:component.eqChildren[0] size:size*self.decayDivision];
        [self makeSizeRequests:component.eqChildren[1] size:size*self.decayDivision];
        component.width = [component.eqChildren[0] width];
        if([component.eqChildren[1] width] > component.width) {
            component.width = [component.eqChildren[1] width];
        }
        component.heightAbove = [component.eqChildren[0] heightBelow] + [component.eqChildren[0] heightAbove];
        component.heightBelow = [component.eqChildren[1] heightBelow] + [component.eqChildren[1] heightAbove];
        double h = self.divisionPadding * (component.heightAbove + component.heightBelow);
        component.heightAbove += h/2;
        component.heightBelow += h/2;
    }
    else if(component.eqFormat == SUMMATION) {
        [self makeSizeRequests:component.eqChildren[0] size:size*self.decaySummation];
        [self makeSizeRequests:component.eqChildren[1] size:size*self.decaySummation];
        [self makeSizeRequests:component.eqChildren[2] size:size];
        component.width = [component.eqChildren[2] width];
        if(fmax([component.eqChildren[0] width], [component.eqChildren[1] width]) > ([component.eqChildren[2] heightAbove]+[component.eqChildren[2] heightBelow])/1.350617284) {
            // the top and bottom don't fit in the summation symbol
            component.width += fmax([component.eqChildren[0] width], [component.eqChildren[1] width]);
        }
        else {
            // room for the top and bottom of the summation symbol
            component.width += ([component.eqChildren[2] heightAbove]+[component.eqChildren[2] heightBelow])/1.350617284;
        }
        component.heightAbove = [component.eqChildren[1] heightAbove]+[component.eqChildren[1] heightBelow]+[component.eqChildren[2] heightAbove];
        component.heightBelow = [component.eqChildren[0] heightAbove]+[component.eqChildren[0] heightBelow]+[component.eqChildren[2] heightBelow];
    }
    else if(component.eqFormat == INTEGRATION) {
        [self makeSizeRequests:component.eqChildren[0] size:size*self.decayIntegration];
        [self makeSizeRequests:component.eqChildren[1] size:size*self.decayIntegration];
        [self makeSizeRequests:component.eqChildren[2] size:size];
        component.width = [component.eqChildren[2] width];
        if(fmax([component.eqChildren[0] width], [component.eqChildren[1] width]) > ([component.eqChildren[2] heightAbove]+[component.eqChildren[2] heightBelow])/3.710691824) {
            // the top and bottom don't fit in the summation symbol
            component.width += fmax([component.eqChildren[0] width], [component.eqChildren[1] width]);
        }
        else {
            // room for the top and bottom of the summation symbol
            component.width += ([component.eqChildren[2] heightAbove]+[component.eqChildren[2] heightBelow])/3.710691824;
        }
        
        component.heightAbove = [component.eqChildren[1] heightAbove]+[component.eqChildren[1] heightBelow]+[component.eqChildren[2] heightAbove];
        component.heightBelow = [component.eqChildren[0] heightAbove]+[component.eqChildren[0] heightBelow]+[component.eqChildren[2] heightBelow];
    }
    else if(component.eqFormat == EXPONENT) {
        [self makeSizeRequests:component.eqChildren[0] size:size*self.decayExponent];
        component.width = [component.eqChildren[0] width];
        component.heightAbove = [component.eqChildren[0] heightAbove] + [component.eqChildren[0] heightBelow];
        component.heightBelow = 0;
    }
    else if(component.eqFormat == SQUAREROOT) {
        [self makeSizeRequests:component.eqChildren[0] size:size*self.decayRoot];
        component.heightAbove = [component.eqChildren[0] heightAbove];
        component.heightBelow = [component.eqChildren[0] heightBelow];
        double h = component.heightAbove+component.heightBelow;
        component.width = [component.eqChildren[0] width] + 0.5*h + self.horizontalRootPadding*h;
        component.heightAbove += 0.1*h;
    }
    else if(component.eqFormat == LOGBASE) {
        [self makeSizeRequests:component.eqChildren[0] size:size*self.decayLog];
        [self makeSizeRequests:component.eqChildren[1] size:size];
        component.heightAbove = [component.eqChildren[1] heightAbove];
        component.heightBelow = fmax([component.eqChildren[0] heightAbove]+[component.eqChildren[0] heightBelow], [component.eqChildren[1] heightBelow]);
        component.width = [component.eqChildren[0] width] + [component.eqChildren[1] width] + 1.278*([component.eqChildren[0] heightBelow] + [component.eqChildren[0] heightBelow]) + ([component.eqChildren[0] heightAbove]+[component.eqChildren[0] heightBelow])/4;
    }
}

- (void) grantSizeRequests {
    double x, y, width, heightBelow, heightAbove;
    x = 0;
    double totalHeight = self.eq.heightAbove + self.eq.heightBelow;
    if(self.frame.size.width > self.eq.width && self.frame.size.height > self.eq.heightAbove + self.eq.heightBelow) {
        // ample space for everyone!
        width = self.eq.width;
        heightAbove = self.eq.heightAbove;
        heightBelow = self.eq.heightBelow;
        y = heightBelow/totalHeight * self.frame.size.height;
    }
    else {
        // we must ration space
        double ratio;
        if(self.frame.size.width * totalHeight > self.frame.size.height * self.eq.width) {
            ratio = self.frame.size.height / totalHeight;
        }
        else {
            ratio = self.frame.size.width / self.eq.width;
        }
        ratio /= 1.2;
        heightAbove = ratio * self.eq.heightAbove;
        heightBelow = ratio * self.eq.heightBelow;
        y = heightBelow/totalHeight * self.frame.size.height/ratio;
        width = ratio * self.eq.width;
    }
    [self grantSizeRequests:self.eq x:x y:y width:width heightAbove:heightAbove heightBelow:heightBelow];
    int q = 412;
    q = 7;
}

- (void) grantSizeRequests: (EquationFieldComponent*) component x: (double) x y: (double) y width: (double) width heightAbove: (double) heightAbove heightBelow: (double) heightBelow {
    
    if(component.eqFormat == LEAF) {
        // do nothing
    }
    else if(component.eqFormat == NORMAL) {
        double ratio = width / component.width;
        
        double newX = x;
        for(int i=0; i<component.eqChildren.count; i++) {
            [self grantSizeRequests:component.eqChildren[i] x:newX y:y width:ratio*[component.eqChildren[i] width] heightAbove:ratio*[component.eqChildren[i] heightAbove] heightBelow:ratio*[component.eqChildren[i] heightBelow]];
            newX += [component.eqChildren[i] width];
        }
    }
    else if(component.eqFormat == DIVISION) {
        double ratio = width / component.width;
        double h = (component.heightAbove + component.heightBelow) - (component.heightAbove + component.heightBelow)/(1 + self.divisionPadding);
        h *= ratio;
        if([component.eqChildren[0] width] > [component.eqChildren[1] width]) {
            double centerSpacing = ([component.eqChildren[0] width] - [component.eqChildren[1] width]) / [component.eqChildren[0] width] / 2 * width;
            [self grantSizeRequests:component.eqChildren[0] x:x y:y+ratio*[component.eqChildren[0] heightBelow]+h/2 width:ratio*[component.eqChildren[0] width] heightAbove:ratio*[component.eqChildren[0] heightAbove] heightBelow:ratio*[component.eqChildren[0] heightBelow]];
            [self grantSizeRequests:component.eqChildren[1] x:x + centerSpacing y:y-ratio*[component.eqChildren[1] heightAbove]-h/2 width:ratio*[component.eqChildren[1] width] heightAbove:ratio*[component.eqChildren[1] heightAbove] heightBelow:ratio*[component.eqChildren[1] heightBelow]];
        }
        else {
            double centerSpacing = ([component.eqChildren[1] width] - [component.eqChildren[0] width]) / [component.eqChildren[1] width] * width / 2;
            [self grantSizeRequests:component.eqChildren[1] x:x y:y-ratio*[component.eqChildren[1] heightAbove]-h/2 width:width heightAbove:ratio*[component.eqChildren[1] heightAbove] heightBelow:ratio*[component.eqChildren[1] heightBelow]];
            [self grantSizeRequests:component.eqChildren[0] x:x + centerSpacing y:y+ratio*[component.eqChildren[0] heightBelow]+h/2 width:ratio*[component.eqChildren[0] width] heightAbove:ratio*[component.eqChildren[0] heightAbove] heightBelow:ratio*[component.eqChildren[0] heightBelow]];
        }
    }
    else if(component.eqFormat == SUMMATION) {
        double ratio = width / component.width;
        double widthOfFirstHalf = (component.width-[component.eqChildren[2] width])/component.width*width;
        double centerX = x + widthOfFirstHalf/2;
        [self grantSizeRequests:component.eqChildren[0] x:centerX - ratio*[component.eqChildren[0] width]/2 y:y-ratio*([component.eqChildren[0] heightAbove] + [component.eqChildren[2] heightBelow]) width:ratio*[component.eqChildren[0] width] heightAbove:ratio*[component.eqChildren[0] heightAbove] heightBelow:ratio*[component.eqChildren[0] heightBelow]];
        
        [self grantSizeRequests:component.eqChildren[1] x:centerX - ratio*[component.eqChildren[1] width]/2 y:y+ratio*([component.eqChildren[2] heightAbove] + [component.eqChildren[1] heightBelow]) width:ratio*[component.eqChildren[1] width] heightAbove:ratio*[component.eqChildren[1] heightAbove] heightBelow:ratio*[component.eqChildren[1] heightBelow]];
        
        [self grantSizeRequests:component.eqChildren[2] x:x+widthOfFirstHalf y:y width:ratio * [component.eqChildren[2] width] heightAbove:ratio*[component.eqChildren[2] heightAbove] heightBelow:ratio*[component.eqChildren[2] heightBelow]];
    }
    else if(component.eqFormat == INTEGRATION) {
        double ratio = width / component.width;
        double widthOfFirstHalf = (component.width-[component.eqChildren[2] width])/component.width*width;
        double centerX = x + widthOfFirstHalf/2;
        [self grantSizeRequests:component.eqChildren[0] x:centerX - ratio*[component.eqChildren[0] width]/2 y:y-ratio*([component.eqChildren[2] heightBelow] + [component.eqChildren[0] heightAbove]) width:ratio*[component.eqChildren[0] width] heightAbove:ratio*[component.eqChildren[0] heightAbove] heightBelow:ratio*[component.eqChildren[0] heightBelow]];
        [self grantSizeRequests:component.eqChildren[1] x:centerX - ratio*[component.eqChildren[1] width]/2 y:y+ratio*([component.eqChildren[2] heightAbove] + [component.eqChildren[1] heightBelow]) width:ratio*[component.eqChildren[1] width] heightAbove:ratio*[component.eqChildren[1] heightAbove] heightBelow:ratio*[component.eqChildren[1] heightBelow]];
        [self grantSizeRequests:component.eqChildren[2] x:x+widthOfFirstHalf y:y width:ratio * [component.eqChildren[2] width] heightAbove:ratio*[component.eqChildren[2] heightAbove] heightBelow:ratio*[component.eqChildren[2] heightBelow]];
    }
    else if(component.eqFormat == EXPONENT) {
        double ratio = width / component.width;
        [self grantSizeRequests:component.eqChildren[0] x:x y:y+heightAbove/2 width:ratio*[component.eqChildren[0] width] heightAbove:ratio*[component.eqChildren[0] heightAbove] heightBelow:ratio*[component.eqChildren[0] heightBelow]];
    }
    else if(component.eqFormat == SQUAREROOT) {
        double ratio = width / component.width;
        double wr = [component.eqChildren[0] width]/component.width;
        double h = ratio*([component.eqChildren[0] heightAbove] + [component.eqChildren[0] heightBelow])/11;
        [self grantSizeRequests:component.eqChildren[0] x:x+5*h y:y width:width*wr heightAbove:ratio*[component.eqChildren[0] heightAbove]-h heightBelow:ratio*[component.eqChildren[0] heightBelow]];
    }
    else if(component.eqFormat == LOGBASE) {
        double ratio = width / component.width;
        double newX = x + 1.278*ratio*([component.eqChildren[1] heightAbove] + [component.eqChildren[1] heightBelow]);
        [self grantSizeRequests:component.eqChildren[0] x:newX y:y-ratio*([component.eqChildren[0] heightBelow]+[component.eqChildren[1] heightBelow])/2 width:ratio*[component.eqChildren[0] width] heightAbove:ratio*[component.eqChildren[0] heightAbove] heightBelow:ratio*[component.eqChildren[0] heightBelow]];
        newX += [component.eqChildren[0] width];
        [self grantSizeRequests:component.eqChildren[1] x:newX y:y-ratio*[component.eqChildren[1] heightBelow]/2 width:ratio*[component.eqChildren[1] width] heightAbove:ratio*[component.eqChildren[1] heightAbove] heightBelow:ratio*[component.eqChildren[1] heightBelow]];
    }
    component.x = x;
    component.y = y;
    component.width = width;
    component.heightBelow = heightBelow;
    component.heightAbove = heightAbove;
}

- (void) completeViewUpdate {
    [self completeViewUpdate:self.eq];
}

- (void) completeViewUpdate: (EquationFieldComponent*) component {
    if(component.eqFormat == LEAF) {
        [component.eqTextField removeFromSuperview];
        int size = component.heightAbove+component.heightBelow;
        size *= 1;
        [component.eqTextField setFrame:NSMakeRect(component.x, component.y-size/2, component.width+5, component.heightAbove+component.heightBelow)];
        NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:size]};
        component.eqTextField.attributedStringValue = [[NSAttributedString alloc] initWithString:component.eqTextField.stringValue attributes:attr];
        [component.eqTextField setEditable:false];
        [self addSubview:component.eqTextField];
    }
    else if(component.eqFormat == NORMAL) {
        // do nothing
    }
    else if(component.eqFormat == DIVISION) {
        [component.eqTextField removeFromSuperview];
        int size = component.heightAbove+component.heightBelow;
        size *= 0.3;
        if(size >= 100) {
            size = 99;
        }
        [component.eqTextField setFrame:NSMakeRect(component.x, component.y-size/20, component.width+100, size)];
        NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:size]};
        NSMutableString *str = [[NSMutableString alloc] init];
        int len = 3.2*component.width/size;
        for(int i=0; i<len; i++) {
            [str appendString:@"_"];
        }
        component.eqTextField.attributedStringValue = [[NSAttributedString alloc] initWithString:str attributes:attr];
        [component.eqTextField setEditable:false];
        [self addSubview:component.eqTextField];
    }
    else if(component.eqFormat == SUMMATION) {
        [component.eqImageView removeFromSuperview];
        double h = [component.eqChildren[2] heightAbove]+[component.eqChildren[2] heightBelow];
        double w = h/1.350617284;
        
        if(fmax([component.eqChildren[0] width], [component.eqChildren[1] width]) > ([component.eqChildren[2] heightAbove]+[component.eqChildren[2] heightBelow])/1.350617284) {
            double adjFactor = fmax([component.eqChildren[0] width], [component.eqChildren[1] width])/2;
            [component.eqImageView setFrame:NSMakeRect(component.x+adjFactor-w/2, component.y-0.4*h, w, h)];
        }
        else {
            [component.eqImageView setFrame:NSMakeRect(component.x, component.y-0.4*h, w, h)];
        }
        [self addSubview: component.eqImageView];
    }
    else if(component.eqFormat == INTEGRATION) {
        [component.eqImageView removeFromSuperview];
        double h = [component.eqChildren[2] heightAbove]+[component.eqChildren[2] heightBelow];
        double w = h/3.710691824;
        
        if(fmax([component.eqChildren[0] width], [component.eqChildren[1] width]) > ([component.eqChildren[2] heightAbove]+[component.eqChildren[2] heightBelow])/3.710691824) {
            double adjFactor = fmax([component.eqChildren[0] width], [component.eqChildren[1] width])/2;
            [component.eqImageView setFrame:NSMakeRect(component.x+adjFactor-w/2, component.y-h*0.4, w, h)];
        }
        else {
            [component.eqImageView setFrame:NSMakeRect(component.x, component.y-h*0.4, w, h)];
        }
        [self addSubview: component.eqImageView];
    }
    else if(component.eqFormat == EXPONENT) {
        // do nothing
    }
    else if(component.eqFormat == SQUAREROOT) {
        [component.eqImageView removeFromSuperview];
        double h = component.heightAbove+component.heightBelow;
        double w = h/1.866013072;
        [component.eqImageView setFrame:NSMakeRect(component.x, component.y-h/2, w, h)];
        [self addSubview:component.eqImageView];
        
        [component.eqTextField removeFromSuperview];
        int size = h;
        [component.eqTextField setFrame:NSMakeRect(component.x+0.44*h, component.y+h*0.41, component.width+100, size)];
        NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:size]};
        NSMutableString *str = [[NSMutableString alloc] init];
        double wid = [component.eqChildren[0] width];
        int len = 3.3*wid/size;
        for(int i=0; i<len; i++) {
            [str appendString:@"_"];
        }
        component.eqTextField.attributedStringValue = [[NSAttributedString alloc] initWithString:str attributes:attr];
        [component.eqTextField setEditable:false];
        [self addSubview:component.eqTextField];
    }
    else if(component.eqFormat == LOGBASE) {
        [component.eqTextField removeFromSuperview];
        double h = [component.eqChildren[1] heightAbove] + [component.eqChildren[1] heightBelow];
        int size = h;
        [component.eqTextField setFrame:NSMakeRect(component.x, component.y-0.5*h, component.width+100, size)];
        NSDictionary *attr = @{NSFontAttributeName : [self.fontManager getFont:size]};
        component.eqTextField.attributedStringValue = [[NSAttributedString alloc] initWithString:@"log" attributes:attr];
        [component.eqTextField setEditable:false];
        [self addSubview:component.eqTextField];
    }
    for(int i=0; i<component.eqChildren.count; i++) {
        [self completeViewUpdate:component.eqChildren[i]];
    }
}

- (NSString*) toLaTeX: (EquationFieldComponent*) component {
    if(component.eqFormat == LEAF) {
        return component.eqTextField.stringValue;
    }
    else if(component.eqFormat == NORMAL) {
        NSMutableString *str = [[NSMutableString alloc] init];
        for(int i=0; i<component.eqChildren.count; i++) {
            [str appendString:[self toLaTeX:component.eqChildren[i]]];
        }
        return str;
    }
    else if(component.eqFormat == DIVISION) {
        return [[NSString alloc] initWithFormat:@"\\frac{%@}{%@}", [self toLaTeX:component.eqChildren[0]], [self toLaTeX:component.eqChildren[1]]];
    }
    else if(component.eqFormat == SUMMATION) {
        return [[NSString alloc] initWithFormat:@"\\sum_{%@}^{%@}{%@}", [self toLaTeX:component.eqChildren[0]], [self toLaTeX:component.eqChildren[1]], [self toLaTeX:component.eqChildren[2]]];
    }
    else if(component.eqFormat == INTEGRATION) {
        return [[NSString alloc] initWithFormat:@"\\int_{%@}^{%@}{%@}", [self toLaTeX:component.eqChildren[0]], [self toLaTeX:component.eqChildren[1]], [self toLaTeX:component.eqChildren[2]]];
    }
    else if(component.eqFormat == EXPONENT) {
        return [[NSString alloc] initWithFormat:@"^{%@}", [self toLaTeX:component.eqChildren[0]]];
    }
    else if(component.eqFormat == SQUAREROOT) {
        return [[NSString alloc] initWithFormat:@"\\sqrt{%@}", [self toLaTeX:component.eqChildren[0]]];
    }
    else if(component.eqFormat == LOGBASE) {
        return [[NSString alloc] initWithFormat:@"\\log_{%@}{%@}", [self toLaTeX:component.eqChildren[0]], [self toLaTeX:component.eqChildren[1]]];
    }
    return nil;
}

- (NSString*) toString: (EquationFieldComponent*) eq {
    if(eq.eqFormat == LEAF) {
        return eq.eqTextField.stringValue;
    }
    else if(eq.eqFormat == NORMAL) {
        NSMutableString *str = [[NSMutableString alloc] initWithString:@"("];
        for(int i=0; i<eq.eqChildren.count; i++) {
            [str appendString:[self toString:eq.eqChildren[i]]];
        }
        [str appendString:@")"];
        return str;
    }
    else if(eq.eqFormat == EXPONENT) {
        return [[NSString alloc] initWithFormat:@"^(%@)", [self toString:eq.eqChildren[0]]];
    }
    else if(eq.eqFormat == DIVISION) {
        return [[NSString alloc] initWithFormat:@"(%@)/(%@)", [self toString:eq.eqChildren[0]], [self toString:eq.eqChildren[1]]];
    }
    else if(eq.eqFormat == LOGBASE) {
        return [[NSString alloc] initWithFormat:@"log(%@,%@)", [self toString:eq.eqChildren[0]], [self toString:eq.eqChildren[1]]];
    }
    
    return @"";
}

@end
