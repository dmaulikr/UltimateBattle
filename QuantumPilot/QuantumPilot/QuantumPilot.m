#import "QuantumPilot.h"
#import "VRGeometry.h"
#import "QuantumClone.h"
#import "QPBattlefield.h"
#import "SingleLaserCannon.h"
#import "ShieldDebris.h"

@interface QuantumPilot() {
    CGPoint future[4551];
    CGPoint circles[4551];
}

@end

@implementation QuantumPilot
//iPad
//static float shipTopHeight = 50;
//static float shipSideWidth = 15;
//static float shipBottomHeight = 10;
//static float innerTopHeight = 10;
//static float innerCircleRadius = 4.5;

static float shipTopHeight = 28;
static float shipSideWidth = 8.5;
static float shipBottomHeight = 5.75;
static float innerTopHeight = 5.75;
static float innerCircleRadius = 2.6;


static float outerCircleRadius = 60;

- (NSInteger)yDirection {
    return -1;
}

- (void)resetPosition {
//    self.l = CGPointMake(384, 170);
    self.l = [QuantumPilot resetPosition];
}

+ (CGPoint)resetPosition {
    return CGPointMake(160, 578 * 1/3);
}

- (id)init {
    self = [super init];
    if (self) {
        [self engage];
        _debris = 55555;
    }
    return self;
}

- (void)installWeapon:(NSString *)w {
    self.weapon = nil;
    if (!w) {
        self.weapon = (arc4random() % 2) == 0 ? @"SingleLaserCannon" : @"SplitLaserCannon";
    } else {
        self.weapon = w;
    }
}

- (void)installWeapon {
    [self installWeapon:nil];
}

- (void)engage {
    [self resetIterations];
    [self installWeapon];
    self.active = YES;
    [self resetPosition];
    self.shield = 0;
}

- (bool)shouldDraw {
    return !self.blinking || [QPBattlefield rhythmScale] > .5;
}

- (void)setShipDrawColor {
     ccDrawColor4F(1, 1, 1, 1.0);
}

- (void)drawShip {
    outerEdges[0] = ccp(self.l.x, self.l.y - shipTopHeight * [self yDirection]);
    outerEdges[1] = ccp(self.l.x - shipSideWidth, self.l.y);
    outerEdges[2] = ccp(self.l.x, self.l.y + shipBottomHeight * [self yDirection]);
    outerEdges[3] = ccp(self.l.x + shipSideWidth, self.l.y);
    self.innerTopEdge = ccp(self.l.x, self.l.y - innerTopHeight * [self yDirection]);
    
    ccDrawPoly(outerEdges, 4, YES);
}

- (void)drawCircle {
    if (self.shield) {
        ccDrawColor4F(1 - [QPBattlefield pulseRotation], 1  - [QPBattlefield pulseRotation], 1  - [QPBattlefield pulseRotation], 1);
        ccDrawCircle(self.innerTopEdge, 20 + (5 * self.shield), 0, 100, NO);
    }
    [NSClassFromString(self.weapon) setDrawColor];
    ccDrawFilledCircle(self.innerTopEdge, innerCircleRadius * [QPBattlefield pulseRotation], 0, 100, NO);
}

- (void)draw {
    if ([self shouldDraw]) {
        [self setShipDrawColor];
        [self drawShip];
        [self drawCircle];
    }
    if (self.active) {
        ccDrawColor4F(1, 1, 1, 1.0);
        CGPoint drawingDeltas[4551];
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
}

- (BOOL)isFiring {
    return self.firing;
}

- (NSInteger)fireDirection {
    return -[self yDirection];
}

- (void)sendBulletsToBattlefield {
    Class w = NSClassFromString(self.weapon);
    [self.bulletDelegate bulletsFired:[w bulletsForLocation:outerEdges[0] direction:[self fireDirection]]];
}

- (void)checkForFiringWeapon {
    if ([self isFiring]) {
        [self sendBulletsToBattlefield];
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
            future[self.fightingIteration] = self.l;
            self.drawingIteration++;
//            [self.pilotDelegate pilotReachedEndOfFutureWaypoints];
//            [self resetIterations];            
        }
    }
}

- (void)setDrawingScaleByBattlefieldRhythm {
    //
}

- (void)copyDeltas {
    [self.clone recordVelocity:ccp(self.vel.x, -self.vel.y) firing:self.firing];
}

- (void)resetFiring {
    self.firing = NO;
}

- (void)pulse {
    [self checkForFiringWeapon];
    [self calculateTarget];
    [self calculateVelocityForTarget];
    [self moveByVelocity];
    [self evaluateReachingTarget];
    [self setDrawingScaleByBattlefieldRhythm];
    
    [self copyDeltas];
    [self resetFiring];
    
    self.time++;
    
    [self frame];
}

- (void)frame {
    CGPoint ll = self.l;
    if (ll.x > 315) {
        ll.x = 315;
    } else if (ll.x < 5) {
        ll.x = 5;
    } else if (ll.y > 573) {
        ll.y = 573;
    } else if (ll.y < 5) {
        ll.y = 5;
    }
    
    self.l = ll;
}

- (void)stationaryFire {
    future[self.drawingIteration] = self.l;
    [self fire];
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

- (BOOL)isCollidingWithBullet:(Bullet *)b {
    return shapeOfSizeContainsPoint(outerEdges, 4, b.l);
}

- (BOOL)isCollidingWithDebris:(Debris *)d {
    return GetDistance(self.l, d.l) < 50;
}

- (void)registerHit {
    self.active = NO;
}

- (BOOL)processDebris:(Debris *)d {
    if ([d isKindOfClass:[ShieldDebris class]]) {
        return false;
    }
    if ([self isCollidingWithDebris:d]) {
        self.debris += [d level];
        return true;
    }
    
    return false;
}

- (void)processBullet:(Bullet *)b {
    if ([self isCollidingWithBullet:b]) {
        b.l = ccp(5000,5000);
        if (!self.shield) {
            [self registerHit];
        } else {
            self.shield--;
            [[QPBattlefield f] registerShieldHit:self];
        }

    }
}

- (BOOL)touchesPoint:(CGPoint)l {
    return GetDistance(self.l, l) <= QPBF_PLAYER_TAP_RANGE;
}

- (void)resetIterations {
    self.drawingIteration = 0;
    self.fightingIteration = 0;
}

- (void)fire {
    if (!self.firing) {
        self.firing = true;
    }
}

- (void)createClone {
    self.clone = [[[QuantumClone alloc] init] autorelease];
    self.clone.active = YES;
    self.clone.weapon = self.weapon;
}

- (void)setSpeed:(float)speed {
    _speed = speed;
}

- (void)installShield {
    self.shield++;
}

@end


