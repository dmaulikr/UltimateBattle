//
//  Move.m
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "Turn.h"


@implementation Turn
@synthesize l, targetLocation, vel, firing, weaponIndex;

-(id)init {
	self = [super init];
	if (self) {
		[self becomeEmptyTurn];
	}
	return self;
}

-(id)copyWithZone:(NSZone *)zone {
    return self;   
}

-(NSString *)description {
    return [NSString stringWithFormat:@"X: %f   Y: %f",self.vel.x, self.vel.y];
}

-(void)becomeEmptyTurn {
	self.vel = CGPointZero;
    self.targetLocation = CGPointZero;
    self.firing = NO;
	self.weaponIndex = -1;
}

-(void)dealloc {
	[super dealloc];
}

@end