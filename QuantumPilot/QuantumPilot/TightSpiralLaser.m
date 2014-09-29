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

static float halfSegment = .5;

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity centerX:(int)x {
    self = [super initWithLocation:location velocity:velocity];
    ox = x;
    _xDirection = self.vel.x < 0 ? -1 : 1;
//    side = _xDirection == 1 ? 20 : 0;
    return self;
}

- (void)draw {
    [TightSpiralLaserCannon setDrawColor];
    int xD = _xDirection;
    int yDirection = [self yDirection];
//    lines[0] = ccp(self.l.x - (self.vel.x * halfSegment), self.l.y - (self.vel.y * halfSegment));
//    lines[1] = ccp(self.l.x + (self.vel.x * halfSegment), self.l.y + (self.vel.y * halfSegment));
    lines[0] = ccp(self.l.x + (xD * halfSegment * .15), self.l.y + (yDirection * halfSegment * .85));
    lines[1] = ccp(self.l.x - (xD * halfSegment * .15), self.l.y - (yDirection * halfSegment * .85));
    
    ccDrawPoly(lines, 2, true);
}

- (void)oscillate {
    if (self.l.x > ox) {
        self.vel = ccp(self.vel.x - .1, self.vel.y);
    } else if (self.l.x < ox) {
        self.vel = ccp(self.vel.x + .1, self.vel.y);
    }
}

- (void)pulse {
    [super pulse];
    
    [self oscillate];
}

@end
