//
//  cmpgames.m
//  coop
//
//  Created by X3N0 on 7/18/10.
//  Copyright 2010 Rage Creations. All rights reserved.
//

#import "cmpgames.h"
#import "ccMacros.h"

CGPoint CombineVel(CGPoint v1, CGPoint v2){
	v1 = CGPointMake(v1.x+v2.x,v1.y+v2.y);
		return v1;
}

CGPoint SXetX(CGPoint v1, float x){
	v1 = CGPointMake(x,v1.y);
	return v1;
}

CGPoint SXOffsetX(CGPoint v1, float x){
	v1 = CGPointMake(v1.x+x,v1.y);
	return v1;
}

CGPoint SYOffsetY(CGPoint v1, float y){
	v1 = CGPointMake(v1.x,v1.y+y);
	return v1;
}

	
CGPoint SYetY(CGPoint v1, float y){
	v1 = CGPointMake(v1.x,y);
	return v1;
}

CGPoint IXncreaseX(CGPoint v1, float xv){
	v1 = CGPointMake(v1.x+xv,v1.y);
	return v1;
}

CGPoint IYncreaseY(CGPoint v1, float yv){
	v1 = CGPointMake(v1.x,v1.y+yv);
	return v1;
}

float GetDist(CGPoint initialp, CGPoint secondp){
	distvar = ((initialp.x - secondp.x) * (initialp.x - secondp.x));
    distvar2 = ((initialp.y - secondp.y) * (initialp.y - secondp.y));
	if (distvar + distvar2 == 0){
		distvar = 1;
		distvar2 = 3;
	}
	
    fdist = fabsf(sqrt((distvar+distvar2)));
    return fdist;
	
}

BOOL OutOfBounds(CGPoint initialp){
	if (initialp.x < 2 || initialp.x > 318  || initialp.y < 2 || initialp.y > 478){
		return YES;	
	}
	return NO;
}

CGPoint GetAngle(CGPoint initialp ,CGPoint secondp){
	distvar = ((initialp.x - secondp.x) * (initialp.x - secondp.x));
	distvar2 = ((initialp.y - secondp.y) * (initialp.y - secondp.y));
	if (distvar + distvar2 == 0){
		distvar = 1;
		distvar2 = 3;
	}
	veldistance = sqrt((distvar+distvar2));
	
	distvar = ((fabsf(initialp.x-secondp.x))/veldistance);
	distvar2 = ((fabsf(initialp.y-secondp.y))/veldistance);
	
	if (secondp.x < initialp.x){
		distvar = -distvar;
	}
	if (secondp.y < initialp.y){
		distvar2 = -distvar2;
	}
	
	fvel = CGPointMake(distvar,distvar2);
	
	return fvel;
}

CGPoint MultiplyVel(CGPoint cref , float mfact){
	cref = CGPointMake(cref.x * mfact, cref.y * mfact);
	return cref;
}

float rotationFromPointWithVel(CGPoint l, CGPoint vel) {
	CGPoint target = CombineVel(l, vel);
	
	int offX = (l.x - target.x);
	int offY = (l.y - target.y);
	
	float angleRadians = atanf((float)offX / (float)offY);
	float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);

	if (target.y < l.y) {
		angleDegrees = angleDegrees + 180;
	}
	
	return angleDegrees;
}