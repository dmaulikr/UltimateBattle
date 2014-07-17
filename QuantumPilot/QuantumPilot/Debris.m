//
//  Debris.m
//  QuantumPilot
//
//  Created by quantum on 15/07/2014.
//
//

#import "Debris.h"
#import "VRGeometry.h"
#import "QPBattlefield.h"

@implementation Debris

- (id)initWithL:(CGPoint)l {
    self = [super init];
    if (self) {
        self.l = l;
        _speed = 1.5 + ((arc4random() % 40) * .05);
        for (int i = 0; i < 10; i++) {
            int xD = arc4random() % 2 == 0 ? 1 : -1;
            int yD = arc4random() % 2 == 0 ? 1 : -1;
            int xv = arc4random() % 6;
            int yv = arc4random() % 6;
            _points[i] = ccp(xD * xv, yD * yv);
        }
    }
    return self;
}

- (void)pulse {
    self.l = CombinedPoint(self.l, ccp(0,-2));
}

- (void)draw {
    ccDrawColor4F(1, 1, 1, 1.0);
    ccDrawFilledCircle(self.l, 1.3 * [QPBattlefield pulseRotation], 0, 100, NO);
}

@end
