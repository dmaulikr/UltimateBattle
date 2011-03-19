//
//  GameObject.m
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "GameObject.h"


@implementation GameObject
@synthesize vel, l, turn;
@synthesize yFacing, speed;
@synthesize imageView;

-(void)animate { 
//Draw magic here	
}

-(Turn *)currentTurn {
	return self.turn;
}

-(void)move {
	self.l = CGPointMake(self.l.x + [self currentTurn].vel.x, self.l.y + [self currentTurn].vel.y);
}

-(void)tick {
	[self move];
	[self animate];
}

-(void)dealloc {
	self.turn = nil;
	self.imageView = nil;
	[super dealloc];
}

@end