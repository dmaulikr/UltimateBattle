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

- (id)initWithVelocity:(CGPoint)velocity {
    self = [super init];
    if (self) {
        self.vel = velocity;
    }
    
    return self;
}

- (void)updateLocation {
    self.l = CombinedPoint(self.l, self.vel);
}

- (void)tick {
    [self updateLocation];
}

@end