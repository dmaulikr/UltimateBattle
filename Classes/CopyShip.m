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
		
		self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ship1_Bank1_21.png"]];
		NSMutableArray *turns = ship.moves;
		
		if ([turns count] > 0) {
			for (Turn *t in turns) {
				t.vel = CGPointMake(-t.vel.x, t.vel.y);
			}
			self.moves = turns;
		} else {
			Turn *t = [[Turn alloc] init];
			[self.moves addObject:t];
			[t release];
		}
		
		

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