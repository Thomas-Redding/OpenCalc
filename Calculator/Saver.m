//
//  Saver.m
//  Calculator
//
//  Created by Thomas Redding on 10/3/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "Saver.h"

@implementation Saver

- (Saver*)initWithMemory: (NSMutableArray*) publicVariables publicFunctions: (NSMutableArray*) publicFunctions {
    self.publicVariable = publicVariables;
    self.publicFunction = publicFunctions;
    return self;
}

- (void) loadVariablesAndFunctions {
    NSString *pathA = [[NSBundle mainBundle] bundlePath];
    NSMutableString *path = [[NSMutableString alloc] initWithString: pathA];
    [path appendString:@"/Contents/Resources/Memory.txt"];
    NSError *err = nil;
    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
    NSArray *arr = [contents componentsSeparatedByString:@";"];
    MathVariable* var;
    for(int i=0; i<[arr count]; i++) {
        var = [self stringToVariable:arr[i]];
        if(var != NULL) {
            [self addVariable:var];
        }
    }
}

- (MathVariable*) stringToVariable: (NSString*) str {
    NSArray *arr = [str componentsSeparatedByString:@":"];
    MathVariable *rtn = [[MathVariable alloc] init];
    if([arr[0] isEqual: @"b"]) {
        // MATHBOOLEAN b:varName:0; or b:varName:1;
        if([arr count] != 3) {
            return NULL;
        }
        rtn.name = arr[1];
        rtn.variableValue = [[MathBoolean alloc] init];
        [rtn.variableValue setDouble:[arr[2] doubleValue]];
        return rtn;
    }
    else if([arr[0] isEqual: @"n"]) {
        // MATHNUMBER n:varName:realValue:imaginaryValue;
        if([arr count] != 4) {
            return NULL;
        }
        rtn.name = arr[1];
        rtn.variableValue = [[MathNumber alloc] init];
        [rtn.variableValue setDouble:[arr[2] doubleValue]];
        [rtn.variableValue setDouble:1 newValue:[arr[3] doubleValue]];
        return rtn;
    }
    else {
        // unknown variable type
        return NULL;
    }
}

- (void) saveVariablesAndFunctions {
    NSString *pathA = [[NSBundle mainBundle] bundlePath];
    NSMutableString *path = [[NSMutableString alloc] initWithString: pathA];
    [path appendString:@"/Contents/Resources/Memory.txt"];
    NSError *err = nil;
    NSMutableString *newContents = [[NSMutableString alloc] initWithString:@""];
    for(int i=0; i<[self.publicVariable count]; i++) {
        if([self.publicVariable[i] shouldSaveToHarddrive]) {
            [newContents appendString: [self variableToString:self.publicVariable[i]]];
            [newContents appendString:@";"];
        }
    }
    [newContents writeToFile:path atomically:false encoding:NSUTF8StringEncoding error:&err];
}

- (char) objectTypeToChar: (MathType) x {
    if(x == MATHBOOLEAN) {
        return 'b';
    }
    else if(x == MATHNUMBER) {
        return 'n';
    }
    else {
        return '?';
    }
}

- (NSString*) variableToString: (MathVariable*) var {
    if(var.variableValue.objectType == MATHBOOLEAN) {
        if([var.variableValue getDouble] == 1) {
            return [[NSString alloc] initWithFormat:@"b:%@:true", var.name];
        }
        else {
            return [[NSString alloc] initWithFormat:@"b:%@:false", var.name];
        }
    }
    else if(var.variableValue.objectType == MATHNUMBER) {
        return [[NSString alloc] initWithFormat:@"n:%@:%f:%f", var.name, [var.variableValue getDouble], [var.variableValue getDouble:1]];
    }
    else {
        return NULL;
    }
}

- (bool) addVariable: (MathVariable*) var {
    int i;
    for(i=0; i<[self.publicVariable count]; i++) {
        if([[self.publicVariable[i] name] isEqual: var.name]) {
            if([self.publicVariable[i] isEditable]) {
                var.isEditable = true;
                var.shouldSaveToHarddrive = true;
                self.publicVariable[i] = var;
                return true;
            }
            else {
                return false;
            }
        }
    }
    var.isEditable = true;
    var.shouldSaveToHarddrive = true;
    [self.publicVariable addObject:var];
    return true;
}

@end
