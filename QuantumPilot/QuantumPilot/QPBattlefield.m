//
//  QPBattlefield.m
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "QPBattlefield.h"

@implementation QPBattlefield

static QPBattlefield *instance = nil;

+ (QPBattlefield *)f {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QPBattlefield alloc] init];
    });
    
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _rhythmScale = 0;
        _rhythmGrowth = .05;
        _rhythmDirection = 1;
        
        _rhythmPulseDirection = 1;
        _rhythmPulseChargeReset = 10;
    }
    return self;
}

+ (float)rhythmScale {
    QPBattlefield *battlefield = [QPBattlefield f];
    return [battlefield rhythmScale];
}

- (float)rhythmScale {
    return _rhythmScale + _rhythmPulse;
}


- (void)tick {
    _rhythmScale+= _rhythmGrowth * _rhythmDirection;
    if (_rhythmScale >= 1) {
        _rhythmScale = 1;
        _rhythmDirection = -1;
    } else if (_rhythmScale < .2) {
        _rhythmScale = .2;
        _rhythmDirection = 1;
    }
    
    _rhythmPulseCharge += _rhythmPulseDirection;
    if (_rhythmPulseCharge >= _rhythmPulseChargeReset) {
        _rhythmPulse = .5;
        if (_rhythmPulseCharge >= 2* _rhythmPulseChargeReset) {
            _rhythmPulseDirection = -1;
        }
    } else if (_rhythmPulseCharge <= 0) {
        _rhythmPulse = 0;
        _rhythmPulseDirection = 1;
    }
    
}

@end
