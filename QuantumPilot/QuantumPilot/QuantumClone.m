//
//  QuantumClone.m
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "QuantumClone.h"

@implementation QuantumClone

- (id)copyWithZone:(NSZone *)zone {
    QuantumClone *c = [[QuantumClone alloc] init];
    for (NSInteger i = 0; i < 4001; i++) {
        [c recordVelocity:pastVelocities[i] firing:pastFireTimings[i]];
    }
    return c;
}

- (NSInteger)yDirection {
    return 1;
}

- (BOOL)isFiring {
    return pastFireTimings[timeIndex];
}

- (void)recordVelocity:(CGPoint)vel firing:(BOOL)firing {
    CGPoint p = pastVelocities[timeIndex];
    p.x = vel.x;
    p.y = vel.y;
    pastVelocities[timeIndex] = p;
    BOOL fired = pastFireTimings[timeIndex];
    fired = firing;
    pastFireTimings[timeIndex] = fired;
    timeIndex++;
}

- (void)pulse {
    if (timeDirection != recording) {
        self.vel = pastVelocities[timeIndex];
        timeIndex++;
        [self moveByVelocity];
    }
}

- (void)activate {
    self.l = CGPointMake(300, 768);
    self.active = YES;
    timeIndex = 0;
    timeDirection = forwards;
}

@end
