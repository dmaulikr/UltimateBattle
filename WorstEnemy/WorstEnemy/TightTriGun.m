//
//  TightTriGun.m
//  WorstEnemy
//
//  Created by X3N0 on 5/8/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "TightTriGun.h"


@implementation TightTriGun

-(id)init {
	self = [super init];
	if (self) {
		self.repeatLeft = 0;
		self.repeatReset = 60;
	}
	return self;
}					   

-(NSArray *)newBulletsWithYFacing:(int)facing from:(CGPoint)from {
	TightTriBullet *lb = [[[TightTriBullet alloc] initWithYFacing:facing from:CGPointMake(from.x-30,from.y)] autorelease];
	TightTriBullet *cb = [[[TightTriBullet alloc] initWithYFacing:facing from:from] autorelease];
	TightTriBullet *rb = [[[TightTriBullet alloc] initWithYFacing:facing from:CGPointMake(from.x+30,from.y)] autorelease];
	
	lb.vel = CGPointMake(0, lb.vel.y);
	cb.vel = CGPointMake(0, cb.vel.y);
	rb.vel = CGPointMake(0, rb.vel.y);	

	lb.sprite.rotation = rotationFromPointWithVel(lb.l, lb.vel);
	cb.sprite.rotation = rotationFromPointWithVel(cb.l, cb.vel);
	rb.sprite.rotation = rotationFromPointWithVel(rb.l, rb.vel);	
	
	NSArray *bullets = [NSArray arrayWithObjects:lb, cb, rb, nil];
	return bullets;
}


@end
