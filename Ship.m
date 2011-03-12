//
//  Ship.m
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "Ship.h"


@implementation Ship
@synthesize moves, hp, weapon, bullets;

-(id)init {
	self = [super init];
	if (self) {
		self.moves = [NSMutableArray array];
		self.weapon = [[Weapon alloc] init];
		self.hp = Ship_HP;
	}
	return self;
}

-(void)tick {
	//Call super to move and animate us
	[super tick];
	if ([self.turn firing]) {
		NSArray *b = [self.weapon fireWithYFacing:self.yFacing];
		if (b) {
			[self.bullets addObjectsFromArray:b];
		}
	}
	//Store this current turn
	[self.moves addObject:self.turn];
	
	
	//Clear out the turn's instructions
	[self.turn becomeEmptyTurn];
	
}
	
-(void)dealloc {
	self.moves = nil;
	self.weapon = nil;
	[super dealloc];
}

@end