//
//  ClonePilot.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/27/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "ClonePilot.h"


@implementation ClonePilot
@synthesize l, vel, t;
@synthesize moves;

- (id)init {
    self = [super init];
    if (self) {
        self.l = CGPointMake(384, 300);
        self.moves = [NSMutableArray array];
    }
    
    return self;
}

- (void)dealloc {
    [moves release];
    [super dealloc];
}

@end
