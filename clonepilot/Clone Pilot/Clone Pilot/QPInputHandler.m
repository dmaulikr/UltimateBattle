//
//  QPInputLayer.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 1/13/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import "QPInputHandler.h"
#import "VRGeometry.h"

@implementation QPInputHandler
@synthesize l;
@synthesize radius;
@synthesize firePoint;
@synthesize movePoint;
@synthesize delegate;

- (float)defaultRadius {
    return 100;
}

- (CGPoint)defaultFirePoint {
    return CGPointMake(768-self.radius, 1024-self.radius);
}

- (CGPoint)defaultMovePoint {
    return CGPointMake(self.radius, 1024-self.radius);
}

- (id)init {
    self = [super init];
    if (self) {
        self.radius     = [self defaultRadius];
        self.firePoint  = [self defaultFirePoint];
        self.movePoint  = [self defaultMovePoint];
    }
    return self;
}

- (void)addTouchPoint:(CGPoint)tp {
    if (GetDistance(tp, self.firePoint) < self.radius) {
        [self.delegate fireTapped];
    } else if (GetDistance(tp, self.movePoint) < self.radius) {
        CGPoint angle = GetAngle(self.movePoint, tp);
        [self.delegate movementAngle:angle];
    }
}

- (void)moveTouchPoint:(CGPoint)tp {
    if (GetDistance(tp, self.movePoint) < self.radius) {
        CGPoint angle = GetAngle(self.movePoint, tp);
        [self.delegate movementAngle:angle];
    }
}

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

@end
