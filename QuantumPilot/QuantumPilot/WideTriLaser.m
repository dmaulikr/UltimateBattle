//
//  WideTriLaser.m
//  QuantumPilot
//
//  Created by quantum on 28/09/2014.
//
//

#import "WideTriLaser.h"
#import "cocos2d.h"
#import "WideTriLaserCannon.h"

@implementation WideTriLaser

static float halfSegment = 1.5;

- (void)pulse {
    [super pulse];
    _xDirection = 0;
    if (self.vel.x < 0) {
        _xDirection = -1;
    } else if (self.vel.x > 0) {
        _xDirection = 1;
    }
    
    lines[0] = ccp(self.l.x + (_xDirection * halfSegment * .15), self.l.y + ([self yDirection] * halfSegment * .85));
    lines[1] = ccp(self.l.x - (_xDirection * halfSegment * .15), self.l.y - ([self yDirection] * halfSegment * .85));

}

- (void)draw {
    [WideTriLaserCannon setDrawColor];
    ccDrawPoly(lines, 2, true);
}

+ (float)speed {
    return [[Weapon w] speed] - .2;
}

@end
