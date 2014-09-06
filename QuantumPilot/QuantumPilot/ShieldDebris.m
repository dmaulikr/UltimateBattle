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

- (void)draw {
    ccDrawColor4F(1, 1, 1, 1.0);
    ccDrawColor4F(1 - [QPBattlefield pulseRotation], 1  - [QPBattlefield pulseRotation], 1  - [QPBattlefield pulseRotation], 1);
    int points = 300 - iterations;
    if (points < 30) {
        points = 30;
    }
    ccDrawCircle(self.l, iterations * 11, 0, points, NO);
}

- (void)pulse {
    iterations++;
}

- (bool)dissipated {
    return iterations > 500;
}

@end
