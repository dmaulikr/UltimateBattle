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
@synthesize radius;

+ (Bullet *)sampleBullet {
    return [[[Bullet alloc] initWithLocation:CGPointMake(100,100) velocity:CGPointMake(0,-3)] autorelease];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"x:%f y:%f vx:%f vy:%f",self.l.x, self.l.y, self.vel.x, self.vel.y];
}

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity {
    self = [super init];
    if (self) {
        self.l = location;
        self.vel = velocity;
        self.radius = 15;
    
    }
    
    return self;
}

- (void)updateLocation {
    self.l = CombinedPoint(self.l, self.vel);
    if (!CGRectContainsPoint([self boundaryFrame], self.l)) {
        self.finished = YES;
    }
}

- (void)tick {
    [self updateLocation];
}

@end