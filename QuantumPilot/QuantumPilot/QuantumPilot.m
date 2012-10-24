//
//  QuantumPilot.m
//  QuantumPilot
//
//  Created by X3N0 on 10/21/12.
//
//

#import "QuantumPilot.h"
#import "VRGeometry.h"
#import "QuantumClone.h"

@interface QuantumPilot()

struct future {
    CGPoint waypoints[4001];
};



@property (nonatomic, assign) struct future future;


@end

@implementation QuantumPilot
@synthesize l = _l, vel = _vel, speed = _speed, firing = _firing, t = _t;
@synthesize future = _future;
@synthesize drawingIteration = _drawingIteration;
@synthesize fightingIteration = _fightingIteration;
@synthesize clone = _clone;

static float shipTopHeight = 50;
static float shipSideWidth = 15;
static float shipBottomHeight = 10;
static float innerTopHeight = 10;

static float innerPointRatio = .7;

- (NSInteger)yDirection {
    return -1;
}

- (id)init {
    self = [super init];
    if (self) {
        _speed = 5;
    }
    return self;
}

- (void)draw {
    outerEdges[0] = ccp(self.l.x, self.l.y - shipTopHeight * [self yDirection]);
    outerEdges[1] = ccp(self.l.x - shipSideWidth, self.l.y);
    outerEdges[3] = ccp(self.l.x + shipSideWidth, self.l.y);

    self.vel = ccp(self.vel.x - .1, self.vel.y);
    if (self.vel.x < -5) {
        self.vel = ccp(5, self.l.y);
    }

    
    float xVelPercentage = fabsf(self.vel.x) / self.speed;
    NSInteger xSign = self.vel.x < 0 ? -1 : 1;
    float topXOffset = xVelPercentage * (innerPointRatio * shipSideWidth) * xSign;
    float bottomXOffset = xVelPercentage * (innerPointRatio *shipSideWidth) * -xSign;

    float heightRatio = (1-xVelPercentage);
    
    outerEdges[2] = ccp(self.l.x + bottomXOffset, self.l.y - (shipBottomHeight * heightRatio));

    innerTopEdge = ccp(self.l.x + topXOffset, self.l.y - (innerTopHeight * heightRatio ) * [self yDirection]);
    ccDrawPoly(outerEdges, 4, YES);
    
    ccDrawLine(outerEdges[1], innerTopEdge);
    ccDrawLine(innerTopEdge, outerEdges[3]);
    ccDrawLine(outerEdges[2], outerEdges[0]);
    ccDrawLine(innerTopEdge, outerEdges[0]);
}

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

- (void)copyDeltas {
    [self.clone recordVelocity:self.vel firing:self.firing];
}

- (void)tick {
    [self checkForFiringWeapon];
    [self calculateTarget];
    [self calculateVelocityForTarget];
    [self moveByVelocity];
    [self evaluateReachingTarget];
    [self setDrawingScaleByBattlefieldRhythm];
    
    [self copyDeltas];
}

- (void)addWaypoint:(CGPoint)l {
    struct future f = self.future;
    f.waypoints[self.drawingIteration] = l;
    self.future = f;
}

@end





















