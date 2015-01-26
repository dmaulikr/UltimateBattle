//
//  SplitLaserCannon.m
//  QuantumPilot
//
//  Created by quantum on 05/07/2014.
//
//

#import "SplitLaserCannon.h"
#import "SplitLaser.h"

@implementation SplitLaserCannon

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction charge:(int)charge {
    
    float s = [self chargedSpeed:charge];
    SplitLaser *l = [[[SplitLaser alloc] initWithLocation:location velocity:ccp(-s * .4, s * direction * .6)] autorelease];
    SplitLaser *r = [[[SplitLaser alloc] initWithLocation:location velocity:ccp(s * .4, s * direction * .6)] autorelease];
    return @[l, r];
}

+ (void)setDrawColor {
    ccDrawColor4F(1, .64, 0, 1);
}

+ (NSString *)weaponName {
    return @"NOVA SPLITTER";
}

+ (UIColor *)weaponColor {
    return [UIColor colorWithRed:1.0f green:0.64f blue:0.0f alpha:1];
}

@end
