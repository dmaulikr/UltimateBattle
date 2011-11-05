//
//  ClonePlayer.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "ClonePlayer.h"
#import "VRGeometry.h"
#import "SingleLaser.h"

@implementation ClonePlayer
@synthesize l, vel, t, radius;
@synthesize currentMoves;
@synthesize bulletDelegate;
@synthesize weapon;
@synthesize health;

+ (ClonePlayer *)samplePlayer {
    return [[[ClonePlayer alloc] init] autorelease];
}

+ (CGPoint)defaultLocation {
    return CGPointMake(384,724);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"x:%f y:%f vx:%f vy:%f",self.l.x, self.l.y, self.vel.x, self.vel.y];
}

- (void)generateTurn {
    Turn *turn = [[Turn alloc] init];
    [self.currentMoves addObject:turn];    
    [turn release];
}

- (void)assignDefaultWeapon {
    SingleLaser *w = [[SingleLaser alloc] init];
    self.weapon = w;
    [w release];
}

- (id)init {
    self = [super init];
    if (self) {
        self.l = [ClonePlayer defaultLocation];
        self.t = self.l;
        self.currentMoves = [NSMutableArray array];
        [self generateTurn];
        [self assignDefaultWeapon];
        self.health = 1;
    }
    return self;
}

- (Bullet *)newBullet {
    Bullet *b = [[[Bullet alloc] initWithLocation:self.l velocity:CGPointMake(0,-3)] autorelease];
    b.identifier = [self identifier];
    return b;
}

- (BOOL)hasTurn {
    return [[self currentMoves] count] > 0;
}

- (void)fireBullet {
    Bullet *b = [self newBullet];
    [self.bulletDelegate addBullet:b];
}

- (BOOL)firstTurn {
    return [[self currentMoves] count] == 1;
}

- (NSInteger)identifier {
    return 0;
}

- (void)tick {
    if ([self isFiring]) {
        Bullet *b = [self newBullet];
       [self.bulletDelegate addBullet:b];
    }
    
    self.vel = GetAngle(self.l, self.t);
    self.l = CombinedPoint(self.l, self.vel);
    [self generateTurn];
    self.currentTurn.vel = self.vel;
}

- (Turn *)currentTurn {
    if (![self hasTurn]) {
        [self generateTurn];
    }
    return [self.currentMoves lastObject];
}

- (void)hit:(Bullet *)b {
    if ([b identifier] != [self identifier]) {
        self.health--;
        b.finished = YES;
    }
}

- (void)fire {
    self.currentTurn.firing = YES;
    [self.bulletDelegate fired];
}

- (BOOL)isFiring {
    if ([self hasTurn]) {
        return self.currentTurn.firing;
    }
    
    return NO;
}

- (void)reset {
    [self.currentMoves removeAllObjects];
    self.vel = CGPointZero;
    self.l = [ClonePlayer defaultLocation];
    self.t = self.l;
}

- (void)dealloc {
    self.bulletDelegate = nil;
    [currentMoves release];
    [weapon release];
    [super dealloc];
}

@end
