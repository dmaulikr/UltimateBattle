//
//  Bullet.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VRBoundaryFrame.h"
#import "cocos2d.h"

@interface Bullet : CCNode <NSCopying> {
    
}

@property (nonatomic, assign) CGPoint vel;
@property (nonatomic, assign) CGPoint l;
@property (nonatomic, assign) BOOL finished;
@property (nonatomic, assign) double radius;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) float launchSpeed;
@property (nonatomic, assign) BOOL showDefaultColor;

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity;
- (void)tick;
- (BOOL)isColliding:(Bullet *)b;

+ (Bullet *)sampleBullet;

- (void)setDrawingColor;
- (void)showCustomColor;

@end
