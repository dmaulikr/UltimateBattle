//
//  BulletWall.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 12/7/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "BulletWall.h"
#import "VRGeometry.h"

@implementation BulletWall
@synthesize l, vel, t, radius;

- (CGPoint)defaultLocation {
    return CGPointMake(384, 1024);
}

- (id)initWithLayer:(CCLayer *)layer {
    self = [super init];
    if (self){
        self.l = [self defaultLocation];
        self.vel = CGPointMake(0, -.5);
    }
    return self;
}

- (void)reset {
    self.l = [self defaultLocation];
}

- (void)tick {
    self.l = CombinedPoint(self.l, self.vel);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"x:%f y:%f vx:%f vy:%f",self.l.x, self.l.y, self.vel.x, self.vel.y];
}

@end
