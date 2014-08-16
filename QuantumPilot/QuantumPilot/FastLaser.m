//
//  FastLaser.m
//  QuantumPilot
//
//  Created by quantum on 21/07/2014.
//
//

#import "FastLaser.h"

@implementation FastLaser

- (void)pulse {
    [super pulse];
    _pulses++;
    if (_pulses > 70) {
        self.l = ccp(1000,1000);
    }
}


- (void)setDrawColor {
     ccDrawColor4F(.8, .03, .8, 1.0);   
}

@end
