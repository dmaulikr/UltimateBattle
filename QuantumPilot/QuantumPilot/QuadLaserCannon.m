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

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    QuadLaser *ll = [[QuadLaser alloc] initWithLocation:location velocity:ccp(-.4 * [self speed], .6 * direction * [self speed])];
    CloseQuadLaser *lr = [[CloseQuadLaser alloc] initWithLocation:location velocity:ccp(-.15 * [self speed], .85 * direction * [self speed])];
    QuadLaser *rl = [[QuadLaser alloc] initWithLocation:location velocity:ccp(.4 * [self speed], .6 * direction * [self speed])];
    CloseQuadLaser *rr = [[CloseQuadLaser alloc] initWithLocation:location velocity:ccp(.15 * [self speed], .85 * direction * [self speed])];
    
    return @[ll, lr, rl, rr];
}

+ (void)setDrawColor {
    ccDrawColor4F(.05, .05, .9, 1);
}

@end
