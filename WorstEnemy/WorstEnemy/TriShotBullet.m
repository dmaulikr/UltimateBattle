//
//  TriShotBullet.m
//  ultimatebattle
//
//  Created by X3N0 on 3/12/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "TriShotBullet.h"


@implementation TriShotBullet

-(void)setup {
	self.speed = 9;	
	[super setup];
}

+(NSArray *)newBulletsWithYFacing:(int)facing from:(CGPoint)from {
	TriShotBullet *lb = [[[TriShotBullet alloc] initWithYFacing:facing from:from] autorelease];
	TriShotBullet *cb = [[[TriShotBullet alloc] initWithYFacing:facing from:from] autorelease];
	TriShotBullet *rb = [[[TriShotBullet alloc] initWithYFacing:facing from:from] autorelease];
	
	lb.vel = CGPointMake(-3, lb.vel.y);
	cb.vel = CGPointMake(0, cb.vel.y);
	rb.vel = CGPointMake(3, rb.vel.y);	
	
	
	NSArray *bullets = [NSArray arrayWithObjects:lb, cb, rb, nil];
	return bullets;
}


@end