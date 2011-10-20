//
//  ClonePilot.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/27/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "ClonePilot.h"


@implementation ClonePilot
@synthesize l, vel, t, radius;
@synthesize moves;
@synthesize living;
@synthesize weapon;

- (NSString *)description {
    return [NSString stringWithFormat:@"x:%f y:%f vx:%f vy:%f",self.l.x, self.l.y, self.vel.x, self.vel.y];
}

+ (CGPoint)defaultLocation {
    return CGPointMake(384, 300);
}

- (id)init {
    self = [super init];
    if (self) {
        self.l = [ClonePilot defaultLocation];
        self.moves = [NSMutableArray array];
        self.living = YES;
        self.radius = 15;
    }
    
    return self;
}

- (void)dealloc {
    [moves release];
    [weapon release];
    [super dealloc];
}

@end
