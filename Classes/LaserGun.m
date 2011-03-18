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
		self.repeatReset = 10;
		self.bullet = [[BasicBullet alloc] init];
	}
	return self;
}					   

@end