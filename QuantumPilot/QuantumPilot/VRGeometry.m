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

CGPoint GetAngle(CGPoint a ,CGPoint b){

	float veldistance = GetDistance(a, b);
    
    if (veldistance == 0) {
        return CGPointMake(0, 0);
    }
    
	float distvar = ((fabsf(a.x-b.x))/veldistance);
	float distvar2 = ((fabsf(a.y-b.y))/veldistance);
	
	if (b.x < a.x){
		distvar = -distvar;
	}
	if (b.y < a.y){
		distvar2 = -distvar2;
	}
	
	CGPoint finalVel = CGPointMake(distvar,distvar2);
	
	return finalVel;
}
