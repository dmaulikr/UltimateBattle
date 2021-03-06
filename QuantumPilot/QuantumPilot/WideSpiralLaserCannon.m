//
//  WideSpiralLaserCannon.m
//  QuantumPilot
//
//  Created by quantum on 29/09/2014.
//
//

#import "WideSpiralLaserCannon.h"
#import "CenterWideSpiralLaser.h"

@implementation WideSpiralLaserCannon

+ (NSArray *)bulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    WideSpiralLaser *b1 = [[[WideSpiralLaser alloc] initWithLocation:ccp(location.x - 15, location.y) velocity:ccp(7, [self speed] * direction) centerX:location.x] autorelease];
    WideSpiralLaser *b2 = [[[WideSpiralLaser alloc] initWithLocation:ccp(location.x + 15, location.y) velocity:ccp(-7, [self speed] * direction) centerX:location.x] autorelease];
    CenterWideSpiralLaser *c = [[[CenterWideSpiralLaser alloc] initWithLocation:ccp(location.x, location.y) velocity:ccp(0, [self speed] * direction) centerX:location.x] autorelease];
    
    return @[b1, b2, c];

}

+ (void)setDrawColor {
    ccDrawColor4F(0, 1, 0, 1);
}


@end
