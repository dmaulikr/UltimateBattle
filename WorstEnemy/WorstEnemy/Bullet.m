//
//  Bullet.m
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "Bullet.h"
#import "CCTextureCache.h"

@implementation Bullet
@synthesize ub;

-(void)resetSpeed {
		self.vel = CGPointMake(0, self.yFacing * self.speed);	
}

-(void)setup {
	[self resetSpeed];
	self.sprite = [CCSprite spriteWithFile:@"greenblot.png"];
}

@end