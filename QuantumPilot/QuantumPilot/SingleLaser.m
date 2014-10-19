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

static float triangleWidth = 3;
static float triangleHeight = 3;

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity {
    self = [super initWithLocation:location velocity:velocity];
    _facing = [self yDirection];
    return self;
}

- (ccColor4F)color {
    return self.yDirection == -1 ? ccc4f(.1, .9, .1, 1) : white;
}

- (void)setDrawColor {
    ccDrawColor4F(1, 1, 1, 1);
}

- (void)pulse {
    [super pulse];
    lines[0] = ccp(self.l.x - (triangleWidth * self.drawMultiplier), self.l.y - (triangleHeight * _facing * self.drawMultiplier));
    lines[1] = self.l;
    lines[2] = ccp(self.l.x + (triangleWidth * self.drawMultiplier), self.l.y - (triangleHeight * _facing * self.drawMultiplier));
}

- (void)draw {
    [self setDrawColor];
    ccDrawPoly(lines, 3, false);
}

- (NSString *)weapon {
    return @"SingleLaserCannon";
}

@end
