//
//  Move.m
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "Turn.h"


@implementation Turn
@synthesize vel, firing;

-(void)becomeEmptyTurn {
	self.vel = CGPointZero;
	self.firing = NO;
}

-(void)dealloc {
	[super dealloc];
}
@end
