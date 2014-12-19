//
//  GraphingView.m
//  Calculator
//
//  Created by Thomas Redding on 10/31/14.
//  Copyright (c) 2014 Thomas Redding. All rights reserved.
//

#import "GraphingView.h"

@implementation GraphingView


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [self updateConstraints];
    
    NSLog(@"draw");
    
    // Clear
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    if(self.preferences != nil) {
        if(self.preferences.drawAxes) {
            // draw axes
            double zeroX = 2*(0-self.x)/self.width;
            double zeroY = 2*(0-self.y)/self.height;
            glBegin(GL_LINES);
            {
                glVertex3f(zeroX, -1.0, 0.0);
                glVertex3f(zeroX, 1.0, 0.0);
                glVertex3f(-1.0, zeroY, 0.0);
                glVertex3f(1.0, zeroY, 0.0);
            }
        }
        
        glColor4f(0.0f, 0.0f, 0.0f, 1.0f);
        if(self.functionList != nil) {
            for(int i=0; i<self.functionList.count; i++) {
                if([self.functionList objectAtIndex:i] != nil) {
                    if([[self.functionList objectAtIndex:i] isVisible]) {
                        [self plotFunction:i];
                    }
                }
            }
        }
    }
    
    glFlush();
}

- (void) plotFunction: (int) index {
    GraphingFunction *func = [self.functionList objectAtIndex:index];
    if(func != nil && func.points.count > 0 && self.width != 0 && self.height != 0) {
        glBegin(GL_LINES);
        {
            double startX, startY, endX, endY;
            startX = 2*([[func.points objectAtIndex:0] doubleValue]-self.x)/self.width;
            startY = 2*([[func.points objectAtIndex:1] doubleValue]-self.y)/self.height;
            for(int i=3; i<func.points.count; i+=3) {
                endX = 2*([[func.points objectAtIndex:i] doubleValue]-self.x)/self.width;
                endY = 2*([[func.points objectAtIndex:i+1] doubleValue]-self.y)/self.height;
                glVertex3f(startX, startY, 0.0);
                glVertex3f(endX, endY, 0.0);
                startX = endX;
                startY = endY;
            }
        }
        glEnd();
    }
}

- (void) reshape {
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
