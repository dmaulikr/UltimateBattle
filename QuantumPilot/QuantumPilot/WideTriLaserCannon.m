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

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    float yMod = .85;
    float xMod = .15;
    WideTriLaser *b1 = [[[WideTriLaser alloc] initWithLocation:location velocity:ccp([self speed] *xMod, [self speed] * yMod * direction)] autorelease];
    WideTriLaser *b2 = [[[WideTriLaser alloc] initWithLocation:location velocity:ccp(-[self speed] *xMod, [self speed] * yMod * direction)] autorelease];
    WideTriLaser *c = [[[WideTriLaser alloc] initWithLocation:location velocity:ccp(0, [self speed] * direction)] autorelease];
    
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
