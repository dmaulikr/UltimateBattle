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

@protocol BulletDelegate <NSObject>

- (void)addBullet:(Bullet *)b;

@end

@interface ClonePlayer : NSObject <VRGameObject> {
    
}

@property (nonatomic, retain) NSMutableArray *currentMoves;
@property (nonatomic, assign) id <BulletDelegate> bulletDelegate;

- (void)tick;

- (Turn *)currentTurn;
- (void)fire;
- (BOOL)isFiring;
- (void)reset;

+ (ClonePlayer *)samplePlayer;
+ (CGPoint)defaultLocation;

@end
