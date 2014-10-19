//
//  ShieldDebris.m
//  QuantumPilot
//
//  Created by quantum on 06/09/2014.
//
//

#import "ShieldDebris.h"
#import "QPBattlefield.h"

@implementation ShieldDebris

- (void)establishColor {
    if (self.weapon) {
        [NSClassFromString(self.weapon) setDrawColor];
    } else {
        ccDrawColor4F(1, 1, 1, 1.0);
    }
}

- (void)drawCircle {
    ccDrawCircle(self.l, radius, 0, _edges, NO);
}

- (void)pulse {
    iterations++;
    _edges = 300 - iterations;
    if (_edges < 30) {
        _edges = 30;
    }
    
    radius = iterations * 7;
}

- (bool)dissipated {
    return iterations > 500;
}

- (void)dealloc {
    self.weapon = nil;
    self.pilot = nil;
    [super dealloc];
}

- (bool)isDebris {
    return false;
}

@end
