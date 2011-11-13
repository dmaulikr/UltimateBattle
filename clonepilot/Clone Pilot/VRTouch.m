//
//  VRTouch.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 11/13/11.
//  Copyright (c) 2011 ChaiONE. All rights reserved.
//

#import "VRTouch.h"

@implementation VRTouch

- (id)initWithLocation:(CGPoint)location {
    self = [super init];
    if (self) {
        self.l = location;
    }
    
    return self;
}

@synthesize l;

@end