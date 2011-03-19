//
//  CopyShip.m
//  ultimatebattle
//
//  Created by X3N0 on 3/17/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "CopyShip.h"


@implementation CopyShip

-(id)initWithShip:(Ship *)ship {
	self = [super init];
	if (self) {
		NSMutableArray *turns = ship.moves;
		for (Turn *t in turns) {
			t.vel = CGPointMake(-t.vel.x, t.vel.y);
		}
		
		self.moves = turns;
		self.weapons = ship.weapons;
		self.hp = 1;
		
	}
	return self;
}

-(void)resetState {
	self.l = CGPointMake(382,340);
	for (Weapon *w in self.weapons) {
		w.repeatLeft = 0;	
	}
}

-(Turn *)currentTurn {
	return [self.moves objectAtIndex:currentTurnIndex];	
}

-(void)tick {
	[super tick];
	currentTurnIndex++;
	if (currentTurnIndex >= [self.moves count]) {
		[self resetTurn];
	}
}

-(void)resetTurn {
	currentTurnIndex = 0;	
	self.l = ((Turn *)[self currentTurn]).l;
}

@end