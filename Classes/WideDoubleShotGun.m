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
		self.repeatReset = 50;
		self.bullet = [[WideDoubleBullet alloc] init];
	}
	return self;
}		

@end
