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
    CGPoint pastWeapons[4551];
    NSInteger timeIndex;
    NSInteger latestIndex;
    enum TimeDirection timeDirection;
    int fireSignal;
}

@property (nonatomic) bool showPath;

- (void)recordVelocity:(CGPoint)vel firing:(BOOL)firing weapon:(CGPoint)wep;
- (void)activate;

- (void)showFireSignal;

- (void)increaseTime;

@end
