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

- (id)init {
    self = [super init];
    if (self) {
        self.l = CGPointMake(384, 300);
        self.moves = [NSMutableArray array];
        self.living = YES;
        self.radius = 15;
    }
    
    return self;
}

- (void)dealloc {
    [moves release];
    [super dealloc];
}

@end
