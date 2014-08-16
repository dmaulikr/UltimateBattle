//
//  TightSplitLaser.m
//  QuantumPilot
//
//  Created by quantum on 18/07/2014.
//
//

#import "TightSplitLaser.h"
#import "TightSplitLaserCannon.h"

static float halfSegment = 1.5;

@implementation TightSplitLaser

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity {
    self = [super initWithLocation:location velocity:velocity];
    _xDirection = self.vel.x < 0 ? -1 : 1;
    return self;
}

- (void)draw {
    [TightSplitLaserCannon setDrawColor];
    int xD = _xDirection;
    int yDirection = self.vel.y < 0 ? -1 : 1;
    lines[0] = ccp(self.l.x + (xD * halfSegment * .15), self.l.y + (yDirection * halfSegment * .85));
    lines[1] = ccp(self.l.x - (xD * halfSegment * .15), self.l.y - (yDirection * halfSegment * .85));
    
    ccDrawPoly(lines, 2, true);
}

- (void)pulse {
    [super pulse];
    //tap to split
//    self.vel = ccp(self.vel.x - (.1 * _xDirection), self.vel.y);
}

@end
