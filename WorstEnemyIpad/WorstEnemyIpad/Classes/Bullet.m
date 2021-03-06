//
//  Bullet.m
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "Bullet.h"


@implementation Bullet

-(void)setup {
	self.vel = CGPointMake(0, self.yFacing * self.speed);	
	//Override in subclasses	
}

-(id)initWithYFacing:(int)facing from:(CGPoint)from{
	self = [super init];
	if (self) {
		self.l = from;
		self.sprite = [CCSprite spriteWithFile:@"plasma34.png"];
		self.yFacing = facing;
		[self setup];
	}
	return self;
}

-(void)move {
	self.l = CGPointMake(self.l.x+self.vel.x,self.l.y+self.vel.y);
	NSLog(@"bullet l.x/y: %f %f",self.l.x,self.l.y);
	NSLog(@"bullet.vel: %f %f",self.vel.x, self.vel.y);
	self.sprite.position = self.l;
	
}	

-(void)animate {
	self.sprite.position = self.l;
		NSLog(@"sprite pos: %f, %f",self.sprite.position.x, self.sprite.position.y);
	[super animate];
//Override with subclasess of bullet	
}

+(NSArray *)newBulletsWithYFacing:(int)facing from:(CGPoint)from {
	//Override with subclasses of bullet
	//Generate a bullet based on its properties
	return nil;
	
}



@end