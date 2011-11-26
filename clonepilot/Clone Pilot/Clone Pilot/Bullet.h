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

@interface Bullet : NSObject <NSCopying> {
    
}

@property (nonatomic, assign) CGPoint vel;
@property (nonatomic, assign) CGPoint l;
@property (nonatomic, assign) BOOL finished;
@property (nonatomic, assign) double radius;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) float launchSpeed;
@property (nonatomic, retain) CCSprite *sprite;

- (id)initWithLocation:(CGPoint)location velocity:(CGPoint)velocity;

- (void)tick;

+ (Bullet *)sampleBullet;

@end
