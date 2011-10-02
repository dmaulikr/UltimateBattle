//
//  Bullet.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "Bullet.h"
#import "VRGeometry.h"

@implementation Bullet

@synthesize vel;
@synthesize l;
@synthesize finished;

+ (Bullet *)sampleBullet {
    return [[[Bullet alloc] initWithLocation:CGPointMake(100,100) velocity:CGPointMake(0,-3)] autorelease];
}

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity {
    self = [super init];
    if (self) {
        self.l = location;
        self.vel = velocity;
    
    }
    
    return self;
}

- (void)updateLocation {
    self.l = CombinedPoint(self.l, self.vel);
    if (CGRectContainsPoint([self boundaryFrame], self.l)) {
        self.finished = YES;
    }
}

- (void)tick {
    [self updateLocation];
}

@end