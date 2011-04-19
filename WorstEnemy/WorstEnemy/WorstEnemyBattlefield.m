//
//  WorstEnemyBattlefield.m
//  WorstEnemy
//
//  Created by X3N0 on 4/18/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import "WorstEnemyBattlefield.h"


@implementation WorstEnemyBattlefield
@synthesize copies, player, bullets;
@synthesize layer;

-(id)initWithLayer:(CCLayer *)aLayer {
	self = [super init];
	if (self) {
		self.layer = aLayer;
		self.copies = [NSMutableArray array];
		self.bullets = [NSMutableArray array];
		self.player = [[PlayerCopyShip alloc] initWithYFacing:-1];		
	}
	
	return self;
	
}

-(UltimateWeapon *)newWeaponForLevel:(int)aLevel {
	return nil;
}

-(void)startGame{
}
-(void)nextLevel {
	
}

@end