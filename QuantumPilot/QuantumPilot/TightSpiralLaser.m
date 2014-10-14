//
//  TightSpiralLaser.m
//  QuantumPilot
//
//  Created by quantum on 26/09/2014.
//
//

#import "TightSpiralLaser.h"
#import "TightSpiralLaserCannon.h"

@implementation TightSpiralLaser

static float halfSegment = 1.2;

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity centerX:(int)x {
    self = [super initWithLocation:location velocity:velocity];
    ox = x;
    _xDirection = self.vel.x < 0 ? -1 : 1;
//    side = _xDirection == 1 ? 20 : 0;
    _yDirection = [self yDirection];
    return self;
}

- (void)setColor {
    [TightSpiralLaserCannon setDrawColor];
}

- (void)draw {
    [self setColor];
    ccDrawPoly(lines, 2, true);
}

- (float)oscillateSpeed {
    return .1;
}

- (void)oscillate {
    if (self.l.x > ox) {
        self.vel = ccp(self.vel.x - [self oscillateSpeed], self.vel.y);
    } else if (self.l.x < ox) {
        self.vel = ccp(self.vel.x + [self oscillateSpeed], self.vel.y);
    }
}

- (void)pulse {
    [super pulse];
    [self oscillate];
    
    lines[0] = ccp(self.l.x + (_xDirection * halfSegment * .15), self.l.y + (_yDirection * halfSegment * .85));
    lines[1] = ccp(self.l.x - (_xDirection * halfSegment * .15), self.l.y - (_yDirection * halfSegment * .85));
}

@end
