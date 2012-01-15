//
//  QPInputLayer.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 1/13/12.
//  Copyright (c) 2012 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QPInputHandlerDelegate <NSObject>

- (void)movementAngle:(CGPoint)angle;
- (void)fireTapped;

@end

@interface QPInputHandler : NSObject

@property (nonatomic, assign) CGPoint l;
@property (nonatomic, assign) float radius;
@property (nonatomic, assign) CGPoint firePoint;
@property (nonatomic, assign) CGPoint movePoint;
@property (nonatomic, assign) id <QPInputHandlerDelegate> delegate;

- (void)addTouchPoint:(CGPoint)tp;
- (void)moveTouchPoint:(CGPoint)tp;

@end
