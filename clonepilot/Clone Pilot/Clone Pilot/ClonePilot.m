//
//  ClonePilot.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/27/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "ClonePilot.h"
#import "Turn.h"
#import "VRGeometry.h"

@implementation ClonePilot
@synthesize l, vel, t, radius;
@synthesize moves;
@synthesize living;
@synthesize weapon;
@synthesize moveIndex;

- (NSString *)description {
    return [NSString stringWithFormat:@"x:%f y:%f vx:%f vy:%f",self.l.x, self.l.y, self.vel.x, self.vel.y];
}

+ (CGPoint)defaultLocation {
    return CGPointMake(384, 300);
}

+ (NSInteger)identifier {
    return 1;
}

- (void)tick {
    if ([self.moves count] > 0) {
    Turn *turn = [self.moves objectAtIndex:self.moveIndex];
    self.vel = turn.vel;
    
    self.l = CombinedPoint(self.l, self.vel);

    self.moveIndex++;
    
    self.moveIndex = 0;
    
    if (self.moveIndex >= [self.moves count]) {
        self.moveIndex = 0;
    }
        
    }
}

- (void)reset {
    self.l = [ClonePilot defaultLocation];
    self.moveIndex = 0;
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
