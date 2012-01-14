//
//  QPMoveInputLayer.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 1/14/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QPInputLayer.h"
#import "VRGeometry.h"

@protocol QPMoveInputLayerDelegate;

@interface QPMoveInputLayer : QPInputLayer

@property (nonatomic, assign) id <QPMoveInputLayerDelegate> delegate;

@end

@protocol QPMoveInputLayerDelegate 

- (void)QPMoveInputLayer:(QPMoveInputLayer*)layer moveVectorAngleCalculated:(CGPoint)angle;

@end