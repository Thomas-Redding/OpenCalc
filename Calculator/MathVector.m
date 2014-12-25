//
//  MathVector.m
//  Calculator
//
//  Created by Thomas Redding on 12/23/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathVector.h"

@implementation MathVector

- (MathObject*)init {
    self.objectType = MATHVECTOR;
    
    self.arr = [[NSMutableArray alloc] init];
    self.degreesOfFreedom = [[NSMutableArray alloc] init];
    
    return self;
}

- (MathObject*) initWithArr: (NSArray*) arr {
    self.objectType = MATHVECTOR;
    self.arr = [[NSMutableArray alloc] initWithArray:arr];
    self.degreesOfFreedom = [[NSMutableArray alloc] init];
    int count = 0;
    for(int i=0; i<self.arr.count; i++) {
        count += [[self.arr objectAtIndex:i] getDegreesOfFreedom];
        [self.degreesOfFreedom addObject:[NSNumber numberWithInt:count]];
    }
    return self;
}

- (int) getDegreesOfFreedom {
    return [[self.degreesOfFreedom objectAtIndex:self.degreesOfFreedom.count-1] intValue];
}

- (NSString*)toString {
    NSMutableString *str = [[NSMutableString alloc] initWithString:@"["];
    for(int i=0; i<self.arr.count; i++) {
        if(i != 0) {
            [str appendString:@","];
        }
        [str appendString:[[self.arr objectAtIndex:i] toString]];
    }
    [str appendString:@"]"];
    return str;
}

- (double)getDouble {
    return [[self.arr objectAtIndex:0] getDouble];
}

- (double)getDouble: (int) index {
    if(index >= [[self.degreesOfFreedom objectAtIndex:self.degreesOfFreedom.count-1] intValue]) {
        // error
        return [[self.arr objectAtIndex:0] getDouble];
    }
    else {
        int count = 0;
        int step;
        for(int i=0; i<5; i++) {
            step = [[self.degreesOfFreedom objectAtIndex:i] intValue];
            if(index < count + step) {
                return [[self.arr objectAtIndex:i] getDouble:i-count];
            }
            count += step;
        }
    }
    return [[self.arr objectAtIndex:0] getDouble];
}

- (void)setDouble: (double) newValue {
    [[self.arr objectAtIndex:0] setDouble:newValue];
}

- (void)setDouble: (int) index newValue: (double) newValue {
    if(index >= [[self.degreesOfFreedom objectAtIndex:self.degreesOfFreedom.count-1] intValue]) {
        // error
        [[self.arr objectAtIndex:0] setDouble:newValue];
    }
    else {
        int count = 0;
        int step;
        for(int i=0; i<5; i++) {
            step = [[self.degreesOfFreedom objectAtIndex:i] intValue];
            if(index < count + step) {
                [[self.arr objectAtIndex:i] setDouble:i-count newValue:newValue];
                return;
            }
            count += step;
        }
    }
    [[self.arr objectAtIndex:0] setDouble:newValue];
}

- (MathObject*)getObjectAt: (int) index {
    if(index >= self.arr.count) {
        return nil;
    }
    else {
        return [self.arr objectAtIndex:index];
    }
}

- (unsigned long) getLength {
    return self.arr.count;
}

- (void) addObject: (MathObject*) obj {
    [self.arr addObject: obj];
    [self.degreesOfFreedom addObject:[NSNumber numberWithInt:[obj getDegreesOfFreedom]]];
}

// TODO
- (id) copy {
    MathVector* obj = [[MathVector alloc] init];
    return obj;
}


@end
