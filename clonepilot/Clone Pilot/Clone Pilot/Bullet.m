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
@synthesize showDefaultColor;

-(id)copyWithZone:(NSZone *)zone {
    Bullet *another = [[Bullet alloc] init];
    another.vel = self.vel;
    another.l = self.l;
    another.finished = self.finished;
    another.radius = self.radius;
    another.identifier = self.identifier;
    another.launchSpeed = self.launchSpeed;
    another.showDefaultColor = NO;
    
    return another;
}

+ (void)bulletLoop:(NSMutableArray *)bullets {
    NSMutableArray *removableBullets = [NSMutableArray array];
    
    for (Bullet *b in bullets) {
        if (b.finished) {
            [removableBullets addObject:b];
        }
    }
    
    for (Bullet *b in removableBullets) {
        [b removeFromParentAndCleanup:YES];
    }
    
    [bullets removeObjectsInArray:removableBullets];
    
    for (Bullet *b in bullets) {
        [b tick];
    }
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
        self.radius = 3;
    }
    
    return self;
}

- (void)updateLocation {
    self.l = CombinedPoint(self.l, self.vel);
    if (!CGRectContainsPoint([self boundaryFrame], self.l)) {
        self.finished = YES;
    }
}

- (void)showCustomColor {
    
}

- (void)setDrawingColor {
    if (self.showDefaultColor) {
        glColor4f(1, 1, 1, 1.0);
    } else {
        [self showCustomColor];
    }
}

- (void)draw {
    [self setDrawingColor];
    ccDrawLine(self.l, CombinedPoint(self.l, self.vel));
}

- (void)tick {
    [self updateLocation];
}

- (BOOL)isColliding:(Bullet *)b {
    return GetDistance(self.l, b.l) < self.radius + b.radius;
}

- (void)dealloc {
    [super dealloc];
}

@end