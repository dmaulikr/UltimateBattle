//
//  QuadLaser.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/21/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "QuadLaser.h"
#import "Bullet.h"
#import "VRGeometry.h"

@implementation QuadLaser

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    CGPoint vel1 = GetAngle(location, CGPointMake(location.x - 1,location.y + direction));
    Bullet *b = [[[Bullet alloc] initWithLocation:location velocity:vel1] autorelease];
    
    CGPoint vel2 = GetAngle(location, CGPointMake(location.x - 3,location.y + direction));
    Bullet *b2 = [[[Bullet alloc] initWithLocation:location velocity:vel2] autorelease];
    
    CGPoint vel3 = GetAngle(location, CGPointMake(location.x + 1,location.y + direction));
    Bullet *b3 = [[[Bullet alloc] initWithLocation:location velocity:vel3] autorelease];
    
    CGPoint vel4 = GetAngle(location, CGPointMake(location.x + 3,location.y + direction));
    Bullet *b4 = [[[Bullet alloc] initWithLocation:location velocity:vel4] autorelease];
    
    
    return [NSArray arrayWithObjects:b, b2, b3, b4, nil];
}

@end