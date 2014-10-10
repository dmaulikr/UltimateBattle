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
    ccDrawCircle(self.l, iterations * 11, 0, _points, NO);
}

- (void)pulse {
    iterations++;
    _edges = 300 - iterations;
    if (_edges < 30) {
        _edges = 30;
    }
}

- (bool)dissipated {
    return iterations > 500;
}

@end
