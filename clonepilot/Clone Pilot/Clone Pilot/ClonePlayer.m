//
//  ClonePlayer.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "ClonePlayer.h"
#import "VRGeometry.h"
#import "SingleLaser.h"
#import "QPDrawing.h"

int QP_PlayerYDirection = 1;

@implementation ClonePlayer
@synthesize bulletDelegate;
@synthesize speed;

- (void)generateTurn {
    Turn *turn = [[Turn alloc] init];
    [[self currentMoves] addObject:turn];    
    [turn release];
}

- (void)assignDefaultWeapon {
    SingleLaser *w = [[SingleLaser alloc] init];
    self.weapon = w;
    [w release];
}

- (id)commonInit {
    self = [super init];
    if (self) {
        self.l = [ClonePlayer defaultLocation];
        self.t = self.l;
        [self generateTurn];
        [self assignDefaultWeapon];
        self.living = 1;
        self.speed = 5;
        self.radius = 20;
    }
    return self;
}

- (id)init {
    return [self commonInit];
}

- (id)initWithLayer:(CCLayer *)layer {
    self = [self commonInit];
    [layer addChild:self];
    return self;
}

+ (ClonePlayer *)samplePlayer {
    return [[[ClonePlayer alloc] init] autorelease];
}

+ (CGPoint)defaultLocation {
    return CGPointMake(384,300);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"x:%f y:%f vx:%f vy:%f tx:%f ty:%f",self.l.x, self.l.y, self.vel.x, self.vel.y, self.t.x, self.t.y];
}

- (Bullet *)newBullet {
    Bullet *b = [[[Bullet alloc] initWithLocation:self.l velocity:CGPointMake(0,-3)] autorelease];
    b.identifier = [self identifier];
    return b;
}

- (BOOL)hasTurn {
    return [[self currentMoves] count] > 0;
}

- (void)fireWeapon {
    NSArray *bullets = [self.weapon newBulletsForLocation:CombinedPoint(self.l, ccp(0,QP_PlayerYDirection * 37)) direction:QP_PlayerYDirection];
    for (Bullet *b in bullets) {
        b.showDefaultColor = YES;
    }
   [self.bulletDelegate addBullets:bullets ship:self];
}

- (BOOL)firstTurn {
    return [[self currentMoves] count] == 1;
}

- (NSInteger)identifier {
    return 0;
}

- (void)assignVelocityForTarget {
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

- (void)updateLocationWithVelocity {
    self.l = CombinedPoint(self.l, self.vel);
}

- (void)tick {
    if ([self isFiring]) {
        [self fireWeapon];
    }
    
    [self assignVelocityForTarget];
    [self updateLocationWithVelocity];
    
    [self generateTurn];
    self.currentTurn.vel = self.vel;
}

- (Turn *)currentTurn {
    if (![self hasTurn]) {
        [self generateTurn];
    }
    return [self.currentMoves lastObject];
}

- (void)hit:(Bullet *)b {
    if ([b identifier] != [self identifier]) {
        self.living = 0;
        b.finished = YES;
    }
}

- (void)fire {
    self.currentTurn.firing = YES;
    [self.bulletDelegate fired];
}

- (BOOL)isFiring {
    if ([self hasTurn]) {
        return self.currentTurn.firing;
    }
    
    return NO;
}

- (CGPoint)defaultLocation {
    return [ClonePlayer defaultLocation];
}

- (void)reset {
    self.moves = nil;
    self.moves = [NSMutableArray array];
    self.vel = CGPointZero;
    self.l = [self defaultLocation];
    self.t = self.l;
    [self clearHistoricalPoints];    
}

- (void)restart {
    [self reset];
    [self assignDefaultWeapon];
    self.living = 1; 
}


- (void)dealloc {
    self.bulletDelegate = nil;
    [super dealloc];
}

- (NSMutableArray *)currentMoves {
    return self.moves;
}

- (NSString *)locationAndTargetingStatus {
    return [NSString stringWithFormat:@"Location x/y: %f,%f     Target x/y: %f %f", self.l.x,self.l.y, self.t.x,self.t.y];
}

- (BOOL)shipHitByBullet:(Bullet *)b {
    CGPoint *shipLines = basicDiamondShipLines(self.l, QP_PlayerYDirection);    
    return shapeOfSizeContainsPoint(shipLines, 4, b.l);
}

- (NSInteger)yDirection  {
    return QP_PlayerYDirection;
}

- (void)setDrawingColor {
    glColor4f(1, 1, 1, 1.0);
}

- (void)draw {
    if (self.living) {
        [self setDrawingColor];        
        drawBasicDiamondShip(self.l, QP_PlayerYDirection);
    }
}


@end
