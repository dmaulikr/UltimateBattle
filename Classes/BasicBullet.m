//
//  BasicBullet.m
//  ultimatebattle
//
//  Created by X3N0 on 3/12/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "BasicBullet.h"


@implementation BasicBullet


-(void)setup {
	self.speed = 3;
	self.vel = CGPointMake(0, self.yFacing * self.speed);	
}

+(NSArray *)newBulletsWithYFacing:(int)facing from:(CGPoint)from {
	BasicBullet *b = [[[BasicBullet alloc] initWithYFacing:facing from:from] autorelease];
	[b setup];
	
	NSArray *bullets = [NSArray arrayWithObject:b];
	
	return bullets;	
}


@end