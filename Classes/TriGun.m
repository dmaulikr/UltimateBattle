//
//  TriGun.m
//  ultimatebattle
//
//  Created by X3N0 on 3/19/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "TriGun.h"
#import "TriShotBullet.h"

@implementation TriGun

-(id)init {
	self = [super init];
	if (self) {
		self.repeatLeft = 0;
		self.repeatReset = 10;
		self.bullet = [[TriShotBullet alloc] init];
	}
	return self;
}					   


@end
