//
//  QPMoveInputLayer.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 1/14/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QPInputHandler.h"
#import "VRGeometry.h"

@protocol QPMoveInputLayerDelegate;

@interface QPMoveInputHandler : QPInputHandler

@property (nonatomic, assign) id <QPMoveInputLayerDelegate> delegate;

@end

@protocol QPMoveInputLayerDelegate 

- (void)QPMoveInputLayer:(QPMoveInputHandler*)layer moveVectorAngleCalculated:(CGPoint)angle;

@end