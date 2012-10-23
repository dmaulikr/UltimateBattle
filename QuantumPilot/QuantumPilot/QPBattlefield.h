//
//  QPBattlefield.h
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "CCNode.h"

@interface QPBattlefield : CCNode {
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
