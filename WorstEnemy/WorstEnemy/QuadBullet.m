//
//  QuadBullet.m
//  WorstEnemy
//
//  Created by X3N0 on 5/8/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "QuadBullet.h"


@implementation QuadBullet

-(void)setup {
	self.speed = 6;	
	self.sprite = [CCSprite spriteWithFile:@"tinybluediamond.png"];
	[self resetSpeed];
}

@end