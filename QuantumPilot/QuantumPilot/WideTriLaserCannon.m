//
//  WideTriLaserCannon.m
//  QuantumPilot
//
//  Created by quantum on 28/09/2014.
//
//

#import "WideTriLaserCannon.h"
#import "WideTriLaser.h"

@implementation WideTriLaserCannon

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction charge:(int)charge {
    float yMod = .7;
    float xMod = .3;
    float s = [self chargedSpeed:charge];
    WideTriLaser *b1 = [[[WideTriLaser alloc] initWithLocation:location velocity:ccp(s * xMod, s * yMod * direction)] autorelease];
    WideTriLaser *b2 = [[[WideTriLaser alloc] initWithLocation:location velocity:ccp(-s * xMod, s * yMod * direction)] autorelease];
    WideTriLaser *c = [[[WideTriLaser alloc] initWithLocation:location velocity:ccp(0, s * direction)] autorelease];
    
    return @[b1, b2, c];
}

+ (void)setDrawColor {
//    ccDrawColor4F(.3, .7, .65, 1);
    ccDrawColor4F(1, 1, 0, 1);
}

+ (NSString *)weaponName {
    return @"GAMMA HAMMER";
}

+ (UIColor *)weaponColor {
    return [UIColor colorWithRed:1.0f green:1.0f blue:0.0f alpha:1];
}

@end
