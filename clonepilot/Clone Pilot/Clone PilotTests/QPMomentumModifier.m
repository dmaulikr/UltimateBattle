//
//  QPMomentumModifier.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 2/11/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import "QPMomentumModifier.h"

@implementation QPMomentumModifier

- (void)addBullets:(NSArray *)bullets ship:(QPShip *)ship {
    for (Bullet *b in bullets) {
        b.vel = CombinedPoint(b.vel, CGPointMake(ship.vel.x * .75, 0));
    }
}

@end
