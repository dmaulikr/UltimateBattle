//
//  CopyShip.m
//  ultimatebattle
//
//  Created by X3N0 on 3/17/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "CopyShip.h"
#import "NSObject+Properties.h"

@implementation CopyShip

-(id)initWithShip:(UltimateShip *)ship {
	self = [super initWithYFacing:-1];
	if (self) {
	
		self.sprite = [CCSprite spriteWithFile:@"Ship1_Bank1_21.png"];
        
        NSMutableArray *turns = [NSMutableArray array];

        for (Turn *ot in ship.moves) {
			Turn *t = [ot magicCopy];
            [turns addObject:t];
        }
		
		if ([turns count] > 0) {
			for (Turn *t in turns) {
				t.vel = CGPointMake(t.vel.x, -t.vel.y);
			}
			self.moves =turns;
		} else {
				Turn *t = [[Turn alloc] init];
				t.vel = CGPointMake(0,0);
                [self.moves removeAllObjects];
				[self.moves addObject:t];
				[t release];
		}
        
		self.weapons = [NSMutableArray array];
        for (UltimateWeapon *owep in ship.weapons) {
			UltimateWeapon *nw = [owep magicCopy];
            [self.weapons addObject:nw];
        }
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
	self.l = CGPointMake(384,1024-SHIP_PLACEMENT_HEIGHT);
	for (UltimateWeapon *w in self.weapons) {
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
		[self resetTurn];
	}
	
	if (self.hp <= 0 && !self.died) {
		self.died = YES;
		self.drawn = NO;
		NSLog(@"Remove sprite from super layer");
	}
}

-(void)resetTurn {
	currentTurnIndex = 0;
	self.l = CGPointMake(384,1024-SHIP_PLACEMENT_HEIGHT);
}

@end