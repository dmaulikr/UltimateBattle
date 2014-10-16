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
    self.l = [QuantumPilot resetPosition];
    [self emptyDeltas];
}

+ (CGPoint)resetPosition {
    return CGPointMake(160, 578 * 1/3);
}

- (id)init {
    self = [super init];
    if (self) {
        [self engage];
        _debris = 55555;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self assignInnerCircleRadius];
        });

        innerCircleRadius = 2;
    }
    return self;
}

- (void)assignInnerCircleRadius {
    innerRadius = innerCircleRadius * [QPBattlefield pulseRotation];
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
    return true;
}

- (void)setShipDrawColor {
     ccDrawColor4F(1, 1, 1, 1.0);
}

- (void)drawShip {
    ccDrawPoly(outerEdges, 4, YES);
}

- (void)drawCircle {
    [NSClassFromString(self.weapon) setDrawColor];
    ccDrawFilledCircle(self.innerTopEdge, innerRadius, 0, 30, NO);
}

- (void)draw {
    if ([self shouldDraw]) {
        [self setShipDrawColor];
        [self drawShip];
        [self drawCircle];
    }

    if (self.shield) {
        ccDrawCircle(self.innerTopEdge, radius, 0, 50, NO);
    }

    ccDrawPoly(drawingDeltas, drawFrameTotal, NO);
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

- (void)defineEdges {
    outerEdges[0] = ccp(self.l.x, self.l.y - shipTopHeight * [self yDirection]);
    outerEdges[1] = ccp(self.l.x - shipSideWidth, self.l.y);
    outerEdges[2] = ccp(self.l.x, self.l.y + shipBottomHeight * [self yDirection]);
    outerEdges[3] = ccp(self.l.x + shipSideWidth, self.l.y);
    self.innerTopEdge = ccp(self.l.x, self.l.y - innerTopHeight * [self yDirection]);
}

- (void)prepareShieldDraw {
    radius = 20 + (5 * self.shield);
}

- (void)prepareDeltaDraw {
    NSInteger index = 0;
    for (int i = self.fightingIteration; i < self.drawingIteration; i++) {
        drawingDeltas[index] = future[i];
        index++;
    }
    drawFrameTotal = self.drawingIteration - self.fightingIteration;
    if (drawFrameTotal < 0) {
        drawFrameTotal = 0;
    }
    
    [self assignInnerCircleRadius];
    [self prepareShieldDraw];
}

- (void)pulse {
    [self checkForFiringWeapon];
    [self calculateTarget];
    [self calculateVelocityForTarget];
    [self moveByVelocity];
    [self evaluateReachingTarget];
  //  [self setDrawingScaleByBattlefieldRhythm];
    
    [self copyDeltas];
    [self resetFiring];
    
    [self defineEdges];
    
    self.time++;
    
    [self prepareDeltaDraw];
    
//    if (self.active) {
  //  }
}


- (void)stationaryFire {
    future[self.drawingIteration] = self.l;
    [self fire];
}

- (void)addWaypoint:(CGPoint)l {
    if (l.x < 5) {
        l = ccp(5, l.y);
    } else if (l.x > 315) {
        l = ccp(315, l.y);
    } else if (l.y > 573) {
        l = ccp(l.x, 573);
    } else if (l.y < 5) {
        l = ccp(l.x, 5);
    }

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
        d.l = ccp(5000,500);
        return true;
    }
    
    return false;
}

- (bool)processBullet:(Bullet *)b {
    if ([self isCollidingWithBullet:b]) {
        b.l = ccp(5000,5000);
        if (!self.shield) {
            [self registerHit];
        } else {
            self.shield--;
            [[QPBattlefield f] registerShieldHit:self];
        }
        return true;
    }
    
    return false;
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

- (void)emptyDeltas {
    for (int i = 0; i < 4551; i++) {
        drawingDeltas[i] = ccp(-5,-5);
    }
}

- (void)dealloc {
    self.weapon = nil;
    self.clone = nil;
    self.bulletDelegate = nil;
    self.pilotDelegate = nil;
    [super dealloc];
}

@end


