//
//  QuantumClone.m
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "QuantumClone.h"

@implementation QuantumClone

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

@end
