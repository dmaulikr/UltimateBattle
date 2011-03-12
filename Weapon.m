//
//  Weapon.m
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "Weapon.h"


@implementation Weapon
@synthesize repeatLeft, repeatReset, bullet;

-(BOOL)canFire {
	return repeatLeft == 0;
}

-(void)tick {
	if (repeatLeft > 0) {
		repeatLeft--;
	}
}

-(NSArray *)newBulletsWithYFacing:(int)facing {
	NSArray *bullets = [[self.bullet class] newBulletsWithYFacing:facing];
	
	return bullets;
}

-(NSArray *)fireWithYFacing:(int)facing {
	if ([self canFire]) {
		return [self newBulletsWithYFacing:facing];
	}
	
	return nil;
}

-(void)dealloc {
	self.bullet = nil;
	[super dealloc];
}

@end
