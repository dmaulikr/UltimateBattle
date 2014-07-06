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

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    SplitLaser *l = [[[SplitLaser alloc] initWithLocation:location velocity:ccp(-[self speed] * .25, [self speed] * direction * .75)] autorelease];
    SplitLaser *r = [[[SplitLaser alloc] initWithLocation:location velocity:ccp([self speed] * .25, [self speed] * direction * .75)] autorelease];
    return @[l, r];
}

+ (void)setDrawColor {
    ccDrawColor4F(1, .64, 0, 1);
}

@end
