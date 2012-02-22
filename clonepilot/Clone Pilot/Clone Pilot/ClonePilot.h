//
//  ClonePilot.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/27/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VRGameObject.h"
#import "Weapon.h"
#import "Turn.h"
#import "BulletDelegateProtocol.h"
#import "cocos2d.h"
#import "QPShip.h"

extern int QP_ClonePilotYDirection;

@interface ClonePilot : QPShip {
    CGPoint lines[4];
    NSInteger _moveDirection;
}

@property (nonatomic, assign) NSInteger moveIndex;
@property (nonatomic, assign) id <BulletDelegate> bulletDelegate;

+ (CGPoint)defaultLocation;
+ (NSInteger)identifier;

- (void)tick;
- (void)reset;

- (Turn *)currentTurn;

- (id)initWithLayer:(CCLayer *)layer;

- (void)ceaseLiving;

- (BOOL)shipHitByBullet:(Bullet *)b;

@end