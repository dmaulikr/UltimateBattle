//
//  WideTriLaser.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 1/15/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import "WideTriLaser.h"
#import "TriLaserBullet.h"

@implementation WideTriLaser

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    TriLaserBullet *b = [[[TriLaserBullet alloc] initWithLocation:location velocity:CGPointMake(0,direction * self.speed)] autorelease];
    TriLaserBullet *b2 = [[[TriLaserBullet alloc] initWithLocation:location velocity:CGPointMake(-3,direction * self.speed)] autorelease];
    TriLaserBullet *b3 = [[[TriLaserBullet alloc] initWithLocation:location velocity:CGPointMake(3,direction * self.speed)] autorelease];        
    return [NSArray arrayWithObjects:b, b2, b3, nil];
}

- (void)setDrawColor {
    glColor4f(.8, .2, .2, 1.0);
}


@end
