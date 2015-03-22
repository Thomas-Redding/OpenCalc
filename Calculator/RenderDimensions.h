//
//  RenderDimensions.h
//  Calculator
//
//  Created by Thomas Redding on 12/20/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RenderDimensions : NSObject

// (x,y) refers to the coordinate of the window's center, not its upper-left or upper-right corner

@property double x;
@property double y;
@property double width;
@property double height;

@end
