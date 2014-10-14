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

static int fireSignalValue = 89;

- (id)copyWithZone:(NSZone *)zone {
    QuantumClone *c = [[[QuantumClone alloc] init] autorelease];
    c.weapon = self.weapon;
    for (NSInteger i = 0; i < 4551; i++) {
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
       
            if (fireSignal > 0) {
                fireSignal--;
            }
            [self checkForFiringWeapon];
            
            timeIndex+= timeDirection;
            
            if (timeIndex >= latestIndex) {
                timeIndex = latestIndex;
                timeDirection = backwards;
            } else if (timeIndex < 0) {
                timeIndex = 0;
                timeDirection = forwards;
            }
        } else {
            [self resetPosition];
        }
    } else {
        timeIndex++;
    }
    [self defineEdges];
}

- (void)setShipDrawColor {
    if (timeDirection == recording) {
        ccDrawColor4F(1, 1, 1, 1.0);
    } else {
        [NSClassFromString(self.weapon) setDrawColor];
    }
}

- (void)drawCircle {
    if (fireSignal > 0) {
        float ratio = (float)fireSignal/(float)fireSignalValue;
        ccDrawFilledCircle(self.innerTopEdge, 2.6 * ratio, 0, 100, NO);
    }
}

- (void)activate {
    [self resetPosition];
    self.active = true;
    timeIndex = 0;
    timeDirection = forwards;
}

- (void)showFireSignal {
    int index = timeIndex;
    if (timeDirection == forwards) {
        index += fireSignalValue;
        if (index > latestIndex) {
            int diff = latestIndex - index;
            index = latestIndex - diff;
        }
    } else {
        index -= fireSignalValue;
        if (index < 0) {
            int diff = 0 - index;
            index = 0 - diff;
        }
    }
    
    if (pastFireTimings[index] == true) {
        fireSignal = fireSignalValue;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"x: %f y: %f wep: %@ on: %d", self.l.x, self.l.y, self.weapon, self.active];
}

@end
