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

extern int const QP_AcceptableProximityToTarget;

@interface ClonePlayer : NSObject <VRGameObject> {
    
}

@property (nonatomic, retain) NSMutableArray *currentMoves;
@property (nonatomic, assign) id <BulletDelegate> bulletDelegate;
@property (nonatomic, retain) Weapon *weapon;
@property (nonatomic, assign) NSInteger health;
@property (nonatomic, retain) CCSprite *sprite;
@property (nonatomic, assign) float speed;

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

@end
