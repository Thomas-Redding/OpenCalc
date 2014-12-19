//
//  GraphingView.h
//  Calculator
//
//  Created by Thomas Redding on 10/31/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <OpenGL/OpenGL.h>
#import <OpenGL/gl.h>
#include "GraphingFunction.h"
#include "Preferences.h"

@interface GraphingView : NSOpenGLView

@property NSMutableArray *functionList;
@property Preferences *preferences;

@property double x;
@property double y;
@property double width;
@property double height;
// @property Preferences *preferences;

@end
