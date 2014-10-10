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
    QuadLaser *ll = [[[QuadLaser alloc] initWithLocation:location velocity:ccp(-.4 * [self speed], .85 * direction * [self speed])] autorelease];
    CloseQuadLaser *lr = [[[CloseQuadLaser alloc] initWithLocation:location velocity:ccp(-.15 * [self speed], .85 * direction * [self speed])] autorelease];
    QuadLaser *rl = [[[QuadLaser alloc] initWithLocation:location velocity:ccp(.4 * [self speed], .85 * direction * [self speed])] autorelease];
    CloseQuadLaser *rr = [[[CloseQuadLaser alloc] initWithLocation:location velocity:ccp(.15 * [self speed], .85 * direction * [self speed])] autorelease];
    
    return @[ll, lr, rl, rr];
}

+ (void)setDrawColor {
    ccDrawColor4F(.0, .0, 1, 1); //.05, .05, .9
}

@end
