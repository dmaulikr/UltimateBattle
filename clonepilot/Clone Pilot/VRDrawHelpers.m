#import "VRDrawHelpers.h"

void drawShapeFromLines(CGPoint *lines, NSInteger index, NSInteger length) {
    if (index < length -1 ) {
        ccDrawLine(lines[index], lines[index+1]);
        drawShapeFromLines(lines, index+1, length);
    } else {
        ccDrawLine(lines[index], lines[0]);
    }
}

BOOL shapeOfSizeContainsPoint(CGPoint *points, NSInteger length, CGPoint point) {
	CGMutablePathRef path=CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, points[0].x, points[0].y);
    for (int i = 1; i < length; i++) {
        CGPathAddLineToPoint(path, NULL, points[i].x, points[i].y);
    }
    
	CGPathCloseSubpath(path);
	return CGPathContainsPoint(path, NULL, point, YES);
}