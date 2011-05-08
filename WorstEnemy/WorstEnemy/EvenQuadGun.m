//
//  EvenQuadGun.m
//  WorstEnemy
//
//  Created by X3N0 on 5/8/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "EvenQuadGun.h"


@implementation EvenQuadGun

-(id)init {
	self = [super init];
	if (self) {
		self.repeatLeft = 0;
		self.repeatReset = 70;
	}
	return self;
}					   

-(NSArray *)newBulletsWithYFacing:(int)facing from:(CGPoint)from {
	QuadBullet *b1 = [[[QuadBullet alloc] initWithYFacing:facing from:from] autorelease];
	QuadBullet *b2 = [[[QuadBullet alloc] initWithYFacing:facing from:from] autorelease];
	QuadBullet *b3 = [[[QuadBullet alloc] initWithYFacing:facing from:from] autorelease];
	QuadBullet *b4 = [[[QuadBullet alloc] initWithYFacing:facing from:from] autorelease];
	
	b1.vel = CGPointMake(-3, b1.vel.y);
	b2.vel = CGPointMake(-1, b2.vel.y);
	b3.vel = CGPointMake(1, b3.vel.y);	
	b4.vel = CGPointMake(3, b4.vel.y);	

	b1.sprite.rotation = rotationFromPointWithVel(b1.l, b1.vel);
	b2.sprite.rotation = rotationFromPointWithVel(b2.l, b2.vel);
	b3.sprite.rotation = rotationFromPointWithVel(b3.l, b3.vel);
	b4.sprite.rotation = rotationFromPointWithVel(b4.l, b4.vel);
	
	NSArray *bullets = [NSArray arrayWithObjects:b1, b2, b3, b4, nil];
	return bullets;
}


@end
