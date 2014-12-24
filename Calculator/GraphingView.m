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
    
    glEnable(GL_BLEND);
    glEnable(GL_LINE_SMOOTH);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    if(self.preferences != nil) {
        if(self.preferences.drawAxes) {
            // draw axes
            double zeroX = 2*(0-self.renderDimensions.x)/self.renderDimensions.width;
            double zeroY = 2*(0-self.renderDimensions.y)/self.renderDimensions.height;
            glBegin(GL_LINES);
            {
                glVertex2f(zeroX, -1.0);
                glVertex2f(zeroX, 1.0);
                glVertex2f(-1.0, zeroY);
                glVertex2f(1.0, zeroY);
            }
        }
        
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
    if(func != nil && func.points.count > 0 && self.renderDimensions.width != 0 && self.renderDimensions.height != 0) {
        
        if(func.type == 8804 || func.type == '<') {
            // ≤, <
            glBegin(GL_POLYGON);
            {
                glColor4f(0, 0, 0, 0.4);
                double x, y;
                glVertex2f(-1.0, -100);
                for(int i=0; i<func.points.count; i+=3) {
                    x = 2*([[func.points objectAtIndex:i] doubleValue]-self.renderDimensions.x)/self.renderDimensions.width;
                    y = 2*([[func.points objectAtIndex:i+1] doubleValue]-self.renderDimensions.y)/self.renderDimensions.height;
                    glVertex2f(x, y);
                }
                glVertex2f(1.0, -100);
                glVertex2f(-1.0, -100);
            }
            glEnd();
        }
        
        if(func.type == 8805 || func.type == '>') {
            // ≥, >
            glBegin(GL_POLYGON);
            {
                glColor4f(0, 0, 0, 0.4);
                double x, y;
                glVertex2f(-1.0, 100);
                for(int i=0; i<func.points.count; i+=3) {
                    x = 2*([[func.points objectAtIndex:i] doubleValue]-self.renderDimensions.x)/self.renderDimensions.width;
                    y = 2*([[func.points objectAtIndex:i+1] doubleValue]-self.renderDimensions.y)/self.renderDimensions.height;
                    glVertex2f(x, y);
                }
                glVertex2f(1.0, 100);
                glVertex2f(-1.0, 100);
            }
            glEnd();
        }
        
        if(func.type == '=' || func.type == 8804 || func.type == 8805 || func.type == '[') {
            // =, ≤, ≥
            glColor4f(0.0f, 0.0f, 0.0f, 1.0f);
            glBegin(GL_LINES);
            {
                double startX, startY, endX, endY;
                startX = 2*([[func.points objectAtIndex:0] doubleValue]-self.renderDimensions.x)/self.renderDimensions.width;
                startY = 2*([[func.points objectAtIndex:1] doubleValue]-self.renderDimensions.y)/self.renderDimensions.height;
                for(int i=3; i<func.points.count; i+=3) {
                    endX = 2*([[func.points objectAtIndex:i] doubleValue]-self.renderDimensions.x)/self.renderDimensions.width;
                    endY = 2*([[func.points objectAtIndex:i+1] doubleValue]-self.renderDimensions.y)/self.renderDimensions.height;
                    glVertex2f(startX, startY);
                    glVertex2f(endX, endY);
                    startX = endX;
                    startY = endY;
                }
            }
            glEnd();
        }
    }
}

- (void) reshape {
    glViewport(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)magnifyWithEvent:(NSEvent *)theEvent {
    self.renderDimensions.width *= (1+theEvent.magnification);
    self.renderDimensions.height *= (1+theEvent.magnification);
    [self.parent childToParentMessage:@"MagnifyWithEvent"];
}

- (void)scrollWheel:(NSEvent *)theEvent {
    if(self.preferences.doesScrollZoom) {
        self.renderDimensions.width *= (1+theEvent.scrollingDeltaX*0.01);
        self.renderDimensions.height /= (1+theEvent.scrollingDeltaY*0.01);
    }
    else {
        self.renderDimensions.x += theEvent.scrollingDeltaX * self.renderDimensions.width / 1000;
        self.renderDimensions.y += theEvent.scrollingDeltaY * self.renderDimensions.width / 1000;
    }
    [self.parent childToParentMessage:@"ScrollWheel"];
}

- (void)mouseDragged:(NSEvent *)theEvent {
    if(self.mouseX != -1) {
        // move window
        double deltaX = theEvent.locationInWindow.x - self.mouseX;
        double deltaY = theEvent.locationInWindow.y - self.mouseY;
        self.renderDimensions.x -= self.renderDimensions.width * deltaX / 1000;
        self.renderDimensions.y -= self.renderDimensions.width * deltaY / 1000;
    }
    
    self.mouseX = theEvent.locationInWindow.x;
    self.mouseY = theEvent.locationInWindow.y;
    [self.parent childToParentMessage:@"MouseDragged"];
}

- (void)mouseDown:(NSEvent *)theEvent {
    self.mouseX = theEvent.locationInWindow.x;
    self.mouseY = theEvent.locationInWindow.y;
    [self.parent mouseDown:theEvent sender:0];
    [self.parent childToParentMessage:@"MouseDown"];
}

- (void) rightMouseDown: (NSEvent*) theEvent {
    NSMenu *theMenu = [[NSMenu alloc] initWithTitle:@"Contextual Menu"];
    [theMenu insertItemWithTitle:@"Evaluate" action:@selector(evaluate) keyEquivalent:@"" atIndex:0];
    [theMenu insertItemWithTitle:@"FindRoot" action:@selector(findRoot) keyEquivalent:@"" atIndex:0];
    [theMenu insertItemWithTitle:@"Integrate" action:@selector(integrate) keyEquivalent:@"" atIndex:1];
    [theMenu insertItemWithTitle:@"FindIntersect" action:@selector(findIntersect) keyEquivalent:@"" atIndex:0];
    
    [NSMenu popUpContextMenu:theMenu withEvent:theEvent forView:self];
}

- (int) functionClicked: (double) x y: (double) y {
    GraphingFunction *func;
    double min = INFINITY;
    double index = -1;
    double dist;
    double proportion = ((x-self.renderDimensions.x)/self.renderDimensions.width+0.5)/3;
    if(proportion < 0 || proportion >= 1) {
        return -1;
    }
    int j;
    for(int i=0; i<self.functionList.count; i++) {
        func = [self.functionList objectAtIndex:i];
        j = proportion*func.points.count;
        dist = fabs([[func.points objectAtIndex:3*j+1] doubleValue]-y);
        if(dist < min) {
            min = dist;
            index = i;
        }
    }
    if(min/self.renderDimensions.height < 0.03) {
        return index;
    }
    else {
        return -1;
    }
}

- (void) evaluate {
    [self.parent childToParentMessage:@"evaluate"];
}

- (void) findRoot {
    [self.parent childToParentMessage:@"findRoot"];
}

- (void) integrate {
    [self.parent childToParentMessage:@"integrate"];
}

- (void) findIntersect {
    [self.parent childToParentMessage:@"findIntersect"];
}

- (void)mouseUp:(NSEvent *)theEvent {
    self.mouseX = -1;
    self.mouseY = -1;
    [self.parent mouseUp: theEvent];
    [self.parent childToParentMessage:@"MouseUp"];
}


@end
