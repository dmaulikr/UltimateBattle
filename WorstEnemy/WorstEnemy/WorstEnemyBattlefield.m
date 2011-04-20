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
		[self.layer addChild:self.player.sprite];
	}
	
	return self;
	
}

-(UltimateWeapon *)newWeaponForLevel:(int)aLevel {
	return nil;
}

-(void)startGame{
}

-(UltimateShip *)copiedPlayerShip {
	UltimateShip *newShip = [[[CopyShip alloc] initWithShip:self.player] autorelease];
	return newShip;
}

-(void)nextLevel {
	
	self.player.l = CGPointMake(384,700);
	
	for (CopyShip *ship in self.copies) {
		[ship resetState];
	}
	
	level++;
	
	UltimateShip *newShip = [self copiedPlayerShip];
	[self.layer addChild:newShip.sprite];
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
		[self.layer addChild:b.sprite];
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
			[self.layer addChild:c.sprite];
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

@end