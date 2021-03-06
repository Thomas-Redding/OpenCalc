//
//  Preferences.m
//  Calculator
//
//  Created by Thomas Redding on 12/18/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "Preferences.h"

@implementation Preferences

- (Preferences*) init {
    // set defaults
    self.drawAxes = false;
    self.doesScrollZoom = false;
    
    // update with user-prefences
    NSString* str = [self load];
    NSArray *arr = [str componentsSeparatedByString:@";"];
    for(int i=0; i<arr.count; i++) {
        [self evaluate:[arr objectAtIndex:i]];
    }
    
    return self;
}

- (void) evaluate: (NSString*) str {
    NSArray *arr = [str componentsSeparatedByString:@":"];
    if([[arr objectAtIndex:0] isEqual: @"drawAxes"]) {
        if([[arr objectAtIndex:1] isEqual: @"true"]) {
            self.drawAxes = true;
        }
        else {
            self.drawAxes = false;
        }
    }
    else if([[arr objectAtIndex:0] isEqual: @"doesScrollZoom"]) {
        if([[arr objectAtIndex:1] isEqual: @"true"]) {
            self.doesScrollZoom = true;
        }
        else {
            self.doesScrollZoom = false;
        }
    }
}

- (NSString*) toString {
    NSMutableString *str = [[NSMutableString alloc] init];
    
    if(self.drawAxes) {
        [str appendString:@"drawAxes:true"];
    }
    else {
        [str appendString:@"drawAxes:false"];
    }
    
    if(self.drawAxes) {
        [str appendString:@"doesScrollZoom:true"];
    }
    else {
        [str appendString:@"doesScrollZoom:false"];
    }
    
    return str;
}

- (NSString*) load {
    NSString *pathA = [[NSBundle mainBundle] bundlePath];
    NSMutableString *path = [[NSMutableString alloc] initWithString: pathA];
    [path appendString:@"/Contents/Resources/Preferences.txt"];
    NSError *err = nil;
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
    return str;
}

- (void) save {
    NSString *pathA = [[NSBundle mainBundle] bundlePath];
    NSMutableString *path = [[NSMutableString alloc] initWithString: pathA];
    [path appendString:@"/Contents/Resources/Preferences.txt"];
    NSError *err = nil;
    NSString *newContents = [self toString];
    [newContents writeToFile:path atomically:false encoding:NSUTF8StringEncoding error:&err];
}

@end
