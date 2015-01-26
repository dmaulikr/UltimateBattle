//
//  TightSpiralLaserCannon.m
//  QuantumPilot
//
//  Created by quantum on 26/09/2014.
//
//

#import "TightSpiralLaserCannon.h"
#import "cocos2d.h"
#import "TightSpiralLaser.h"

@implementation TightSpiralLaserCannon

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction charge:(int)charge {
    float s = [self chargedSpeed:charge];
    TightSpiralLaser *b1 = [[[TightSpiralLaser alloc] initWithLocation:ccp(location.x - 15, location.y) velocity:ccp(2, s * direction) centerX:location.x] autorelease];
    TightSpiralLaser *b2 = [[[TightSpiralLaser alloc] initWithLocation:ccp(location.x + 15, location.y) velocity:ccp(-2, s * direction) centerX:location.x] autorelease];
    
    return @[b1, b2];
}

+ (void)setDrawColor {
    //ccDrawColor4F(.3, .7, .65, 1);
    ccDrawColor4F(0, 1, 1, 1);
}

+ (NSString *)weaponName {
    return @"EXOSLICER";
}

+ (UIColor *)weaponColor {
    return [UIColor colorWithRed:0.0f green:1.0f blue:1.0f alpha:1];
}

@end
