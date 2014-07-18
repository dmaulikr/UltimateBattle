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

- (void)draw {
    [TightSplitLaserCannon setDrawColor];
    int xDirection = self.vel.x < 0 ? -1 : 1;
    int yDirection = self.vel.y < 0 ? -1 : 1;
    lines[0] = ccp(self.l.x + (xDirection * halfSegment * .15), self.l.y + (yDirection * halfSegment * .85));
    lines[1] = ccp(self.l.x - (xDirection * halfSegment * .15), self.l.y - (yDirection * halfSegment * .85));
    
    ccDrawPoly(lines, 2, true);
}

@end
