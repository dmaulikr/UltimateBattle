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

- (void)tick {
    self.vel = GetAngle(self.l, self.t);
    self.l = CombinedPoint(self.l, self.vel);
    Turn *turn = [[Turn alloc] init];
    turn.vel = self.vel;
    [self.currentMoves addObject:turn];
    [turn release];
}

- (void)dealloc {
    [currentMoves release];
    [super dealloc];
}

@end
