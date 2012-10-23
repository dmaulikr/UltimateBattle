//
//  QuantumClone.m
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "QuantumClone.h"

@implementation QuantumClone
@synthesize history = _history;

- (BOOL)isFiring {
    return self.history.fireTimings[self.history.timeIndex];
}

- (void)recordVelocity:(CGPoint)l firing:(BOOL)firing {
    self.history.velocities[self.history.timeIndex] = l;
    self.history.fireTimings[self.history.timeIndex] = firing;
}

@end
