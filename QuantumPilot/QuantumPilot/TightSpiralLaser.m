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

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity {
    self = [super initWithLocation:location velocity:velocity];
    _xDirection = self.vel.x < 0 ? -1 : 1;
    side = _xDirection == 1 ? 20 : 0;
    return self;
}

- (void)draw {
    [TightSpiralLaserCannon setDrawColor];
    int xD = _xDirection;
    int yDirection = self.vel.y < 0 ? -1 : 1;
//    lines[0] = ccp(self.l.x - (self.vel.x * halfSegment), self.l.y - (self.vel.y * halfSegment));
//    lines[1] = ccp(self.l.x + (self.vel.x * halfSegment), self.l.y + (self.vel.y * halfSegment));
    lines[0] = ccp(self.l.x + (xD * halfSegment * .15), self.l.y + (yDirection * halfSegment * .85));
    lines[1] = ccp(self.l.x - (xD * halfSegment * .15), self.l.y - (yDirection * halfSegment * .85));
    
    ccDrawPoly(lines, 2, true);
}


- (void)pulse {
    [super pulse];
//    self.vel = ccp(self.vel.x - (.05 * _xDirection), self.vel.y);
    side += _xDirection;
    if (side > 20) {
        side = 20;
        _xDirection = -1;
    } else if (side <= 0) {
        _xDirection = 1;
        side = 0;
        
    }
    
    self.vel = ccp(_xDirection * 2, self.vel.y);
//    if (self.vel.x < -2) {
//        _xDirection = 1;
//        self.vel = ccp(0, self.vel.y);
//    } else if (self.vel.x > 2) {
//        _xDirection = -1;
//        self.vel = ccp(0, self.vel.y);
//    }
}



@end
