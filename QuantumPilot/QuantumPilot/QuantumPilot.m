#import "QuantumPilot.h"
#import "VRGeometry.h"
#import "QuantumClone.h"
#import "QPBattlefield.h"

@interface QuantumPilot() {
    CGPoint future[4001];
}

@end

@implementation QuantumPilot
@synthesize l = _l, vel = _vel, speed = _speed, firing = _firing, t = _t;
@synthesize drawingIteration = _drawingIteration;
@synthesize fightingIteration = _fightingIteration;
@synthesize clone = _clone;
@synthesize bulletDelegate = _bulletDelegate;

static float shipTopHeight = 50;
static float shipSideWidth = 15;
static float shipBottomHeight = 10;
static float innerTopHeight = 10;

static float innerCircleRadius = 4.5;

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
    outerEdges[2] = ccp(self.l.x, self.l.y - shipBottomHeight);
    outerEdges[3] = ccp(self.l.x + shipSideWidth, self.l.y);
    innerTopEdge = ccp(self.l.x, self.l.y - innerTopHeight * [self yDirection]);
    
    ccDrawPoly(outerEdges, 4, YES);
    ccDrawFilledCircle(innerTopEdge, innerCircleRadius * [QPBattlefield pulseRotation], 0, 100, NO);

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
    return future[self.fightingIteration];
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
    future[self.drawingIteration] = l;
}

@end





















