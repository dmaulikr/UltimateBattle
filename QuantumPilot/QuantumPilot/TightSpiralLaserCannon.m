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

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    TightSpiralLaser *b1 = [[TightSpiralLaser alloc] initWithLocation:ccp(location.x - 15, location.y) velocity:ccp(2, [self speed] * direction) centerX:location.x];
    TightSpiralLaser *b2 = [[TightSpiralLaser alloc] initWithLocation:ccp(location.x + 15, location.y) velocity:ccp(-2, [self speed] * direction) centerX:location.x];
    
    return @[b1, b2];
}

+ (void)setDrawColor {
    //ccDrawColor4F(.3, .7, .65, 1);
    ccDrawColor4F(0, 1, 1, 1);
}

@end
