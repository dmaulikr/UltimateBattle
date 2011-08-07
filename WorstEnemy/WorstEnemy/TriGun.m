//
//  TriGun.m
//  ultimatebattle
//
//  Created by X3N0 on 3/19/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "TriGun.h"
#import "TriShotBullet.h"

@implementation TriGun

-(id)init {
	self = [super init];
	if (self) {
		self.repeatLeft = 0;
		self.repeatReset = 6;
	}
	return self;
}					   

-(NSArray *)newBulletsWithYFacing:(int)facing from:(CGPoint)from {
	TriShotBullet *lb = [[[TriShotBullet alloc] initWithYFacing:facing from:from] autorelease];
	TriShotBullet *cb = [[[TriShotBullet alloc] initWithYFacing:facing from:from] autorelease];
	TriShotBullet *rb = [[[TriShotBullet alloc] initWithYFacing:facing from:from] autorelease];
	
	lb.vel = CGPointMake(-1.2, lb.vel.y);
	cb.vel = CGPointMake(0, cb.vel.y);
	rb.vel = CGPointMake(1.2, rb.vel.y);	

	lb.sprite.rotation = rotationFromPointWithVel(lb.l, lb.vel);
	cb.sprite.rotation = rotationFromPointWithVel(cb.l, cb.vel);
	rb.sprite.rotation = rotationFromPointWithVel(rb.l, rb.vel);	
	
	NSArray *bullets = [NSArray arrayWithObjects:lb, cb, rb, nil];
	return bullets;
}

@end
