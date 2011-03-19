//
//  PlayerCopyShip.m
//  ultimatebattle
//
//  Created by X3N0 on 3/17/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "PlayerCopyShip.h"


@implementation PlayerCopyShip



-(void)tick{
	[super tick];
	//Store this current turn
	[self.moves addObject:self.turn];
	
	//Clear out the turn's instructions
	[self.turn becomeEmptyTurn];
}	

@end
