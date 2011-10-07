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
@synthesize l;
@synthesize vel;
@synthesize t;
@synthesize currentMoves;
@synthesize bulletDelegate;

+ (ClonePlayer *)samplePlayer {
    return [[[ClonePlayer alloc] initWithLocation:CGPointMake(384, 500)] autorelease];
}

- (id)initWithLocation:(CGPoint)location {
    self = [super init];
    if (self) {
        self.l = location;
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
    Bullet *b = [[[Bullet alloc] init] autorelease];
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

- (void)dealloc {
    self.bulletDelegate = nil;
    [currentMoves release];
    [super dealloc];
}

@end
