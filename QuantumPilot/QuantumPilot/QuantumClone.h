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
    backwads = -1,
    recording = 0
};

@interface QuantumClone : QuantumPilot <NSCopying> {
    CGPoint pastVelocities[4001];
    BOOL pastFireTimings[4001];
    NSInteger timeIndex;
    enum TimeDirection timeDirection;
}

- (void)recordVelocity:(CGPoint)vel firing:(BOOL)firing;
- (void)activate;

@end
