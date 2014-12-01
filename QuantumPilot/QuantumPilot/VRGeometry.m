CGPoint CombinedPoint(CGPoint a, CGPoint b) {
    CGPoint combinedPoint = CGPointMake(a.x + b.x, a.y + b.y);
    return combinedPoint;
}

CGPoint MultipliedPoint(CGPoint p, float modifier) {
    CGPoint multipliedPoint = CGPointMake(p.x * modifier, p.y * modifier);
    return multipliedPoint;
}

float GetDistance(CGPoint a, CGPoint b) {
    float x = ((a.x - b.x) * (a.x - b.x));
	float y = ((a.y - b.y) * (a.y - b.y));
	if (x + y == 0){
        return 0;
	}
	float veldistance = sqrt((x+y));
    return veldistance;
}

CGPoint GetAngle(CGPoint a ,CGPoint b) {
	float veldistance = GetDistance(a, b);
    
    if (veldistance == 0) {
        return CGPointMake(0, 0);
    }
    
    float distvar = fabsf(a.x-b.x);
    float distvar2 = fabsf(a.y-b.y);
    
    float total = distvar + distvar2;
    
    distvar = (float)distvar / (float)total;
    distvar2 = (float)distvar2 / (float)total;
	
	if (b.x < a.x){
		distvar = -distvar;
	}
	if (b.y < a.y){
		distvar2 = -distvar2;
	}
	
	CGPoint finalVel = CGPointMake(distvar,distvar2);
	
	return finalVel;
}

BOOL shapeOfSizeContainsPoint(CGPoint *points, NSInteger length, CGPoint point) {
	CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, points[0].x, points[0].y);
    for (int i = 1; i < length; i++) {
        CGPathAddLineToPoint(path, NULL, points[i].x, points[i].y);
    }
    
	CGPathCloseSubpath(path);
    
	bool result = CGPathContainsPoint(path, NULL, point, YES);
    
    CFRelease(path);
    
    return result;
}