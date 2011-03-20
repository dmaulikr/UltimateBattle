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
	self = [super initWithYFacing:1];
	if (self) {
		
		self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ship1_Bank1_21.png"]];
		NSMutableArray *turns = ship.moves;
		
		if ([turns count] > 0) {
			for (Turn *t in turns) {
				t.vel = CGPointMake(-t.vel.x, t.vel.y);
			}
			self.moves = turns;
		} else {
			for (int i = 0; i < 100; i++) {
				Turn *t = [[Turn alloc] init];
//				t.l = CGPointMake(382,340);
				t.vel = CGPointMake(-i, -3);
				[self.moves addObject:t];
				[t release];
			}
		}
		
		

		self.weapons = ship.weapons;
		self.hp = 1;
		
		[self resetState];
	}
	return self;
}

-(void)resetState {
	currentTurnIndex = 0;
	self.l = CGPointMake(382,340);
	for (Weapon *w in self.weapons) {
		w.repeatLeft = 0;	
	}
}

-(Turn *)currentTurn {
	Turn *ct = [self.moves objectAtIndex:currentTurnIndex];
	NSLog(@"ct.vel.x: %f",ct.vel.x);
	return ct;
}

-(void)tick {
	NSLog(@"tick l.x: %f",self.l.x);
	[super tick];
	NSLog(@"POST Super tick l.x: %f",self.l.x);
	currentTurnIndex++;
	if (currentTurnIndex >= [self.moves count]) {
		[self resetState];
	}
}

-(void)resetTurn {
//	currentTurnIndex = 0;	
//	NSLog(@"resetting turn l.x: %f",self.l.x);
//	self.l = ((Turn *)[self currentTurn]).l;
//	NSLog(@"POST resetting turn l.x: %f",self.l.x);	
}

@end