//
//  QuantumClone.h
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "QuantumPilot.h"

enum TimeDirection {
    forwards = 1,
    backwads = -1
};

@interface QuantumClone : QuantumPilot {
    CGPoint pastVelocities[4001];
    BOOL pastFireTimings[4001];
    NSInteger timeIndex;
    enum TimeDirection timeDirection;
}

- (void)recordVelocity:(CGPoint)l firing:(BOOL)firing;

@end
