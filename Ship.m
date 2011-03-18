//
//  Ship.m
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "Ship.h"


@implementation Ship
@synthesize currentWeaponIndex, moves, hp, weapons, bullets;
@synthesize engine;

-(id)init {
	self = [super init];
	if (self) {
		self.moves = [NSMutableArray array];
		self.weapons = [NSMutableArray array];
		self.hp = Ship_HP;
		self.turn = [[Turn alloc] init];
	}
	return self;
}

-(Weapon *)currentWeapon {
	return [self.weapons objectAtIndex:self.currentWeaponIndex];
}

-(Turn *)currentTurn {
	return self.turn;	
}

-(void)tick {
    
   //Determine our position
    self.l = [self.engine moveFrom:self.l withVel:self.vel];
    
	//Call super to move and animate us
	[super tick];

	if ([[self currentTurn] firing]) {
		NSArray *b = [[self currentWeapon] fireWithYFacing:self.yFacing];
		if (b) {
			[self.bullets addObjectsFromArray:b];
		}
	}
}

-(void)ensureValidWeaponIndex {
	if (self.currentWeaponIndex >= [self.weapons count] || self.currentWeaponIndex < 0){
		self.currentWeaponIndex = 0;	
	}
}

-(void)cycleWeapon {
	self.currentWeaponIndex++;
	[self ensureValidWeaponIndex];
}

-(void)changeWeapon:(int)newWeaponIndex {
	self.currentWeaponIndex = newWeaponIndex;
	[self ensureValidWeaponIndex];
}

-(void)resetTurn {
	//Default does nothing
}

-(void)dealloc {
	self.moves = nil;
	self.weapons = nil;
	self.turn = nil;
  self.engine = nil;
	[super dealloc];
}

@end