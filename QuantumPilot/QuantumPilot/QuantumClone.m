//
//  QuantumClone.m
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "QuantumClone.h"
#import "SingleLaserCannon.h"

@implementation QuantumClone

- (id)copyWithZone:(NSZone *)zone {
    QuantumClone *c = [[[QuantumClone alloc] init] autorelease];
    c.weapon = self.weapon;
    for (NSInteger i = 0; i < 4051; i++) {
        [c recordVelocity:pastVelocities[i] firing:pastFireTimings[i]];
    }
    [c recordLatestIndex:timeIndex];
    return c;
}

- (void)resetPosition {
//    self.l = CGPointMake(384, 1024-170);
    self.l = CGPointMake(160, 578 * 2/3);
}

- (NSInteger)yDirection {
    return 1;
}

- (BOOL)isFiring {
    return pastFireTimings[timeIndex];
}

- (void)sendBulletsToBattlefield  {
    Class w = NSClassFromString(self.weapon);
    [self.bulletDelegate cloneBulletsFired:[w bulletsForLocation:outerEdges[0] direction:[self fireDirection]]];

}

- (void)recordVelocity:(CGPoint)vel firing:(BOOL)firing {
    CGPoint p = pastVelocities[timeIndex];
    p.x = vel.x;
    p.y = vel.y;
    pastVelocities[timeIndex] = p;
//    BOOL fired = pastFireTimings[timeIndex];
    bool fired = firing;
    pastFireTimings[timeIndex] = fired;
    timeIndex++;
}

- (void)recordLatestIndex:(NSInteger)index {
    latestIndex = index;
}

- (bool)shouldDraw {
    return self.active;
}

- (void)pulse {
    if (timeDirection != recording) {
        if (self.active) {
            self.vel = pastVelocities[timeIndex];
            if (timeDirection == backwards) {
                self.vel = ccp(-self.vel.x, -self.vel.y);
            }
            [self moveByVelocity];
            
            [self checkForFiringWeapon];
            
            timeIndex+= timeDirection;
            
            if (timeIndex >= latestIndex) {
                timeIndex = latestIndex;
                timeDirection = backwards;
            } else if (timeIndex < 0) {
                timeIndex = 0;
                timeDirection = forwards;
            }
        }
    } else {
        timeIndex++;
    }
}

- (void)setShipDrawColor {
    if (timeDirection == recording) {
        ccDrawColor4F(1, 1, 1, 1.0);
    } else {
        [NSClassFromString(self.weapon) setDrawColor];
    }
}

- (void)drawCircle {

}

- (void)activate {
    [self resetPosition];
    self.active = YES;
    timeIndex = 0;
    timeDirection = forwards;
}

@end
