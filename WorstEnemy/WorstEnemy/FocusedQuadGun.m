//
//  FocusedQuadGun.m
//  WorstEnemy
//
//  Created by X3N0 on 5/8/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "FocusedQuadGun.h"


@implementation FocusedQuadGun

-(id)init {
	self = [super init];
	if (self) {
		self.repeatLeft = 0;
		self.repeatReset = 70;
	}
	return self;
}					   

-(NSArray *)newBulletsWithYFacing:(int)facing from:(CGPoint)from {
	FocusedQuadBullet *b1 = [[[FocusedQuadBullet alloc] initWithYFacing:facing from:CGPointMake(from.x-30,from.y)] autorelease];
	FocusedQuadBullet *b2 = [[[FocusedQuadBullet alloc] initWithYFacing:facing from:CGPointMake(from.x+30,from.y)] autorelease];
	FocusedQuadBullet *b3 = [[[FocusedQuadBullet alloc] initWithYFacing:facing from:from] autorelease];
	FocusedQuadBullet *b4 = [[[FocusedQuadBullet alloc] initWithYFacing:facing from:from] autorelease];
	
	b1.vel = CGPointMake(-0, b1.vel.y);
	b2.vel = CGPointMake(0, b2.vel.y);
	b3.vel = CGPointMake(-4.5, b3.vel.y);	
	b4.vel = CGPointMake(4.5, b4.vel.y);	

	b1.sprite.rotation = rotationFromPointWithVel(b1.l, b1.vel);
	b2.sprite.rotation = rotationFromPointWithVel(b2.l, b2.vel);
	b3.sprite.rotation = rotationFromPointWithVel(b3.l, b3.vel);
	b4.sprite.rotation = rotationFromPointWithVel(b4.l, b4.vel);
	
	
	NSArray *bullets = [NSArray arrayWithObjects:b1, b2, b3, b4, nil];
	return bullets;
}


@end
