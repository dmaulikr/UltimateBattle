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

-(id)initWithYFacing:(int)facing {
	self = [super init];
	if (self) {
		self.yFacing = facing;
		[self setup];
	}
	return self;
}

-(void)animate {
	[super animate];
//Override with subclasess of bullet	
}

+(NSArray *)newBulletsWithYFacing:(int)facing {
	//Override with subclasses of bullet
	//Generate a bullet based on its properties
	return nil;
	
}

@end