//
//  TriShotBullet.m
//  ultimatebattle
//
//  Created by X3N0 on 3/12/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "TriShotBullet.h"


@implementation TriShotBullet



-(void)setup {
	self.speed = 5;	
	self.sprite = [CCSprite spriteWithFile:@"redtriangle.png"];
	[self resetSpeed];
}

@end