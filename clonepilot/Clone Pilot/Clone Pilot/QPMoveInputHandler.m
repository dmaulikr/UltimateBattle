//
//  QPMoveInputLayer.m
//  Clone Pilot
//
//  Created by Anthony Broussard on 1/14/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import "QPMoveInputHandler.h"

@implementation QPMoveInputHandler
@synthesize delegate;

- (void)processTouch:(CGPoint)l {
    CGPoint angle = GetAngle(self.l, l);
    [self.delegate QPMoveInputLayer:self
          moveVectorAngleCalculated:angle];
}

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

@end
