//
//  GraphingFunction.m
//  Calculator
//
//  Created by Thomas Redding on 12/16/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "GraphingFunction.h"

@implementation GraphingFunction

- (GraphingFunction*) initWithBrain: (Brain*) b {
    self.brain = b;
    self.string = @"";
    self.isVisible = true;
    self.points = [[NSMutableArray alloc] init];
    self.type = '=';
    return self;
}

- (NSString*) getName {
    return [[NSString alloc] initWithFormat:@"f%@", [self intToCharacter:self.index]];
}

- (void) update: (double) start end: (double) end steps: (int) steps {
    
    NSString *ssss = self.string;
    
    if(ssss.length == 0) {
        // empty string
        
        NSString *funcName = [self getName];
        NSString *str = [[NSString alloc] initWithFormat:@"%@(x)=", funcName];
        [self.brain runAlgebra:str];
        self.points = [[NSMutableArray alloc] init];
    }
    else {
        NSString *funcName = [[NSString alloc] initWithFormat:@"f%@", [self intToCharacter:self.index]];
        NSString *str;
        
        if([self.string characterAtIndex:0] == '<') {
            self.type = '<';
            str = [[NSString alloc] initWithFormat:@"%@(x)=%@", funcName , [self.string substringFromIndex:1]];
        }
        else if([self.string characterAtIndex:0] == '>') {
            self.type = '>';
            str = [[NSString alloc] initWithFormat:@"%@(x)=%@", funcName , [self.string substringFromIndex:1]];
        }
        else if([self.string characterAtIndex:0] == 8804) {
            self.type = 8804;
            str = [[NSString alloc] initWithFormat:@"%@(x)=%@", funcName , [self.string substringFromIndex:1]];
        }
        else if([self.string characterAtIndex:0] == 8805) {
            self.type = 8805;
            str = [[NSString alloc] initWithFormat:@"%@(x)=%@", funcName , [self.string substringFromIndex:1]];
        }
        else if([self.string characterAtIndex:0] == 8800) {
            self.type = 8800;
            str = [[NSString alloc] initWithFormat:@"%@(x)=%@", funcName , [self.string substringFromIndex:1]];
        }
        else {
            self.type = '=';
            str = [[NSString alloc] initWithFormat:@"%@(x)=%@", funcName , self.string];
        }
        
        [self.brain runAlgebra:str];
        
        self.points = [[NSMutableArray alloc] init];
        double x = start;
        for(int i=0; i<=steps; i++) {
            x += (end-start)/steps;
            [self.points addObject:[NSNumber numberWithDouble:x]];
            [self.points addObject:[NSNumber numberWithDouble:[self.brain graphRun:funcName x:x]]];
            [self.points addObject:[NSNumber numberWithBool:true]];
        }
    }
}

- (NSString*) intToCharacter: (unsigned long) input {
    if(input == 0)
        return @"a";
    else if(input == 1)
        return @"b";
    else if(input == 2)
        return @"c";
    else if(input == 3)
        return @"d";
    else if(input == 4)
        return @"e";
    else if(input == 5)
        return @"f";
    else if(input == 6)
        return @"g";
    else if(input == 7)
        return @"h";
    else if(input == 8)
        return @"i";
    else if(input == 9)
        return @"j";
    else if(input == 10)
        return @"k";
    else if(input == 11)
        return @"l";
    else if(input == 12)
        return @"m";
    else if(input == 13)
        return @"n";
    else if(input == 14)
        return @"o";
    else if(input == 15)
        return @"p";
    else if(input == 16)
        return @"q";
    else if(input == 17)
        return @"r";
    else if(input == 18)
        return @"s";
    else if(input == 19)
        return @"t";
    else if(input == 20)
        return @"u";
    else if(input == 21)
        return @"v";
    else if(input == 22)
        return @"w";
    else if(input == 23)
        return @"x";
    else if(input == 24)
        return @"y";
    return @"z";
}

@end
