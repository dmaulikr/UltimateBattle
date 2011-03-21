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
	if (self.repeatLeft == 0) {
		return YES;
	}
	
	return NO;
}

-(id)copyWithZone:(NSZone *)zone {
    return self;
}

-(void)setRepeatLeft:(int)value {
	repeatLeft = value;
}

-(void)tick {
	if (self.repeatLeft > 0) {
		self.repeatLeft--;
	}
}

-(NSArray *)newBulletsWithYFacing:(int)facing from:(CGPoint)from {
	NSArray *bullets = [[self.bullet class] newBulletsWithYFacing:facing from:from];
	return bullets;
}

-(NSArray *)fireWithYFacing:(int)facing from:(CGPoint)from {
	if ([self canFire]) {
		self.repeatLeft = self.repeatReset;
		return [self newBulletsWithYFacing:facing from:from];
	}
	
	return nil;
}

-(void)dealloc {
	self.bullet = nil;
	[super dealloc];
}

@end
