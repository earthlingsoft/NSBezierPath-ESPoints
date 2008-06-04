/*
	NSBezierPath+ESPoints.h

	v1 (2008-07-27)
 
	Created by  Sven on 24.05.08.
	Copyright 2008 earthlingsoft. All rights reserved.

	Available at
		http://earthlingsoft.net/code/NSBezierPath+ESPoints/
	More code at
		http://earthlingsoft.net/code/

	You may use this code in your own projects at your own risk.
	Please notify us of problems you discover and be sure to give 
	reasonable credit.

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

- (void) drawPointsInColor: (NSColor*) pointColor withHandlesInColor: (NSColor *) handleColor;

- (void) drawPoint: (NSPoint) pt;
- (void) drawPoint: (NSPoint) pt inColor: (NSColor*) pointColor;
- (void) drawHandlePoint: (NSPoint) pt;
- (void) drawHandlePoint: (NSPoint) pt inColor: (NSColor*) pointColor;

- (NSPoint) drawPathElement:(int) n withPreviousPoint: (NSPoint) previous;
- (NSPoint) drawPathElement:(int) n  withPreviousPoint: (NSPoint) previous inColor: (NSColor*) pointColor withHandlesInColor: (NSColor*) handleColor;
@end
