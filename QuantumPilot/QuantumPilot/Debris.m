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
#import "SingleLaserCannon.h"
#import "SplitLaserCannon.h"
#import "FastLaserCannon.h"
#import "TightSpiralLaserCannon.h"
#import "WideSpiralLaserCannon.h"
#import "WideTriLaserCannon.h"
#import "QuadLaserCannon.h"
#import "Arsenal.h"

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
    radius = 1.7 * [QPBattlefield pulseRotation];
}

- (void)establishColor {
    [[Arsenal weaponIndexedFromArsenal:_level] setDrawColor];
}

- (void)drawCircle {
    ccDrawFilledCircle(self.l, radius, 0, 30, NO);
}

- (void)draw {
    [self establishColor];
    [self drawCircle];
}

- (void)setLevel:(int)l {
    _level = l;
}

- (int)level {
    return _level;
}

- (bool)dissipated {
    return false;
}

- (bool)isDebris {
    return true;
}

- (void)assignLevel {
    int wRandom[7] = {140, 140, 30, 30, 20, 15, 5};
    
    int wRandomTotal = 0;
    for (int i = 0; i < 7; i++) {
        wRandomTotal += wRandom[i];
    }

    int weaponRandom = arc4random() % wRandomTotal;
    NSLog(@"random: %d", weaponRandom);
    _level = 0;
    int accum = 0;
    for (int i = 0; i < 6; i++) {
        accum+= wRandom[i];
        if (weaponRandom > accum) {
            _level++;
        }
    }
}

@end
