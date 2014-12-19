//
//  Preferences.h
//  Calculator
//
//  Created by Thomas Redding on 12/18/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Preferences : NSObject

@property BOOL drawAxes;

- (Preferences*) init;
- (void) evaluate: (NSString*) str;
- (NSString*) load;
- (void) save;
- (NSString*) toString;


@end
