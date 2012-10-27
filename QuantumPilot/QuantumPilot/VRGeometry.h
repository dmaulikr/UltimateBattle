#import <Foundation/Foundation.h>

CGPoint CombinedPoint(CGPoint a, CGPoint b);
CGPoint MultipliedPoint(CGPoint p, float modifier);
CGPoint GetAngle(CGPoint a ,CGPoint b);
float GetDistance(CGPoint a, CGPoint b);
BOOL shapeOfSizeContainsPoint(CGPoint *points, NSInteger length, CGPoint point);
