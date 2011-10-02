//
//  ClonePlayer.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "ClonePlayer.h"


@implementation ClonePlayer
@synthesize l;
@synthesize vel;

- (id)initWithLocation:(CGPoint)location {
    self = [super init];
    if (self) {
        self.l = location;
    }
    return self;
}

@end
