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
        NSString *strB;
        
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
        else if([self.string characterAtIndex:0] == '[') {
            // clear whitespace, tabs, etc.
            NSArray* words = [self.string componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
            self.string = [words componentsJoinedByString:@""];
            
            if([self.string characterAtIndex:self.string.length-1] != ']') {
                // func doesn't end with ']', so it's not valid
                return;
            }
            
            self.type = '[';
            int paraLevel = 0;
            int comma = -1;
            for(int i=0; i<self.string.length; i++) {
                if([self.string characterAtIndex:i] == '[' || [self.string characterAtIndex:i] == '(') {
                    paraLevel++;
                }
                else if([self.string characterAtIndex:i] == ']' || [self.string characterAtIndex:i] == ')') {
                    paraLevel--;
                }
                else if(paraLevel == 1) {
                    if([self.string characterAtIndex:i] == ',') {
                        if(comma == -1) {
                            comma = i;
                        }
                        else {
                            // multiple commas
                            return;
                        }
                    }
                }
            }
            
            if(comma == -1 || paraLevel != 0) {
                // no commas
                return;
            }
            
            str = [[NSString alloc] initWithFormat:@"%@x(t)=%@", funcName , [self.string substringWithRange:NSMakeRange(1, comma-1)]];
            
            strB = [[NSString alloc] initWithFormat:@"%@y(t)=%@", funcName, [self.string substringWithRange:NSMakeRange(comma+1, self.string.length-comma-2)]];
            
            NSString *funcNameX = [[NSString alloc] initWithFormat:@"%@x", funcName];
            NSString *funcNameY = [[NSString alloc] initWithFormat:@"%@y", funcName];
            
            [self.brain runAlgebra:str];
            [self.brain runAlgebra:strB];
            
            // continue special stuff
            self.points = [[NSMutableArray alloc] init];
            double min = 0;
            double max = 1;
            double x, y, t = 0;
            for(int i=0; i<=steps; i++) {
                t = (max-min)*i/steps;
                x = [self.brain graphRun:funcNameX x:t];
                y = [self.brain graphRun:funcNameY x:t];
                [self.points addObject:[NSNumber numberWithDouble:x]];
                [self.points addObject:[NSNumber numberWithDouble:y]];
                if(x == INFINITY || y == INFINITY) {
                    [self.points addObject:[NSNumber numberWithBool:false]];
                }
                else {
                    [self.points addObject:[NSNumber numberWithBool:true]];
                }
            }
            // parametric graphing is special and was taken care of immediately above this point
            return;
        }
        else {
            self.type = '=';
            if([self.string characterAtIndex:0] == '=') {
                self.string = [self.string substringFromIndex:1];
            }
            str = [[NSString alloc] initWithFormat:@"%@(x)=%@", funcName , self.string];
        }
        
        [self.brain runAlgebra:str];
        
        self.points = [[NSMutableArray alloc] init];
        double x;
        double y;
        for(int i=0; i<=steps; i++) {
            x = (end-start)*i/steps+start;
            y = [self.brain graphRun:funcName x:x];
            [self.points addObject:[NSNumber numberWithDouble:x]];
            [self.points addObject:[NSNumber numberWithDouble:y]];
            if(y == INFINITY) {
                if(i == 0 || i == steps) {
                    // the end points are always true
                    [self.points addObject:[NSNumber numberWithBool:true]];
                }
                else {
                    [self.points addObject:[NSNumber numberWithBool:false]];
                }
            }
            else {
                [self.points addObject:[NSNumber numberWithBool:true]];
            }
        }
        
        // if both the neighboring points of a "false" point have the same sign (both positive or both negative), then we should label this point "true"
        for(int i=3; i<self.points.count; i+=3) {
            if([[self.points objectAtIndex:i+2] boolValue]) {
                // point is true, nothing to do
            }
            else {
                // point is false, determine if it should be true
                if([[self.points objectAtIndex:i-2] doubleValue] != INFINITY && [[self.points objectAtIndex:i+4] doubleValue] != INFINITY) {
                    if([[self.points objectAtIndex:i-2] doubleValue] > 0 && [[self.points objectAtIndex:i+4] doubleValue] > 0) {
                        [self.points setObject:[NSNumber numberWithBool:true] atIndexedSubscript:i+2];
                    }
                    else if([[self.points objectAtIndex:i-2] doubleValue] < 0 && [[self.points objectAtIndex:i+4] doubleValue] < 0) {
                        [self.points setObject:[NSNumber numberWithBool:true] atIndexedSubscript:i+2];
                        [self.points setObject:[NSNumber numberWithDouble:-INFINITY] atIndexedSubscript:i+1];
                    }
                }
            }
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
