//
//  ClonePlayer.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "ClonePlayer.h"
#import "VRGeometry.h"

@implementation ClonePlayer
@synthesize l, vel, t, radius;
@synthesize currentMoves;
@synthesize bulletDelegate;

+ (ClonePlayer *)samplePlayer {
    return [[[ClonePlayer alloc] initWithLocation:CGPointMake(384, 724)] autorelease];
}

+ (CGPoint)defaultLocation {
    return CGPointMake(384,724);
}

- (id)init {
    self = [super init];
    if (self) {
        self.l = [ClonePlayer defaultLocation];
        self.t = CGPointZero;
        self.currentMoves = [NSMutableArray array];
    }
    return self;
}

- (void)generateTurn {
    Turn *turn = [[Turn alloc] init];
    [self.currentMoves addObject:turn];    
    [turn release];
}

- (Bullet *)newBullet {
    Bullet *b = [[[Bullet alloc] initWithLocation:self.l velocity:CGPointMake(0,-3)] autorelease];
    return b;
}

- (BOOL)hasTurn {
    return [[self currentMoves] count] > 0;
}

- (void)tick {
    if ([self hasTurn]) {
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

- (void)fire {
    self.currentTurn.firing = YES;
}

- (BOOL)isFiring {
    return self.currentTurn.firing;
}

- (void)reset {
    [self.currentMoves removeAllObjects];
    self.vel = CGPointZero;
    self.l = [ClonePlayer defaultLocation];
}

- (void)dealloc {
    self.bulletDelegate = nil;
    [currentMoves release];
    [super dealloc];
}

@end
