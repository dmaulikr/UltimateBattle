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

-(id)initWithYFacing:(int)facing {
	self = [super init];
	if (self) {
		self.moves = [NSMutableArray array];
		self.weapons = [NSMutableArray array];
		self.hp = Ship_HP;
		self.turn = [[Turn alloc] init];
		self.currentWeaponIndex = 0;
		self.yFacing = facing;
	}
	return self;
}

-(Weapon *)currentWeapon {
	if ([self.weapons count] > 0) {
		return [self.weapons objectAtIndex:self.currentWeaponIndex];
	}
	
	return nil;
}

-(void)move {
	self.l = CGPointMake(self.l.x + ((Turn *)[self currentTurn]).vel.x, self.l.y + ((Turn *)[self currentTurn]).vel.y);
}

-(void)animate {
	self.imageView.center = self.l;	
}

-(void)tick {
	//Call super to move and animate us
	[super tick];
	
	if ([self currentWeapon]) {
        [(Weapon *)[self currentWeapon] tick];
    }
    
	
    if (self.hp > 0) {
	if ([[self currentTurn] firing]) {
		NSArray *b = [[self currentWeapon] fireWithYFacing:self.yFacing from:self.l];
		if (b) {
			NSLog(@"adding bullets: %@",b);
			[self.bullets addObjectsFromArray:b];
		}
			
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

-(void)eraseAllWeapons {
	[self.weapons removeAllObjects];	
}

-(void)resetTurns {
	[self.moves removeAllObjects];	
}

-(void)addWeapon:(Weapon *)weapon {
	NSLog(@"Adding weapon with repeatleft: %d",weapon.repeatLeft);
	[self.weapons addObject:weapon];
}

-(void)resetTurn {
	//Default does nothing
}

-(void)dealloc {
	self.moves = nil;
	self.weapons = nil;
	self.turn = nil;
	[super dealloc];
}

@end