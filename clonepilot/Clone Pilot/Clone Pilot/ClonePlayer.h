//
//  ClonePlayer.h
//  Clone Pilot
//
//  Created by Anthony Broussard on 10/2/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VRGameObject.h"
#import "Turn.h"
#import "Bullet.h"
#import "Weapon.h"

@protocol BulletDelegate <NSObject>

- (void)fired;
- (void)addBullet:(Bullet *)b;

@end


@interface ClonePlayer : NSObject <VRGameObject> {
    
}

@property (nonatomic, retain) NSMutableArray *currentMoves;
@property (nonatomic, assign) id <BulletDelegate> bulletDelegate;
@property (nonatomic, retain) Weapon *weapon;
@property (nonatomic, assign) NSInteger health;

- (void)tick;

- (void)fire;
- (void)reset;
- (void)hit:(Bullet *)b;

- (Turn *)currentTurn;
- (NSInteger)identifier;
- (BOOL)isFiring;

+ (ClonePlayer *)samplePlayer;
+ (CGPoint)defaultLocation;

@end
