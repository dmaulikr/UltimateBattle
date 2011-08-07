//
//  Engine.m
//  ultimatebattle
//
//  Created by Anthony Broussard on 3/18/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "Engine.h"
#import "cmpgames.h"

@implementation Engine
@synthesize speed, movementBounds;

-(id)init {
    self = [super init];
    if (self) {
        //TODO: Check device version and initialize with iphone or ipad screen size
        self.movementBounds = CGRectMake(0, 0, 764, 1024);
		self.speed = 8;
    }
    return self;
}

-(CGPoint)moveFrom:(CGPoint)l withVel:(CGPoint)vel {
    CGPoint newLocation = CGPointMake(l.x + vel.x,l.y+vel.y);
    if (CGRectContainsPoint(self.movementBounds, newLocation)) {
        return newLocation;    
    }
    return l;
}

-(CGPoint)velocityForTargetPoint:(CGPoint)target from:(CGPoint)location {
    //TODO: Get angle, then multiply by speed
	if (GetDist(location, target) > self.speed) {
	CGPoint angle = GetAngle(location, target);
	angle = MultiplyVel(angle, self.speed);
	return angle;
	} 
	
	return CGPointZero;
}

@end