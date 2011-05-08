//
//  DefaultBullet.m
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "DefaultBullet.h"
#import "CCTextureCache.h"

@implementation DefaultBullet
@synthesize ub;

-(void)setup {
	self.vel = CGPointMake(0, self.yFacing * self.speed);	
	//Override in subclasses	
}

-(id)initWithYFacing:(int)facing from:(CGPoint)from{
	self = [super init];
	if (self) {
		self.l = from;
		ticker = 0;
		self.yFacing = facing;
		photoRef = 1;
		moveTimer = 100;
		[self setup];
	}
	return self;
}

-(void)move {
	
	self.l = CGPointMake(self.l.x+self.vel.x,self.l.y+self.vel.y);
	self.sprite.position = self.l;
	self.ub.l = self.l;
	
}	

-(void)animate {
	[super animate];
	self.sprite.position = self.l;
	
	moveTimer--;
	ticker++;
	//		self.sprite.scaleX = self.sprite.scaleX * (ticker / 100);
	//	self.sprite.scaleY = self.sprite.scaleX;
	//	float angle = CC_RADIANS_TO_DEGREES(atan2(self.sprite.position.y - _touchBeganLocation.y, _turret.position.x - _touchBeganLocation.x));
	//	
	//	angle += 90;
	//	angle *= -1;
	//	
	//	self.sprite.rotation = angle;
	if (moveTimer <= 0) {
		
		photoRef++;
		
		moveTimer = 100;
		if (photoRef >= 8) {
			photoRef = 8;
		}
		if (photoRef <=8) {
//			NSString *pulse = [NSString stringWithFormat:@"pulse000%d.png", photoRef];			
//			self.sprite.texture=[[CCTextureCache sharedTextureCache] addImage:pulse];
		}
	}
	
	
	//Override with subclasess of bullet	
}

+(NSArray *)newBulletsWithYFacing:(int)facing from:(CGPoint)from {
	//Override with subclasses of bullet
	//Generate a bullet based on its properties
	return nil;
	
}

@end