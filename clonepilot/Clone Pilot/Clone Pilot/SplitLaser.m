//
//  SplitLaser.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/21/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "SplitLaser.h"
#import "Bullet.h"

@implementation SplitLaser

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    Bullet *b   = [[[Bullet alloc] initWithLocation:location velocity:CGPointMake(0, direction)] autorelease];
    Bullet *b2  = [[[Bullet alloc] initWithLocation:location velocity:CGPointMake(0, direction)] autorelease];
    
    return [NSArray arrayWithObjects:b, b2, nil];
}

@end
