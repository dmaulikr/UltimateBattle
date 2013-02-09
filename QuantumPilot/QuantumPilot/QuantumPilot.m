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
@synthesize pilotDelegate = _pilotDelegate;

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

    
    ccDrawColor4F(1, 1, 1, 1.0);
    CGPoint drawingDeltas[4001];
    NSInteger index = 0;
    for (int i = self.fightingIteration; i < self.drawingIteration; i++) {
        drawingDeltas[index] = future[i];
        index++;
    }
    NSInteger drawFrameTotal = self.drawingIteration - self.fightingIteration;
    if (drawFrameTotal < 0) {
        drawFrameTotal = 0;
    }
    ccDrawPoly(drawingDeltas, drawFrameTotal, NO);

    
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
            [self.pilotDelegate pilotReachedEndOfFutureWaypoints];
            [self resetIterations];            
        }
    }
}

- (void)setDrawingScaleByBattlefieldRhythm {
    //
}

- (void)copyDeltas {
    [self.clone recordVelocity:self.vel firing:self.firing];
}

- (void)pulse {
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

- (CGPoint)deltasAtIndex:(NSInteger)index {
    return future[index];
}

- (CGPoint)deltaTarget {
    return future[self.fightingIteration];
}

- (CGPoint *)drawShape {
    return outerEdges;
}

- (BOOL)isCollidingWithBullet:(Bullet *)b {
    return shapeOfSizeContainsPoint([self drawShape], 4, b.l);
}

- (BOOL)touchesPoint:(CGPoint)l {
    return GetDistance(self.l, l) <= QPBF_PLAYER_TAP_RANGE;
}

- (void)resetIterations {
    self.drawingIteration = 0;
    self.fightingIteration = 0;
}


@end


