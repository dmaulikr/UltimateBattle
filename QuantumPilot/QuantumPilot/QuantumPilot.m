#import "QuantumPilot.h"
#import "VRGeometry.h"
#import "QuantumClone.h"
#import "QPBattlefield.h"
#import "SingleLaserCannon.h"
#import "ShieldDebris.h"
#import "Arsenal.h"

@interface QuantumPilot() {
    CGPoint future[8551];
    CGPoint circles[8551];
    CGPoint weapon;
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
//static float innerCircleRadius = 1.3; //2.6
//static float outerCircleRadius = 60;

- (NSInteger)yDirection {
    return -1;
}

- (void)resetPosition {
    self.l = [QuantumPilot resetPosition];
    [self emptyDeltas];
}

+ (CGPoint)resetPosition {
    float y = [[UIScreen mainScreen] bounds].size.height;
    return CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, y * 1/3);
}

- (id)init {
    self = [super init];
    if (self) {
        [self engage];
        _debris = 0;
        _fieldSize = [[UIScreen mainScreen] bounds].size;
    }
    return self;
}

- (void)assignInnerCircleRadius {
    innerRadius = 1.7 * [QPBattlefield pulseRotation];
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

- (void)announceWeapon {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WeaponLabel" object:[NSNumber numberWithInteger:weapon.x]];
}

- (void)engage {
    [self resetIterations];
    [self installWeapon];
    self.active = YES;
    [self resetPosition];
    self.shield = 0;
    weapon = ccp(weapon.x, 0);
    [self announceWeapon];
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
    [[Arsenal weaponIndexedFromArsenal:weapon.x] setDrawColor];
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
    int i = weapon.x;
    Class w = [Arsenal weaponIndexedFromArsenal:i];
    [self.bulletDelegate bulletsFired:[w bulletsForLocation:outerEdges[0] direction:[self fireDirection] charge:[self weaponLevel]] li:weapon.x];
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
    return GetDistance(self.l, [self currentWaypoint]) < 1;
}

- (void)processedReachedTarget {
    self.fightingIteration++;
    if (self.fightingIteration == self.drawingIteration) {
        future[self.fightingIteration] = self.l;
        self.drawingIteration++;
        if (!_reachedTarget) {
            [self.pilotDelegate pilotReachedEndOfFutureWaypoints];
        }
    }
}

- (void)evaluateReachingTarget {
    if ([self reachedTarget]) {
        [self processedReachedTarget];
    }
}

- (void)setDrawingScaleByBattlefieldRhythm {
    //
}

- (void)copyDeltas {
    [self.clone recordVelocity:ccp(self.vel.x, -self.vel.y) firing:self.firing weapon:weapon];
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
    CGPoint ll = self.l;
    if (ll.x < 5) {
        ll = ccp(5, ll.y);
        [self processedReachedTarget];
    } else if (ll.x > (_fieldSize.width - 5)) {
        ll = ccp(_fieldSize.width - 5, ll.y);
        [self processedReachedTarget];
    }
    if (ll.y > (_fieldSize.height - 5)) {
        ll = ccp(ll.x, _fieldSize.height - 5);
        [self processedReachedTarget];
    }
    self.l = ll;

    
    [self checkForFiringWeapon];

    _reachedTarget = [self reachedTarget];
    
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

    [self updateZone];
}

- (void)updateZone {
    if (self.zx != [self calcZx] || self.zy != [self calcZy]) {
        self.zx = (int)self.l.x / 50.0f;
        self.zy = (int)self.l.y / 50.0f;
    }
}


- (void)stationaryFire {
    future[self.drawingIteration] = self.l;
    [self fire];
}

- (void)addWaypoint:(CGPoint)l {
    if (l.x < 5) {
        l = ccp(5, l.y);
    } else if (l.x > _fieldSize.width - 5) {
        l = ccp(_fieldSize.width - 5, l.y);
    } else if (l.y > _fieldSize.height - 5) {
        l = ccp(l.x, _fieldSize.height - 5);
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
    return shapeOfSizeContainsPoint(outerEdges, 4, d.l);
}

- (void)registerHit {
    self.active = NO;
}

- (BOOL)processDebris:(Debris *)d {
    if ([self isCollidingWithDebris:d]) {
        d.l = ccp(5000,500);
        CGPoint w = weapon;
        w.x = d.level;
        weapon = w;
        return true;
    }
    
    return false;
}

- (int)arsenalLevel {
    return weapon.x;
}

- (bool)processBullet:(Bullet *)b {
    if ([self isCollidingWithBullet:b]) {
        b.l = ccp(5000,5000);
        if (!self.shield) {
            [self registerHit];
        } else {
            self.shield--;
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
    for (int i = 0; i < 8551; i++) {
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

- (void)resetFuture {
    for (int i = 0; i < 8551; i++) {
        future[i] = self.l;
    }
}

- (int)weaponLevel {
    return weapon.y;
}

- (CGPoint)latestWaypoint {
    return future[self.fightingIteration];
}

//- (NSString *)zoneKey {
//    int x = (int)self.l.x / 50.0f;
//    int y = (int)self.l.y / 50.0f;
//    return [NSString stringWithFormat:@"%d,%d", x, y];
//}

- (int)calcZx {
    return (int)self.l.x / 50.0f;
}

- (int)calcZy {
    return (int)self.l.y / 50.0f;
}

- (void)powerLaser {
    int wy = weapon.y;
    wy++;
    
    CGPoint w = weapon;
    w.y = wy;
    weapon = w;
}

- (void)powerBoost {
    self.speed += .2;
}

@end


