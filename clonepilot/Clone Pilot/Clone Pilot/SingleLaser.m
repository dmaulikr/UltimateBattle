//
//  SingleLaser.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/15/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "SingleLaser.h"
#import "Bullet.h"

@implementation SingleLaser

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    Bullet *b = [[[Bullet alloc] initWithLocation:location velocity:CGPointMake(0,direction)] autorelease];
    return [NSArray arrayWithObject:b];
}

@end
