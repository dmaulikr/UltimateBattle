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

@interface ClonePilot : NSObject <VRGameObject> {
    
}

@property (nonatomic, retain) NSMutableArray *moves;
@property (nonatomic, assign) BOOL living;
@property (nonatomic, retain) Weapon *weapon;
@property (nonatomic, assign) NSInteger moveIndex;
@property (nonatomic, assign) id <BulletDelegate> bulletDelegate;
@property (nonatomic, retain) CCSprite *sprite;

+ (CGPoint)defaultLocation;
+ (NSInteger)identifier;

- (void)tick;
- (void)reset;

- (Turn *)currentTurn;

- (id)initWithLayer:(CCLayer *)layer;

- (void)resetSpriteWithLayer:(CCLayer *)layer;

@end