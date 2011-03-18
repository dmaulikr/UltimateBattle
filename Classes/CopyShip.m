//
//  CopyShip.m
//  ultimatebattle
//
//  Created by X3N0 on 3/17/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "CopyShip.h"


@implementation CopyShip

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