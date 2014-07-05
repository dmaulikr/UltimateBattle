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

static float innerWidth = .5; //iPad: .5
static float innerHeight = 4; //iPad: 8
static float outerWidth = .5; //iPad: .5
static float outerHeight = 3; //iPad: .6

- (ccColor4F)color {
    return self.yDirection == -1 ? ccc4f(.1, .9, .1, 1) : white;
}

- (void)draw {
    lines[0] = ccp(self.l.x - innerWidth - (self.drawMultiplier * outerWidth), self.l.y - innerHeight - (self.drawMultiplier * outerHeight));
    lines[1] = ccp(self.l.x - innerWidth - (self.drawMultiplier * outerWidth), self.l.y + innerHeight + (self.drawMultiplier * outerHeight));
    lines[2] = ccp(self.l.x + innerWidth + (self.drawMultiplier * outerWidth), self.l.y + innerHeight + (self.drawMultiplier * outerHeight));
    lines[3] = ccp(self.l.x + innerWidth + (self.drawMultiplier * outerWidth), self.l.y - innerHeight - (self.drawMultiplier * outerHeight));
    ccDrawSolidPoly(lines, 4, [self color]);
}

@end
