//
//  FastLaserCannon.m
//  QuantumPilot
//
//  Created by quantum on 20/07/2014.
//
//

#import "FastLaserCannon.h"
#import "cocos2d.h"
#import "FastLaser.h"

@implementation FastLaserCannon

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    FastLaser *b = [[[FastLaser alloc] initWithLocation:location velocity:CGPointMake(0,direction * [self speed])] autorelease];
    return [NSArray arrayWithObject:b];
}


+ (float)speed {
    float s = [super speed];
    return s + 1.23;
}

+ (void)setDrawColor {
    ccDrawColor4F(.8, .03, .8, 1.0);
}

@end
