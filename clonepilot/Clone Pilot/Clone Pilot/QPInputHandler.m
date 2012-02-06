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
@synthesize movementThreshhold;

- (float)defaultRadius {
    return 40;
}

- (float)defaultMovementThreshhold {
    return 20;
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
        self.movementThreshhold = [self defaultMovementThreshhold];
        self.moveActive = NO;
    }
    return self;
}

- (void)addTouchPoint:(CGPoint)tp {
    if (self.moveActive) {
        self.firePoint = tp;
        [self.delegate fireTapped];        
    } else {
        self.moveActive = YES;
        self.movePoint = tp;
    }
}

- (void)moveTouchPoint:(CGPoint)tp {
    float distance = GetDistance(tp, self.movePoint);
    if (GetDistance(tp, self.firePoint) > 2 * self.radius && GetDistance(tp, self.movePoint) < 4 * self.radius) {
        if (distance > self.radius) {
            distance = self.radius;
        }
        if (distance > [self movementThreshhold]) {
            CGPoint angle = GetAngle(self.movePoint, tp);
            float ratio = distance / self.radius;
            [self.delegate movementAngle:angle distanceRatio:ratio];       
        } else {
            [self.delegate movementAngle:CGPointZero distanceRatio:1];
        }
    }
}

- (void)endTouchPoint:(CGPoint)tp {
    float moveDistance = GetDistance(tp, self.movePoint);
    float fireDistance = GetDistance(tp, self.firePoint);
    if (moveDistance < fireDistance) {
        self.moveActive = NO;
        [self.delegate stopMoving];
    } else {
//        NSLog(@"move: %f  fire: %f", moveDistance, fireDistance);
    }
    
    self.firePoint = CGPointMake(384, -5000);    
}

- (void)endAllTouches {
    self.moveActive = NO;
}

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

@end
