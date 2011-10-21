//
//  TriLaser.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/21/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "TriLaser.h"
#import "Bullet.h"

@implementation TriLaser

+ (float)defaultSpeed {
    return 3;  
}

- (NSArray *)newBulletsForLocation:(CGPoint)location direction:(NSInteger)direction {
    Bullet *b = [[[Bullet alloc] initWithLocation:location velocity:CGPointMake(0,direction * self.speed)] autorelease];
    Bullet *b2 = [[[Bullet alloc] initWithLocation:location velocity:CGPointMake(-2,direction * self.speed)] autorelease];
    Bullet *b3 = [[[Bullet alloc] initWithLocation:location velocity:CGPointMake(2,direction * self.speed)] autorelease];        
    return [NSArray arrayWithObjects:b, b2, b3, nil];
}

@end