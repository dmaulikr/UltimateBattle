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
#import "PlayerCopyShip.h"
#import "Bullets.h"
#import "cmpgames.h"

@implementation ultimatebattleViewController
@synthesize copies, player, bullets;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.copies = [NSMutableArray array];
	self.bullets = [NSMutableArray array];
	self.player = [[PlayerCopyShip alloc] initWithYFacing:-1];
	self.player.bullets = self.bullets;
	[self.view addSubview:self.player.imageView];
	[self startGame];
}

-(void)startGame {
	level = 0;
	currentKills = 0;
	[self nextLevel];
	[self.player addWeapon:[self newWeaponForLevel:1]];	
	timer = [[NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(loop) userInfo:nil repeats:YES] retain];
    
//    [self performSelector:@selector(copyMyShip) withObject:nil afterDelay:5];
}

-(void)copyMyShip {
    [self nextLevel];
}

-(Weapon *)newWeaponForLevel:(int)aLevel {
	if (aLevel == 1) {
		LaserGun *w = [[[LaserGun alloc] init] autorelease];
		return w;
	} else if (aLevel == 2) {
		TriGun *w = [[[TriGun alloc] init] autorelease];
		return w;
	} else if (aLevel == 3) {
		WideDoubleShotGun *w = [[[WideDoubleShotGun alloc] init] autorelease];
		return w;
	}

	TriGun *w = [[[TriGun alloc] init] autorelease];
	return w;
}

-(Ship *)copiedPlayerShip {
	Ship *newShip = [[[CopyShip alloc] initWithShip:self.player] autorelease];
	return newShip;
}

-(void)nextLevel {
	
	for (CopyShip *ship in self.copies) {
		[ship resetState];
	}
	
	level++;

	Ship *newShip = [self copiedPlayerShip];
	[self.view addSubview:newShip.imageView];
	newShip.drawn = YES;
	[self.copies addObject:newShip];
	newShip.bullets = self.bullets;
	
	currentKills = 0;
    
	[self.player eraseAllWeapons];
	[self.player addWeapon:[self newWeaponForLevel:level]];
	
    [self.player resetTurns];
}

-(void)checkForHitCopiesWithBullet:(Bullet *)b {
	for (CopyShip *c in self.copies) {
		if (b.vel.y < 0 && c.hp > 0 && GetDist(b.l, c.l) <= 30) {
            b.vel = CGPointZero;
            b.died = YES;
            b.l = CGPointZero;
			c.hp = 0;
			currentKills++;
		}
	}
}

-(void)checkForDrawingBullet:(Bullet *)b {
	if (!b.drawn) {
		[self.view addSubview:b.imageView];
		b.drawn = YES;
	}

}	

-(void)bulletLoop {
	for (Bullet *b in self.bullets) {
		[b tick];
		[self checkForDrawingBullet:b];
		[self checkForHitCopiesWithBullet:b];
	}
    
    NSMutableArray *badBullets = [NSMutableArray array];
    for (Bullet *b in self.bullets) {
        if (b.died) {
            [badBullets addObject:b];
        } else {
            if (b.l.y < 100 || b.l.y > 800) {
                [badBullets addObject:b];                
            }
        }
    }
    
    for (Bullet *badBullet in badBullets) {
        [badBullet.imageView removeFromSuperview];
        [self.bullets removeObject:badBullet];
    }
}

-(void)copyLoop {
	for (CopyShip *c in self.copies) {
		[c tick];
		if (!c.drawn && c.hp > 0) {
			[self.view addSubview:c.imageView];
			c.drawn = YES;
		}
	}
}

-(void)playerLoop {
	//Determine player's target 
	self.player.turn.firing = YES;
	[self.player tick];
}

-(void)checkForLevel {
	if (currentKills == [self.copies count]) {
		[self nextLevel];	
	}
}

-(void)loop {
	[self bulletLoop];
	[self copyLoop];
	[self playerLoop];
	[self checkForLevel];
}

-(void)tick {
	[self checkForLevel];
}

- (void)dealloc {
	self.copies = nil;
	[super dealloc];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{		
	UITouch *touch = [touches anyObject];
	gestureStartPoint = [touch locationInView:self.view];
	self.player.turn.targetLocation = gestureStartPoint;
	
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	currentPosition = [touch locationInView:self.view];
	self.player.turn.targetLocation = currentPosition;	
}	


@end
