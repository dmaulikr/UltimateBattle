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
	
	b1.vel = CGPointMake(-5, b1.vel.y);
	b2.vel = CGPointMake(-2.5, b2.vel.y);
	b3.vel = CGPointMake(2.5, b3.vel.y);	
	b4.vel = CGPointMake(5, b4.vel.y);	
	
	NSArray *bullets = [NSArray arrayWithObjects:b1, b2, b3, b4, nil];
	return bullets;
}


@end
