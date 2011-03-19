//
//  ultimatebattleViewController.m
//  ultimatebattle
//
//  Created by X3N0 on 3/11/11.
//  Copyright 2011 Rage Creations. All rights reserved.
//

#import "ultimatebattleViewController.h"
#import "Ship.h"
#import "LaserGun.h"
#import "CopyShip.h"
#import "Bullets.h"

@implementation ultimatebattleViewController
@synthesize copies, player, bullets;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.copies = [NSMutableArray array];
}

-(Weapon *)newWeaponForLevel:(int)aLevel {

	if (aLevel == 1) {
		LaserGun *w = [[[LaserGun alloc] initWithYFacing:1] autorelease];
		return w;
	} else if (aLevel == 2) {
		TriGun *w = [[[TriGun alloc] initWithYFacing:1] autorelease];
		return w;
	}
	
		
	return nil;
}

-(Ship *)newShipForLevel:(int)aLevel {
	Ship *newShip = [[[CopyShip alloc] initWithShip:self.player] autorelease];
	[newShip addWeapon:[self newWeaponForLevel:aLevel]];
	return newShip;
}

-(void)nextLevel {
	for (CopyShip *ship in self.copies) {
		[ship resetState];
	}
	
	level++;
	

	Ship *newShip = [self newShipForLevel:level];
	[self.copies addObject:newShip];
	newShip.bullets = self.bullets;
	[newShip release];
	
	currentKills = 0;
}

-(void)bulletLoop {
	for (Bullet *b in self.bullets) {
		[b tick];
	}
}

-(void)copyLoop {
	for (CopyShip *c in self.copies) {
		[c tick];
	}
}

-(void)playerLoop {
	//Determine player's target 
	[self.player tick];	
}

-(void)loop {
	[self bulletLoop];
	[self copyLoop];
	[self playerLoop];
}

-(void)checkForLevel {
	if (currentKills == [self.copies count]) {
		[self nextLevel];	
	}
}

-(void)tick {
	[self checkForLevel];
}

- (void)dealloc {
	self.copies = nil;
	[super dealloc];
}

@end
