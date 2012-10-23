//
//  SingleLaser.m
//  QuantumPilot
//
//  Created by X3N0 on 10/22/12.
//
//

#import "SingleLaser.h"
#import "QPBattlefield.h"

@implementation SingleLaser

static float halfWidth = 1;
static float halfHeight = 10;

- (ccColor4F)color {
    return self.yDirection == -1 ? ccc4f(.1, .9, .1, 1) : white;
}

- (void)draw {
    CGPoint lines[4];
    lines[0] = ccp(self.l.x - rs * halfWidth, self.l.y - rs * halfHeight);
    lines[1] = ccp(self.l.x + rs * halfWidth, self.l.y - rs * halfHeight);
    lines[2] = ccp(self.l.x + rs * halfWidth, self.l.y + rs * halfHeight);
    lines[3] = ccp(self.l.x - rs * halfWidth, self.l.y + rs * halfHeight);
    ccDrawSolidPoly(lines, 4, [self color]);
}

@end
