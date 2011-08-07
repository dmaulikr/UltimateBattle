//
//  LaserGun.m
//  ultimatebattle
//
//  Created by X3N0 on 3/17/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "LaserGun.h"


@implementation LaserGun

-(id)init {
	self = [super init];
	if (self) {
		self.repeatLeft = 0;
		self.repeatReset = 6;
//		self.bullet = [[BasicBullet alloc] init];
	}
	return self;
}					   

-(NSArray *)newBulletsWithYFacing:(int)facing from:(CGPoint)from {
	BasicBullet *b = [[[BasicBullet alloc] initWithYFacing:facing from:from] autorelease];
	[b setup];
	
	NSArray *bullets = [NSArray arrayWithObject:b];
	
	return bullets;	
}



@end