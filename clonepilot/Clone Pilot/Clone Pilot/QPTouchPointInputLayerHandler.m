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

- (void)addHandler:(QPInputHandler *)handler {
    [self.handlers addObject:handler];
}

- (void)execute {
    for (QPInputHandler *ih in self.handlers) {
        
    }
}

- (void)dealloc {
    [handlers release];
    [super dealloc];
}

@end
