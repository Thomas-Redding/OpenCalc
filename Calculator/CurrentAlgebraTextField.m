//
//  CurrentAlgebraTextField.m
//  Calculator
//
//  Created by Thomas Redding on 10/3/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "CurrentAlgebraTextField.h"

@implementation CurrentAlgebraTextField

- (void) giveParent: (Tab*) parent {
    self.parent = parent;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

-(bool)textView:(NSTextView *)aTextView doCommandBySelector: (SEL)aSelector {
    if(!strncmp(sel_getName(aSelector), "moveUp", 6)) {
        [self.parent childToParentMessage:@"moveUp"];
    }
    else if(!strncmp(sel_getName(aSelector), "moveDown", 6)) {
        [self.parent childToParentMessage:@"moveDown"];
    }
    else {
        [self.parent childToParentMessage:@"other"];
    }
    return NO;
}


@end
