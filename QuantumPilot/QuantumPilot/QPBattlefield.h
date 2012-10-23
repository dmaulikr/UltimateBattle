//
//  QPBattlefield.h
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "CCNode.h"

enum pulsestate {
    resting = 0,
    charging = 1,
    holding = 2,
    falling = 3
};

enum pulsetimes {
    tResting = 10,
    tCharging = 30,
    tHolding = 15,
    tFalling = 5,
};

@interface QPBattlefield : CCNode {
    NSInteger _pulseTimes[4];
    NSInteger _pulseState;
    NSInteger _pulseDirection;
    NSInteger _pulseCharge;
    
    
    float _rhythmScale;
    NSInteger _rhythmDirection;
    float _rhythmGrowth;
    
    
    float _rhythmPulse;
    float _rhythmPulseGrowth;
    float _rhythmPulseCharge;
    NSInteger _rhythmPulseChargeReset;
    NSInteger _rhythmPulseDirection;
}


- (float)rhythmScale;
- (void)tick;

+ (QPBattlefield *)f;

+ (float)rhythmScale;

@end
