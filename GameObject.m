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
@synthesize yFacing;

-(void)animate { 
//Draw magic here	
}

-(void)move {
	self.l = CGPointMake(self.l.x + self.turn.vel.x, self.l.y + self.turn.vel.y);
}

-(void)tick {
	[self move];
	[self animate];
}

-(void)dealloc {
	self.turn = nil;
	[super dealloc];
}

@end