//
//  QuadLaserCannon.m
//  QuantumPilot
//
//  Created by quantum on 29/09/2014.
//
//

#import "QuadLaserCannon.h"
#import "CloseQuadLaser.h"
@implementation QuadLaserCannon

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction charge:(int)charge {
    float s = [self chargedSpeed:charge];
    QuadLaser *ll = [[[QuadLaser alloc] initWithLocation:location velocity:ccp(-.4 * s, .85 * direction * s)] autorelease];
    CloseQuadLaser *lr = [[[CloseQuadLaser alloc] initWithLocation:location velocity:ccp(-.15 * s, .85 * direction * s)] autorelease];
    QuadLaser *rl = [[[QuadLaser alloc] initWithLocation:location velocity:ccp(.4 * s, .85 * direction * s)] autorelease];
    CloseQuadLaser *rr = [[[CloseQuadLaser alloc] initWithLocation:location velocity:ccp(.15 * s, .85 * direction * s)] autorelease];
    
    return @[ll, lr, rl, rr];
}

+ (void)setDrawColor {
    ccDrawColor4F(.0, .0, 1, 1); //.05, .05, .9
}

+ (NSString *)weaponName {
    return @"STAR MELTER";
}

+ (UIColor *)weaponColor {
    return [UIColor colorWithRed:0.0f green:0.00f blue:1.0f alpha:1];
}

@end
