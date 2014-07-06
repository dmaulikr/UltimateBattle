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
    backwards = -1,
    recording = 0
};

@interface QuantumClone : QuantumPilot <NSCopying> {
    CGPoint pastVelocities[4551];
    BOOL pastFireTimings[4551];
    NSInteger timeIndex;
    NSInteger latestIndex;
    enum TimeDirection timeDirection;
}

- (void)recordVelocity:(CGPoint)vel firing:(BOOL)firing;
- (void)activate;

@end
