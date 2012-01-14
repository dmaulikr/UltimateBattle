//
//  QPTouchPointInputLayerHandler.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 1/14/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import "QPTouchPointInputLayerHandler.h"

@implementation QPTouchPointInputLayerHandler
@synthesize handlers;

- (id)init {
    self = [super init];
    if (self) {
        self.handlers = [NSMutableArray array];
    }
    
    return self;
}

- (void)dealloc {
    [handlers release];
    [super dealloc];
}

@end
