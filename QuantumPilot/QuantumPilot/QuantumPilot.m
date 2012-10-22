//
//  QuantumPilot.m
//  QuantumPilot
//
//  Created by X3N0 on 10/21/12.
//
//

#import "QuantumPilot.h"
#import "VRGeometry.h"

@interface QuantumPilot()

struct future {
    CGPoint waypoints[4001];
};
@property (nonatomic) struct future future;


@end

@implementation QuantumPilot
@synthesize l = _l, vel = _vel, speed = _speed, firing = _firing, t = _t;
@synthesize future = _future;
@synthesize drawingIteration = _drawingIteration;
@synthesize fightingIteration = _fightingIteration;

- (BOOL)isFiring {
    return self.firing;
}

- (void)checkForFiringWeapon {
    if ([self isFiring]) {
        //Send bullets to delegate
    }
}

- (CGPoint)currentWaypoint {
    return self.future.waypoints[self.fightingIteration];
}

- (void)calculateTarget {
    self.t = [self currentWaypoint];
}

- (void)calculateVelocityForTarget {
    float distanceToTarget = GetDistance(self.l, self.t);
    if (distanceToTarget >= self.speed) {
        self.vel = GetAngle(self.l, self.t);
        self.vel = MultipliedPoint(self.vel, self.speed);
    } else {
        if (distanceToTarget > 0) {
            self.vel = GetAngle(self.l, self.t);
            self.vel = MultipliedPoint(self.vel, distanceToTarget);
        } else {
            self.vel = CGPointZero;
        }
    }
}

- (void)moveByVelocity {
    self.l = CombinedPoint(self.l, self.vel);
}

- (BOOL)reachedTarget {
    return GetDistance(self.l, [self currentWaypoint]) == 0;
}

- (void)evaluateReachingTarget {
    if ([self reachedTarget]) {
        self.fightingIteration++;
        if (self.fightingIteration == self.drawingIteration) {
            //Tell battlefield: REACHED last waypoint, SHIFT  to DRAWING
        }
    }
}

- (void)setDrawingScaleByBattlefieldRhythm {
    //
}

- (void)tick {
    [self checkForFiringWeapon];
    [self calculateTarget];
    [self calculateVelocityForTarget];
    [self moveByVelocity];
    [self evaluateReachingTarget];
    [self setDrawingScaleByBattlefieldRhythm];
}

- (void)draw {
    
}

@end





















