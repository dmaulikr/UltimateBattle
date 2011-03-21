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
		NSMutableArray *turns = [[NSMutableArray arrayWithArray:ship.moves] retain];
		
		if ([turns count] > 0) {
			for (Turn *t in turns) {
				t.vel = CGPointMake(-t.vel.x, t.vel.y);
			}
			self.moves =2 turns;
		} else {
				Turn *t = [[Turn alloc] init];
				t.vel = CGPointMake(0,0);
				[self.moves addObject:t];
				[t release];
		}
		
		[turns release];
		
		
		NSMutableArray *weps = [[NSMutableArray arrayWithArray:ship.weapons] retain];
		self.weapons = weps;
		[weps release];
		self.hp = 1;
		
		[self resetState];
	}
	return self;
}

-(void)resetState {
	currentTurnIndex = 0;
	self.hp = 1;
	self.drawn = NO;
	self.died = NO;
	self.l = CGPointMake(382,340);
	for (Weapon *w in self.weapons) {
		w.repeatLeft = 0;	
	}
}

-(Turn *)currentTurn {
	Turn *ct = [self.moves objectAtIndex:currentTurnIndex];
	return ct;
}

-(void)tick {
	[super tick];
	currentTurnIndex++;
	if (currentTurnIndex >= [self.moves count]) {
		[self resetState];
	}
	
	if (self.hp <= 0 && !self.died) {
		self.died = YES;
		self.drawn = NO;
		[self.imageView removeFromSuperview];
	}
	
	
}

-(void)resetTurn {
//	currentTurnIndex = 0;	
//	NSLog(@"resetting turn l.x: %f",self.l.x);
//	self.l = ((Turn *)[self currentTurn]).l;
//	NSLog(@"POST resetting turn l.x: %f",self.l.x);	
}



@end