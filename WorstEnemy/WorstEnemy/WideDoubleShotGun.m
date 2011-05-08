//
//  WideDoubleShotGun.m
//  ultimatebattle
//
//  Created by X3N0 on 3/20/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "WideDoubleShotGun.h"
#import "WideDoubleBullet.h"

@implementation WideDoubleShotGun


-(id)init {
	self = [super init];
	if (self) {
		self.repeatLeft = 0;
		self.repeatReset = 30;
		self.bullet = [[WideDoubleBullet alloc] init];
	}
	return self;
}		

-(NSArray *)newBulletsWithYFacing:(int)facing from:(CGPoint)from {
	WideDoubleBullet *lb = [[[WideDoubleBullet alloc] initWithYFacing:facing from:from ] autorelease];
	lb.vel = CGPointMake(-4, lb.vel.y);
	
	WideDoubleBullet *rb = [[[WideDoubleBullet alloc] initWithYFacing:facing from:from] autorelease];
	rb.vel = CGPointMake(4, rb.vel.y);
	
	NSArray *bullets = [NSArray arrayWithObjects:lb, rb, nil];
	
	return bullets;
}

@end
