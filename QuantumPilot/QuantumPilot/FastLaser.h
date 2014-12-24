//
//  FastLaser.h
//  QuantumPilot
//
//  Created by quantum on 21/07/2014.
//
//

#import "SingleLaser.h"

@interface FastLaser : SingleLaser {
    int _pulses;
    float _ratio;
    int _pulseDirection;
}

@end
