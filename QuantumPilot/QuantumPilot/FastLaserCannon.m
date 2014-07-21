//
//  FastLaserCannon.m
//  QuantumPilot
//
//  Created by quantum on 20/07/2014.
//
//

#import "FastLaserCannon.h"
#import "cocos2d.h"

@implementation FastLaserCannon

+ (float)speed {
    float s = [super speed];
    return s + 1.5;
}

+ (void)setDrawColor {
    ccDrawColor4F(.8, .03, .8, 1.0);
}

@end
