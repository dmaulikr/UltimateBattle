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
@synthesize identifier;
@synthesize launchSpeed;
@synthesize sprite;

-(id)copyWithZone:(NSZone *)zone {
    // We'll ignore the zone for now
    Bullet *another = [[Bullet alloc] init];
    another.vel = self.vel;
    another.l = self.l;
    another.finished = self.finished;
    another.radius = self.radius;
    another.identifier = self.identifier;
    another.launchSpeed = self.launchSpeed;
    
    return another;
}


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
        self.radius = 4;
        self.sprite = [CCSprite spriteWithFile:@"ic_text_dot.png" rect:CGRectMake(0, 0, 16, 16)];
    }
    
    return self;
}

- (void)updateLocation {
    self.l = CombinedPoint(self.l, self.vel);
    if (!CGRectContainsPoint([self boundaryFrame], self.l)) {
        self.finished = YES;
    }
    if (self.sprite) {
        self.sprite.position = self.l;
    }
}

- (void)tick {
    [self updateLocation];
}

- (BOOL)isColliding:(Bullet *)b {
    return GetDistance(self.l, b.l) < self.radius + b.radius;
}

- (void)dealloc {
    [sprite removeFromParentAndCleanup:YES];
    self.sprite = nil;
    [super dealloc];
}

@end