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


- (void)reset {
    iterations = 0;
}
@end
