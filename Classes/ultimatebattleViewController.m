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

@implementation ultimatebattleViewController
@synthesize copies, player, bullets;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.copies = [NSMutableArray array];
}

-(void)nextLevel {
	for (CopyShip *ship in self.copies) {
		[ship resetState];
	}
	
	Ship *newShip = [[CopyShip alloc] initWithShip:self.player];
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
