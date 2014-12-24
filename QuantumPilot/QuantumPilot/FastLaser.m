//
//  FastLaser.m
//  QuantumPilot
//
//  Created by quantum on 21/07/2014.
//
//

#import "FastLaser.h"

@implementation FastLaser

static float triangleWidth = 3;
static float triangleHeight = 3;

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity {
    self = [super initWithLocation:location velocity:velocity];
    _pulseDirection = 1;
    return self;
}

- (void)pulse {
    [super pulse];
    _pulses+= _pulseDirection;
    if (_pulses > 48) {
        _pulses = 48;
        _pulseDirection = -1;
    } else if (_pulses < 0) {
        _pulses = 0;
        _pulseDirection = 1;
    }
    
    _ratio = (float)(48 - _pulses) / 48.0f;
    _facing = self.vel.y > 0 ? 1 : -1;

}

- (void)draw {
    [self setDrawColor];
    
    lines[0] = ccp(self.l.x - (triangleWidth * _ratio), self.l.y - (triangleHeight * [self yDirection]));
    lines[1] = self.l;
    lines[2] = ccp(self.l.x + (triangleWidth * _ratio), self.l.y - (triangleHeight * [self yDirection]));
    
    ccDrawPoly(lines, 3, false);
}

- (void)setDrawColor {
     ccDrawColor4F(.8, .03, .8, 1.0);   
}

- (NSString *)weapon {
    return @"FastLaserCannon";
}


@end
