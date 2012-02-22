//
//  ClonePlayer.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "VRGameObject.h"
#import "Turn.h"
#import "Bullet.h"
#import "Weapon.h"
#import "BulletDelegateProtocol.h"
#import "QPShip.h"

extern int QP_PlayerYDirection;

@interface ClonePlayer : QPShip {
    CGPoint lines[4];
}

@property (nonatomic, assign) id <BulletDelegate> bulletDelegate;
@property (nonatomic, assign) float speed;

- (NSMutableArray *)currentMoves;

- (void)tick;

- (void)fire;
- (void)reset;
- (void)hit:(Bullet *)b;

- (Turn *)currentTurn;
- (NSInteger)identifier;
- (BOOL)isFiring;

+ (ClonePlayer *)samplePlayer;
+ (CGPoint)defaultLocation;

- (void)restart;

- (id)initWithLayer:(CCLayer *)layer;

- (NSString *)locationAndTargetingStatus;

- (BOOL)shipHitByBullet:(Bullet *)b;

@end
