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
        _pulseTimes[0] = 10;
        _pulseTimes[1] = 10;
        _pulseTimes[2] = 5;
        _pulseTimes[3] = 5;
    }
    return self;
}

+ (float)rhythmScale {
    QPBattlefield *battlefield = [QPBattlefield f];
    return [battlefield rhythmScale];
}

- (float)rhythmScale {
    return _rhythmScale;
}

- (void)pulse {
    _pulseCharge++;
    if (_pulseCharge >= _pulseTimes[_pulseState]) {
        _pulseCharge = 0;
        _pulseState++;
        if (_pulseState > 3) {
            _pulseState = 0;
        }
    }
    
    float progress = (float)_pulseCharge / (float)_pulseTimes[_pulseState];
    switch (_pulseState) {
        case resting:
            _rhythmScale = .3;
            break;
        case holding:
            _rhythmScale = 1;
            break;
        case charging:
            _rhythmScale = .6 + progress * .5;
            break;
        case falling:
            _rhythmScale = 1.2 - progress * .6;
            break;
        default:
            break;
    }
}

- (void)tick {
    [self pulse];
}


//    if (_rhythmScale >= 1) {
//        _rhythmScale = 1;
//        _rhythmDirection = -1;
//    } else if (_rhythmScale < .2) {
//        _rhythmScale = .2;
//        _rhythmDirection = 1;
//    }


@end
