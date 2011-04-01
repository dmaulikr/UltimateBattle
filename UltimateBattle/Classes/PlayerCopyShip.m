//
//  PlayerCopyShip.m
//  ultimatebattle
//
//  Created by X3N0 on 3/17/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "PlayerCopyShip.h"


@implementation PlayerCopyShip

-(id)initWithYFacing:(int)facing {
	self = [super initWithYFacing:facing];
	if (self) {
		self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 84,70)];
		self.imageView.image = [UIImage imageNamed:@"Shp2_Bank2_30.png"];
		self.l = CGPointMake(384,700);
	}
	return self;
}


-(void)tick{
	[super tick];
	//Store this current turn

    Turn *t = [[Turn alloc] init];
    t.vel = self.turn.vel;
    t.firing = self.turn.firing;
    t.targetLocation = self.turn.targetLocation;
    t.weaponIndex = self.turn.weaponIndex;
	[self.moves addObject:t];
    [t release];
    
	//Clear out the turn's instructions
//	[self.turn becomeEmptyTurn];
}	

@end
