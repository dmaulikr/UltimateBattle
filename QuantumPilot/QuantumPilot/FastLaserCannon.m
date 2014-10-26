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
    FastLaser *b = [[[FastLaser alloc] initWithLocation:ccp(location.x - 3, location.y) velocity:CGPointMake(0,direction * [self speed])] autorelease];
    FastLaser *b2 = [[[FastLaser alloc] initWithLocation:ccp(location.x + 3, location.y) velocity:CGPointMake(0,direction * [self speed])] autorelease];
    
    return @[b, b2];
}

+ (float)speed {
    float s = [super speed];
    return s + 1.32; //1.23
}

+ (void)setDrawColor {
    ccDrawColor4F(.8, .03, .8, 1.0);
}

+ (NSString *)weaponName {
    return @"CORE CRUSHER";
}

+ (UIColor *)weaponColor {
    return [UIColor colorWithRed:0.8f green:0.03f blue:0.8f alpha:1];
}

@end
