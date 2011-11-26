//
//  SplitLaser.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/21/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "SplitLaser.h"
#import "Bullet.h"
#import "VRGeometry.h"

@implementation SplitLaser

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    Bullet *b   = [[[Bullet alloc] initWithLocation:location velocity:CGPointMake(0, direction)] autorelease];
    Bullet *b2  = [[[Bullet alloc] initWithLocation:location velocity:CGPointMake(0, direction)] autorelease];
    
    CGPoint t1 = CGPointMake(location.x-(direction * self.speed), location.y+(direction * 2 *self.speed));
    b.vel = GetAngle(location, t1);
    b.vel = MultipliedPoint(b.vel, self.speed);
    
    CGPoint t2 = CGPointMake(location.x+(direction * self.speed), location.y+(direction * 2 *self.speed));
    b2.vel = GetAngle(location, t2);
    b2.vel = MultipliedPoint(b2.vel, self.speed);
    
    return [NSArray arrayWithObjects:b, b2, nil];
}

@end
