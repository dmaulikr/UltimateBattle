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

static float innerWidth = .5;
static float innerHeight = 8;
static float outerWidth = .5;
static float outerHeight = 6;

- (ccColor4F)color {
    return self.yDirection == -1 ? ccc4f(.1, .9, .1, 1) : white;
}

- (void)draw {
    CGPoint lines[4];
    lines[0] = ccp(self.l.x - innerWidth - (rs * outerWidth), self.l.y - innerHeight - (rs * outerHeight));
    lines[1] = ccp(self.l.x - innerWidth - (rs * outerWidth), self.l.y + innerHeight + (rs * outerHeight));
    lines[2] = ccp(self.l.x + innerWidth + (rs * outerWidth), self.l.y + innerHeight + (rs * outerHeight));
    lines[3] = ccp(self.l.x + innerWidth + (rs * outerWidth), self.l.y - innerHeight - (rs * outerHeight));
    ccDrawSolidPoly(lines, 4, [self color]);
}

@end
