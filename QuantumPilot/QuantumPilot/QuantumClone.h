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

struct history {
    CGPoint velocities[4001];
    BOOL fireTimings[4001];
    NSInteger timeIndex;
    enum TimeDirection timeDirection;
};

@interface QuantumClone : QuantumPilot

@property (nonatomic) struct history history;

@end
