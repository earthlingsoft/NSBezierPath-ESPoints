/*
 NSBezierPath+ESPoints.h
 
 Copyright 2008-2017 Sven-S. Porst, earthlingsoft: https://earthlingsoft.net/ssp/
 Some rights reserved: https://opensource.org/licenses/mit
 Available at: https://github.com/earthlingsoft/NSBezierPath-ESPoints
 
 v2 (2017-02-15)
 
 ********************************************************************
 
 Category on NSBezierPath for drawing anchor and handle control
 points with a single method call:
 
	-drawPointsAndHandles
	
 draws the control points of the path and associated handles in green
 and the anchor points in red, which is particularly useful when
 debugging Bézier paths.
 
 Call it after stroking the path to get the full picture.
 
 The remaining methods allow finer control of the colour usage and are
 helper methods for doing the drawing.
*/

#import <Cocoa/Cocoa.h>


@interface NSBezierPath (ESPoints)

- (void) drawPointsAndHandles;

- (void) drawPointsInColor:(NSColor *)pointColor withHandlesInColor:(NSColor *)handleColor;

- (void) drawPoint:(NSPoint)pt;
- (void) drawPoint:(NSPoint)pt inColor:(NSColor *)pointColor;
- (void) drawHandlePoint:(NSPoint)pt;
- (void) drawHandlePoint:(NSPoint)pt inColor:(NSColor *)pointColor;

- (NSPoint) drawPathElement:(NSUInteger)n withPreviousPoint:(NSPoint)previous;
- (NSPoint) drawPathElement:(NSUInteger)n withPreviousPoint:(NSPoint)previous inColor:(NSColor *)pointColor withHandlesInColor:(NSColor *)handleColor;

@end
