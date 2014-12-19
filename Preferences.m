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
    }
}

- (NSString*) load {
    NSString *pathA = [[NSBundle mainBundle] bundlePath];
    NSMutableString *path = [[NSMutableString alloc] initWithString: pathA];
    [path appendString:@"/Contents/Resources/Preferences.txt"];
    NSError *err = nil;
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
    NSLog(@"L=%@", str);
    return str;
}

- (void) save {
    NSString *pathA = [[NSBundle mainBundle] bundlePath];
    NSMutableString *path = [[NSMutableString alloc] initWithString: pathA];
    [path appendString:@"/Contents/Resources/Preferences.txt"];
    NSError *err = nil;
    NSString *newContents = [self toString];
    NSLog(@"S=%@", newContents);
    [newContents writeToFile:path atomically:false encoding:NSUTF8StringEncoding error:&err];
}

- (NSString*) toString {
    NSString *str;
    if(self.drawAxes) {
        str = [[NSString alloc] initWithFormat:@"drawAxes:true"];
    }
    else {
        str = [[NSString alloc] initWithFormat:@"drawAxes:false"];
    }
    return str;
}

@end
