
//
//  MathMatrix.m
//  Calculator
//
//  Created by Thomas Redding on 12/24/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathMatrix.h"

@implementation MathMatrix

- (MathObject*)init {
    self.objectType = MATHMATRIX;
    
    self.arr = [[NSMutableArray alloc] init];
    self.degreesOfFreedom = [[NSMutableArray alloc] init];
    
    return self;
}

- (MathObject*) initWithArr: (NSArray*) arr {
    self.objectType = MATHMATRIX;
    self.arr = [[NSMutableArray alloc] initWithArray:arr];
    self.degreesOfFreedom = [[NSMutableArray alloc] init];
    int count = 0;
    for(int i=0; i<self.arr.count; i++) {
        count += [[self.arr objectAtIndex:i] getDegreesOfFreedom];
        [self.degreesOfFreedom addObject:[NSNumber numberWithInt:count]];
    }
    return self;
}

- (MathObject*)getObjectAt: (int) row column: (int) column {
    return [self getObjectAt:self.width*row+column];
}

- (NSString*)toString {
    NSMutableString *str = [[NSMutableString alloc] initWithString:@""];
    for(int i=0; i<self.arr.count; i++) {
        [str appendString:[[self.arr objectAtIndex:i] toString]];
        if(i%self.width == self.width-1) {
            [str appendString:@"\n"];
        }
        else {
            [str appendString:@", "];
        }
    }
    return str;
}

// TODO
- (id) copy {
    MathMatrix* obj = [[MathMatrix alloc] init];
    return obj;
}


@end
