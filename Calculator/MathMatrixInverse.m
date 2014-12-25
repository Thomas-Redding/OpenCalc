//
//  MathMatrixInverse.m
//  Calculator
//
//  Created by Thomas Redding on 12/25/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "MathMatrixInverse.h"

@implementation MathMatrixInverse

- (MathMatrixInverse*) init {
    self.name = @"inv";
    return self;
}

- (MathObject*)func: (NSArray*) input {
    if([input count] != 1) {
        return NULL;
    }
    if([input[0] objectType] != MATHMATRIX) {
        return NULL;
    }
    
    MathMatrix *mat = input[0];
    if(mat.width*mat.width != mat.arr.count) {
        // matrix is not square
        return NULL;
    }
    
    for(int i=0; i<mat.arr.count; i++) {
        if([[mat.arr objectAtIndex:i] objectType] != MATHNUMBER) {
            // matrix has non-numeric elements, so determinant is undefined
            return NULL;
        }
    }
    
    // If we have reached here, mat is a square matrix with only number elements
    
    // set up left (equal to mat) and right (identity) matrix as 2d-arrays
    NSMutableArray *leftMatrix = [[NSMutableArray alloc] init];;
    NSMutableArray *rightMatrix = [[NSMutableArray alloc] init];
    for(int i=0; i<mat.width; i++) {
        [leftMatrix addObject:[[NSMutableArray alloc] init]];
        [rightMatrix addObject:[[NSMutableArray alloc] init]];
        for(int j=0; j<mat.width; j++) {
            [leftMatrix[i] addObject:[[mat getObjectAt:i column:j] copy]];
            if(i == j) {
                MathNumber *num = [[MathNumber alloc] init];
                [num setDouble:1];
                [rightMatrix[i] addObject:num];
            }
            else {
                [rightMatrix[i] addObject:[[MathNumber alloc] init]];
            }
        }
    }
    
    // calculate the inverse of mat
    MathMultiplication *mult = [[MathMultiplication alloc] init];
    MathDivision *div = [[MathDivision alloc] init];
    MathAddition *add = [[MathAddition alloc] init];
    MathNumber *negativeOne = [[MathNumber alloc] init];
    [negativeOne setDouble:-1];
    int i, j;
    for(i=0;i<mat.width;i++)
    {
        for(j=i;j<mat.width;j++)
        {
            if(![self isZero:leftMatrix[j][i]])
            {
                break;
            }
        }
        if(j==mat.width)
        {
            return NULL;
        }
        if(i!=j)
        {
            // switch rows i and j
            NSMutableArray *sto = leftMatrix[i];
            leftMatrix[i] = leftMatrix[j];
            leftMatrix[j] = sto;
            sto = rightMatrix[i];
            rightMatrix[i] = rightMatrix[j];
            rightMatrix[j] = sto;
        }
        
        // scale row i by 1/m[i][i]
        MathObject *factor = [leftMatrix[i][i] copy];
        for(j=0; j<mat.width; j++) {
            leftMatrix[i][j] = [div func:[[NSArray alloc] initWithObjects:leftMatrix[i][j], factor, nil]];
            rightMatrix[i][j] = [div func:[[NSArray alloc] initWithObjects:rightMatrix[i][j], factor, nil]];
        }
        
        for(j=0;j<mat.width;j++)
        {
            if(j!=i)
            {
                // add scaled row
                factor = [mult func:[[NSArray alloc] initWithObjects:negativeOne, leftMatrix[j][i], nil]];
                for(int k=0; k<mat.width; k++) {
                    leftMatrix[j][k] = [add func:[[NSArray alloc] initWithObjects:leftMatrix[j][k], [mult func:[[NSArray alloc] initWithObjects:factor, leftMatrix[i][k], nil]], nil]];
                    rightMatrix[j][k] = [add func:[[NSArray alloc] initWithObjects:rightMatrix[j][k], [mult func:[[NSArray alloc] initWithObjects:factor, rightMatrix[i][k], nil]], nil]];
                }
            }
        }
    }
    
    // convert rightMatrix to a matrix
    MathMatrix *answer = [[MathMatrix alloc] init];
    answer.width = mat.width;
    for(int i=0; i<mat.width; i++) {
        for(int j=0; j<mat.width; j++) {
            [answer addObject:rightMatrix[i][j]];
        }
    }
    
    return answer;
}

- (bool) isZero: (MathNumber*) num {
    if([num getDouble] == 0 && [num getDouble:1] == 0) {
        return true;
    }
    return false;
}

@end
