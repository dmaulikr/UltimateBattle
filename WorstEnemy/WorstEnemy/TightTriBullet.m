//
//  TightTriBullet.m
//  WorstEnemy
//
//  Created by X3N0 on 5/8/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "TightTriBullet.h"


@implementation TightTriBullet

-(void)setup {
	self.speed = 5;	
	self.sprite = [CCSprite spriteWithFile:@"redtriangle.png"];
	[self resetSpeed];
}


@end