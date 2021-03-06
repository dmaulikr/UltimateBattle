//
//  WideDoubleBullets.m
//  ultimatebattle
//
//  Created by X3N0 on 3/12/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "WideDoubleBullet.h"


@implementation WideDoubleBullet

-(void)setup {
	self.speed = 12;
	[super setup];
}

+(NSArray *)newBulletsWithYFacing:(int)facing from:(CGPoint)from {
	WideDoubleBullet *lb = [[[WideDoubleBullet alloc] initWithYFacing:facing from:from ] autorelease];
	lb.vel = CGPointMake(-2, lb.vel.y);

	WideDoubleBullet *rb = [[[WideDoubleBullet alloc] initWithYFacing:facing from:from] autorelease];
	rb.vel = CGPointMake(2, rb.vel.y);
	
	NSArray *bullets = [NSArray arrayWithObjects:lb, rb, nil];
	
	return bullets;
	
}


@end