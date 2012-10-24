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
    struct history h = self.history;
    
    h.velocities[self.history.timeIndex] = l;
    h.fireTimings[self.history.timeIndex] = firing;
    self.history = h;
}

@end
