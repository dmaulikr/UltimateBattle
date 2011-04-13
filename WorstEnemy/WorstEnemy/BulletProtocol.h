//
//  BulletProtocol.h
//  WorstEnemy
//
//  Created by Jonathan Birkholz on 4/12/11.
//  Copyright 2011 Pursuit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol BulletProtocol <NSObject>

@property (nonatomic, retain) CCSprite *sprite;
@property (nonatomic, retain) id trail;

-(id) initWithStart:(CGPoint) start withVelocity:(CGPoint) velocity;
-(void) addToLayer:(CCLayer *) layer;
-(void) removeFromLayer:(CCLayer *) layer;
-(void) createTrail;

-(CGRect) getRect;

@end
