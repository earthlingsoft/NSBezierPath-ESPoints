//
//  NSBezierPath+ESPoints.m
//	v1 (2008-07-27)
//
//  Created by  Sven on 24.05.08.
//  Copyright 2008 earthlingsoft. All rights reserved.
//

#import "NSBezierPath+ESPoints.h"

#define POINTSIZE 5.0
#define HANDLESIZE 3.0
#define HANDLELINEWIDTH 1.5
#define DEFAULTPOINTCOLOR [NSColor redColor]
#define DEFAULTHANDLECOLOR [NSColor greenColor]


@implementation NSBezierPath (ESPoints)

#pragma mark MAIN CONVENIENCE METHODS
- (void) drawPointsAndHandles {
	[self drawPointsInColor:DEFAULTPOINTCOLOR withHandlesInColor:DEFAULTHANDLECOLOR];
}


- (void) drawPointsInColor: (NSColor*) pointColor withHandlesInColor: (NSColor *) handleColor {
	NSPoint previousPoint = NSMakePoint(0.0, 0.0);
	
	for (NSInteger i=0; i < [self elementCount]; i++) {
		previousPoint = [self drawPathElement:i withPreviousPoint: previousPoint inColor:pointColor withHandlesInColor: handleColor];
	}
}



#pragma mark DRAWING POINTS 

- (void) drawPoint: (NSPoint) pt {
	[self drawPoint:pt inColor: DEFAULTPOINTCOLOR];
}


- (void) drawPoint: (NSPoint) pt inColor: (NSColor*) pointColor {
	NSBezierPath * bp = [NSBezierPath bezierPathWithRect:NSMakeRect(pt.x - POINTSIZE * 0.5, pt.y - POINTSIZE * 0.5, POINTSIZE, POINTSIZE)];
	[pointColor set];
	[bp fill];
}


- (void) drawHandlePoint: (NSPoint) pt {
	[self drawHandlePoint: pt inColor:DEFAULTHANDLECOLOR];
}


- (void) drawHandlePoint: (NSPoint) pt inColor: (NSColor*) pointColor {
	NSBezierPath * bp = [NSBezierPath bezierPathWithRect:NSMakeRect(pt.x-HANDLESIZE * 0.5, pt.y - HANDLESIZE * 0.5, HANDLESIZE, HANDLESIZE)];
	[pointColor set];
	[bp fill];
}	



#pragma mark DRAWING PATH ELEMENTS

- (NSPoint) drawPathElement:(int) n withPreviousPoint: (NSPoint) previous {
	return [self drawPathElement:n withPreviousPoint:previous inColor:DEFAULTPOINTCOLOR withHandlesInColor:DEFAULTHANDLECOLOR];
}


- (NSPoint) drawPathElement:(int) n  withPreviousPoint: (NSPoint) previous inColor: (NSColor*) pointColor withHandlesInColor: (NSColor*) handleColor {
	NSPoint previousPoint;
	NSPoint points[3];
	NSBezierPathElement element = [self elementAtIndex: n associatedPoints:points];
	NSBezierPath * bp;
	switch (element) {
		case NSCurveToBezierPathElement:
			bp = [NSBezierPath bezierPath];
			[bp moveToPoint:previous];
			[bp lineToPoint:points[0]];
			[bp moveToPoint:points[2]];
			[bp lineToPoint:points[1]];
			[bp setLineWidth:HANDLELINEWIDTH];
			[handleColor set];
			[bp stroke];
			
			[self drawHandlePoint: points[0] inColor:handleColor];
			[self drawHandlePoint: points[1] inColor:handleColor];
			[self drawPoint:points[2] inColor:pointColor];
			
			previousPoint = points[2];
			break;
			
		case NSMoveToBezierPathElement:
			[self drawPoint:points[0] inColor:pointColor];
			previousPoint = points[0];
			break;
			
		case NSLineToBezierPathElement:
			[self drawPoint:points[0] inColor:pointColor];
			
			/*
			 bp = [NSBezierPath bezierPath];
			 [bp moveToPoint:previousPoint];
			 [bp lineToPoint:points[0]];
			 [handleColor:set];
			 [bp setLineWidth:HANDLELINEWIDTH];
			 [bp stroke]
			 */
			previousPoint = points[0];
			break;
	}
	
	return previousPoint;
}

@end
