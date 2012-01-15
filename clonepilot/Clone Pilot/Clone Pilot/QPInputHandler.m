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
@synthesize moveActive;

- (float)defaultRadius {
    return 40;
}

- (CGPoint)defaultFirePoint {
    return CGPointMake(768-self.radius, 1024-self.radius);
}

- (CGPoint)defaultMovePoint {
    return CGPointMake(self.radius * 1.5, 1024-self.radius*1.5);
}

- (id)init {
    self = [super init];
    if (self) {
        self.radius     = [self defaultRadius];
        self.firePoint  = [self defaultFirePoint];
        self.movePoint  = [self defaultMovePoint];
        self.moveActive = NO;
    }
    return self;
}

- (void)addTouchPoint:(CGPoint)tp {
    if (self.moveActive) {
        [self.delegate fireTapped];        
    } else {
        self.moveActive = YES;
        self.movePoint = tp;
    }
}

- (void)moveTouchPoint:(CGPoint)tp {
    float distance = GetDistance(tp, self.movePoint);
    if (GetDistance(tp, self.firePoint) > self.radius) {
        if (distance > self.radius) {
            distance = self.radius;
        }
        CGPoint angle = GetAngle(self.movePoint, tp);
        float ratio = distance / self.radius;
        [self.delegate movementAngle:angle distanceRatio:ratio];       
    }
}

- (void)endTouchPoint:(CGPoint)tp {
    if (GetDistance(tp, self.movePoint) < GetDistance(tp, self.firePoint)) {
        self.moveActive = NO;
        [self.delegate stopMoving];
    }
}

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

@end
