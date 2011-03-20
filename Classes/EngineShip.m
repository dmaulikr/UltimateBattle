//
//  EngineShip.m
//  ultimatebattle
//
//  Created by X3N0 on 3/19/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "EngineShip.h"


@implementation EngineShip

-(id)init {
	self = [super init];
	if (self) {
		self.engine = [[Engine alloc] init];
	}
	return self;
}

-(void)move {
	NSLog(@"move.l.x: %f",self.l.x);
	self.turn.vel = [self.engine velocityForTargetPoint:self.turn.targetLocation from:self.l];
    self.l = [self.engine moveFrom:self.l withVel:self.turn.vel];	
	NSLog(@"POST move.l.x: %f",self.l.x);	
}

-(void)tick {
	[super tick];
}

-(void)dealloc{
	self.engine = nil;
	[super dealloc];
}

@end
