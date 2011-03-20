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
		self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"plasma34.png"]];
		self.yFacing = facing;
		[self setup];
	}
	return self;
}

-(void)move {
	self.l = CGPointMake(self.l.x+self.vel.x,self.l.y+self.vel.y);
}	

-(void)animate {
	[super animate];
//Override with subclasess of bullet	
}

+(NSArray *)newBulletsWithYFacing:(int)facing from:(CGPoint)from {
	//Override with subclasses of bullet
	//Generate a bullet based on its properties
	return nil;
	
}

@end