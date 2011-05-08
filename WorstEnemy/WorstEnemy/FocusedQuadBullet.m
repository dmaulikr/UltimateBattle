//
//  FocusedQuadBullet.m
//  WorstEnemy
//
//  Created by X3N0 on 5/8/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "FocusedQuadBullet.h"


@implementation FocusedQuadBullet

-(void)setup {
	self.speed = 6.5;	
	self.sprite = [CCSprite spriteWithFile:@"tinybluediamond.png"];
	[self resetSpeed];
}

@end