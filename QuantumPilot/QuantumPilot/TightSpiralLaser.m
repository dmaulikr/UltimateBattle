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

- (CGPoint)velocity {
    if (delay > 0) {
        return ccp(0,self.vel.y);
    }
    
    return self.vel;
}

- (void)oscillate {
    if (delay > 0) {
        delay--;
    } else {
        if (self.l.x > ox) {
            self.vel = ccp(self.vel.x - [self oscillateSpeed], self.vel.y);
        } else if (self.l.x < ox) {
            self.vel = ccp(self.vel.x + [self oscillateSpeed], self.vel.y);
        }
    }
}

- (bool)shouldTurn {
    return (self.vel.x < 0 && self.l.x < ox) || (self.vel.x > 0 && self.l.x > ox);
}

- (NSInteger)delayReset {
    return 14;
}

- (void)pulse {
    int turn = [self shouldTurn];
    [super pulse];
    [self oscillate];
    if (turn == 1 && ![self shouldTurn]) {
        delay = [self delayReset];
    }
    
    lines[0] = ccp(self.l.x + (_xDirection * halfSegment * .15), self.l.y + (_yDirection * halfSegment * .85));
    lines[1] = ccp(self.l.x - (_xDirection * halfSegment * .15), self.l.y - (_yDirection * halfSegment * .85));
}

- (NSString *)weapon {
    return @"TightSpiralLaserCannon";
}


@end
