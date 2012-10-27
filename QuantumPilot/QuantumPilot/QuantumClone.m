//
//  QuantumClone.m
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "QuantumClone.h"

@implementation QuantumClone

- (BOOL)isFiring {
    return pastFireTimings[timeIndex];
}

- (void)recordVelocity:(CGPoint)l firing:(BOOL)firing {
    pastVelocities[timeIndex] = l;
    pastFireTimings[timeIndex] = firing;
}

@end
