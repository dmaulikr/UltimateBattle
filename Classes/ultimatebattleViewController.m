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

-(void)checkForLevel {
	if (currentKills == [self.copies count]) {
		[self nextLevel];	
	}
}

-(void)tick {
	[self checkForLevel];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)dealloc {
	self.copies = nil;
	[super dealloc];
}

@end
