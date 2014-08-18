//
//  TightSplitLaserCannon.m
//  QuantumPilot
//
//  Created by quantum on 18/07/2014.
//
//


#import "TightSplitLaserCannon.h"
#import "TightSplitLaser.h"

@implementation TightSplitLaserCannon

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    //15, 85
    TightSplitLaser *l = [[[TightSplitLaser alloc] initWithLocation:location velocity:ccp(-[self speed] * .25, [self speed] * direction * .85)] autorelease];
    TightSplitLaser *r = [[[TightSplitLaser alloc] initWithLocation:location velocity:ccp([self speed] * .25, [self speed] * direction * .85)] autorelease];
    return @[l, r];
}

+ (void)setDrawColor {
    ccDrawColor4F(.3, .7, .65, 1);
}


@end
