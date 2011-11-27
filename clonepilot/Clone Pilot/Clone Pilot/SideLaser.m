//
//  SideLaser.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 11/9/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "SideLaser.h"
#import "SideLaserBullet.h"

@implementation SideLaser

//+ (float)defaultSpeed {
//    return 3;
//}

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    SideLaserBullet *b = [[[SideLaserBullet alloc] initWithLocation:location velocity:CGPointMake(0, direction * self.speed)] autorelease];
    return [NSArray arrayWithObject:b];    
}

@end
