//
//  MathDeterminant.m
//  Calculator
//
//  Created by Thomas Redding on 12/25/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathDeterminant.h"

@implementation MathDeterminant

- (MathDeterminant*) init {
    self.name = @"det";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] != 1) {
        return NULL;
    }
    if([input[0] objectType] == MATHMATRIX) {
        MathMatrix *mat = input[0];
        if(mat.width*mat.width != mat.arr.count) {
            // matrix is not square
            return NULL;
        }
        
        MathObject *answer = [[MathNumber alloc] init];
        for(int i=0; i<mat.arr.count; i++) {
            if([[mat.arr objectAtIndex:i] objectType] != MATHNUMBER) {
                // matrix has non-numeric elements, so determinant is undefined
                return NULL;
            }
        }
        
        // If we have reached here, the matrix definitely has a determinant
        
        // copy matrix into 2d-array
        NSMutableArray *m = [[NSMutableArray alloc] init];
        for(int i=0; i<mat.width; i++) {
            [m addObject:[[NSMutableArray alloc] init]];
            for(int j=0; j<mat.width; j++) {
                [m[i] addObject:[[mat getObjectAt:i column:j] copy]];
            }
        }
        
        // calculate determinant of m
        MathMultiplication *mult = [[MathMultiplication alloc] init];
        MathDivision *div = [[MathDivision alloc] init];
        MathAddition *add = [[MathAddition alloc] init];
        MathNumber *negativeOne = [[MathNumber alloc] init];
        [negativeOne setDouble:-1];
        [answer setDouble:1];
        int i, j;
        for(i=0; i<mat.width; i++) {
            for(j=i; j<mat.width; j++)
            {
                if(![self isZero:m[j][i]])
                {
                    break;
                }
            }
            if(j == mat.width)
            {
                // return 0
                [answer setDouble:0];
                return answer;
            }
            if(i != j)
            {
                // switch rows i and j
                NSMutableArray *sto = m[i];
                m[i] = m[j];
                m[j] = sto;
                answer = [mult func:[[NSArray alloc] initWithObjects:negativeOne, answer, nil]];
            }
            answer = [mult func:[[NSArray alloc] initWithObjects:answer, m[i][i], nil]];
            
            // scale row i by 1/m[i][i]
            MathObject *factor = [m[i][i] copy];
            for(j=0; j<mat.width; j++) {
                m[i][j] = [div func:[[NSArray alloc] initWithObjects:m[i][j], factor, nil]];
            }
            
            for(j=i+1;j<mat.width;j++)
            {
                if(j!=i)
                {
                    // add scaled row
                    factor = [mult func:[[NSArray alloc] initWithObjects:negativeOne, m[j][i], nil]];
                    for(int k=0; k<mat.width; k++) {
                        m[j][k] = [add func:[[NSArray alloc] initWithObjects:m[j][k], [mult func:[[NSArray alloc] initWithObjects:factor, m[i][k], nil]], nil]];
                    }
                }
            }
        }
        return answer;
    }
    else {
        return NULL;
    }
}

- (bool) isZero: (MathNumber*) num {
    if([num getDouble] == 0 && [num getDouble:1] == 0) {
        return true;
    }
    return false;
}

@end
